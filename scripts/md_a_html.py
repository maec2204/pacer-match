#!/usr/bin/env python3
"""Convierte un documento Markdown del repo en HTML para importarlo como Google Doc.

El repo es la fuente de verdad: la copia en Google Docs se genera con este script
y nunca se edita a mano. Uso:

    python3 scripts/md_a_html.py docs/proyecto/vision.md > /tmp/vision.html

Luego se sube con Google Drive (create_file, contentMimeType text/html), que
convierte encabezados, listas, tablas, negritas y enlaces a formato nativo.
Drive no puede reemplazar el contenido de un doc: cada versión nueva (v0.2…) es
un doc nuevo, y el anterior se renombra "(reemplazada por vX.Y)". El enlace
vigente se anota en el frontmatter del .md (campo copia_po).

Qué hace:
- Quita el frontmatter YAML (metadatos internos del repo).
- Quita los bloques ```mermaid (Google Docs no los dibuja; la tabla de capas
  del documento cubre la misma información).
- Convierte URLs sueltas en enlaces.
- Da bordes a las tablas. (Google Docs ignora page-break-inside al importar; si
  una fila se parte entre páginas, se pasa el doc a formato sin páginas.)
- Falla si un párrafo o una celda tiene dos "$": al importar, Google Docs
  convierte el texto entre ellos en una ecuación (pasó con "US$99 ... US$25").
  Se arregla en el .md, separando los montos en celdas o frases distintas.

Requiere: pip install markdown
"""
import re
import sys

import markdown


def revisar_dolares(texto: str) -> list[str]:
    malos = []
    for n, linea in enumerate(texto.splitlines(), 1):
        partes = linea.split("|") if linea.lstrip().startswith("|") else [linea]
        if any(p.count("$") >= 2 for p in partes):
            malos.append(f"línea {n}: {linea.strip()[:90]}")
    return malos


def convertir(texto: str) -> str:
    texto = re.sub(r"\A---\n.*?\n---\n", "", texto, flags=re.S)
    texto = re.sub(r"```mermaid\n.*?```\n?", "", texto, flags=re.S)
    texto = re.sub(r"(?<![<(\[])(https?://[^\s<>|)]+)", r"<\1>", texto)
    # GitHub acepta una lista pegada al párrafo anterior; python-markdown no.
    texto = re.sub(r"(?m)^(?!\s*(?:[-*]|\d+\.)\s)(\S.*)\n(?=(?:[-*]|\d+\.)\s)", r"\1\n\n", texto)
    titulo = next((l[2:].strip() for l in texto.splitlines() if l.startswith("# ")), "Documento")
    cuerpo = markdown.markdown(texto, extensions=["tables", "sane_lists"])
    cuerpo = cuerpo.replace("<table>", '<table border="1" cellpadding="4">')
    cuerpo = re.sub(r">\s*\n\s*<", "><", cuerpo)
    return (
        '<!doctype html><html><head><meta charset="utf-8">'
        f"<title>{titulo}</title></head><body>{cuerpo}</body></html>\n"
    )


if __name__ == "__main__":
    if len(sys.argv) != 2:
        sys.exit("uso: md_a_html.py <archivo.md>")
    with open(sys.argv[1], encoding="utf-8") as f:
        fuente = f.read()
    malos = revisar_dolares(fuente)
    if malos:
        sys.exit("Dos '$' en un mismo párrafo o celda (Google Docs los vuelve ecuación):\n  "
                 + "\n  ".join(malos))
    sys.stdout.write(convertir(fuente))
