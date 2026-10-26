"""Aplica una nueva versión de un documento del repo sobre su Google Doc, como sugerencias.

El PO ve un solo Google Doc por documento (enlace en el campo copia_po del .md).
La primera versión se crea con scripts/md_a_html.py. Las siguientes se aplican
en ese mismo doc como sugerencias, para que conserve su enlace, sus comentarios y
el historial, y el PO acepte o rechace cada cambio.

Uso:
    1. Leer el doc con el conector de Google Docs (read_doc) y guardar el JSON.
    2. Escribir la lista de cambios (CHANGES) en un .py: solo las palabras que
       cambian, nunca el párrafo entero si no hace falta.
    3. python3 scripts/docs_sugerir.py doc.json cambios.py lote.json
    4. Enviar lote.json con update_doc y writeControl {"writeMode": "SUGGEST",
       "requiredRevisionId": <revisionId del paso 1>}.
    5. Releer el doc y comprobar que el texto aceptado coincide con el .md.

Las filas nuevas de tabla se insertan antes (insertTableRow, también en modo
sugerencia) y se llenan con "cell_fill" tras releer. El script se niega a tocar
texto que esté dentro de una sugerencia pendiente del PO.

Detalle de los cambios admitidos:
Uso interno: python3 scripts/docs_sugerir.py <doc.json> <cambios.py> <lote.json>
changes.py defines CHANGES: list of dicts:
  {"op": "replace", "find": str, "new": str, "scope": None | (table, row, col), "bold": None|bool, "nth": 0}
  {"op": "insert_after"|"insert_before", "find": str, "new": str, "scope": ..., "bold": ...}
  {"op": "cell_fill", "scope": (table,row,col), "new": str, "bold": None|bool}   # empty cell
  {"op": "append_para", "find": str, "new": str}   # insert "\n"+new at end of paragraph containing find
Positions are computed from doc.json; requests are sorted from highest index to lowest.
"""
import json
import sys


def u16(s):
    return len(s.encode("utf-16-le")) // 2


def load(path):
    d = json.load(open(path))
    if "content" in d and "tabs" not in d:
        d = d["content"]
    return d


def paragraphs(doc):
    """Yield dicts: start, end, text, runs[(start,end,content,bold,sugg)], scope."""
    out = []
    tables = []

    def walk(content, scope):
        for el in content:
            if "paragraph" in el:
                runs = []
                for r in el["paragraph"]["elements"]:
                    tr = r.get("textRun")
                    if not tr:
                        continue
                    sugg = bool(tr.get("suggestedInsertionIds") or tr.get("suggestedDeletionIds"))
                    runs.append((r["startIndex"], r["endIndex"], tr["content"],
                                 bool(tr.get("textStyle", {}).get("bold")), sugg))
                out.append({"start": el["startIndex"], "end": el["endIndex"],
                            "text": "".join(r[2] for r in runs), "runs": runs, "scope": scope,
                            "bullet": "bullet" in el["paragraph"]})
            elif "table" in el:
                ti = len(tables)
                tables.append(el)
                for ri, row in enumerate(el["table"]["tableRows"]):
                    for ci, cell in enumerate(row["tableCells"]):
                        walk(cell["content"], (ti, ri, ci))

    walk(doc["tabs"][0]["documentTab"]["body"]["content"], None)
    return out, tables


def offset_to_index(p, off):
    """Map a UTF-16 offset within paragraph text to a document index."""
    acc = 0
    for (s, e, c, b, sg) in p["runs"]:
        L = u16(c)
        if off <= acc + L:
            return s + (off - acc)
        acc += L
    raise ValueError("offset out of range")


def style_at(p, idx):
    for (s, e, c, b, sg) in p["runs"]:
        if s <= idx < e:
            return b, sg
    return None, False


def find(paras, text, scope, nth=0):
    hits = []
    for p in paras:
        if scope is not None and p["scope"] != tuple(scope):
            continue
        t = p["text"]
        i = t.find(text)
        while i >= 0:
            s = offset_to_index(p, u16(t[:i]))
            e = s + u16(text)
            hits.append((p, s, e))
            i = t.find(text, i + 1)
    if scope is None and len(hits) != 1 and nth == 0:
        raise SystemExit(f"'{text[:60]}' matches {len(hits)} times; give scope or nth")
    if not hits:
        raise SystemExit(f"'{text[:60]}' not found in scope {scope}")
    p, s, e = hits[nth]
    for (rs, re_, c, b, sg) in p["runs"]:
        if sg and rs < e and s < re_:
            raise SystemExit(f"'{text[:60]}' overlaps a pending suggestion")
    return p, s, e


def build(doc, changes):
    paras, tables = paragraphs(doc)
    ops = []  # (position, [requests])
    for ch in changes:
        op = ch["op"]
        new = ch.get("new", "")
        L = u16(new)
        if op == "cell_fill":
            cand = [p for p in paras if p["scope"] == tuple(ch["scope"])]
            p = cand[0]
            pos = p["start"]
            inherited = None
        elif op == "append_para":
            p, s, e = find(paras, ch["find"], ch.get("scope"), ch.get("nth", 0))
            pos = p["end"] - 1
            new = "\n" + new
            L = u16(new)
            inherited = style_at(p, pos - 1)[0]
        else:
            p, s, e = find(paras, ch["find"], ch.get("scope"), ch.get("nth", 0))
            if "sub" in ch:
                k = ch["find"].index(ch["sub"])
                s = s + u16(ch["find"][:k])
                e = s + u16(ch["sub"])
            if op == "replace":
                pos = s
            elif op == "insert_after":
                pos = e
            elif op == "insert_before":
                pos = s
            else:
                raise SystemExit(op)
            prev = pos - 1 if pos > p["start"] else pos
            inherited = style_at(p, prev)[0]
        reqs = []
        if L:
            reqs.append({"insertText": {"location": {"index": pos}, "text": new}})
            want = ch.get("bold")
            if want is not None and bool(inherited) != want:
                rs = pos + (1 if op == "append_para" else 0)
                reqs.append({"updateTextStyle": {"range": {"startIndex": rs, "endIndex": pos + L},
                                                 "textStyle": {"bold": want}, "fields": "bold"}})
        if op == "replace":
            reqs.append({"deleteContentRange": {"range": {"startIndex": s + L, "endIndex": e + L}}})
        ops.append((pos, ch, reqs))
    # highest position first; for equal positions keep declaration order reversed
    ops.sort(key=lambda x: x[0], reverse=True)
    seen = {}
    for pos, ch, _ in ops:
        if pos in seen:
            raise SystemExit(f"two changes at index {pos}: {seen[pos]['find'] if 'find' in seen[pos] else seen[pos]} / {ch.get('find')}")
        seen[pos] = ch
    out = []
    for _, _, reqs in ops:
        out.extend(reqs)
    return out


if __name__ == "__main__":
    doc = load(sys.argv[1])
    ns = {}
    exec(open(sys.argv[2], encoding="utf-8").read(), ns)
    reqs = build(doc, ns["CHANGES"])
    json.dump({"requests": reqs, "revisionId": doc["revisionId"]}, open(sys.argv[3], "w"), ensure_ascii=False)
    print(len(reqs), "requests; revision", doc["revisionId"][:16])
