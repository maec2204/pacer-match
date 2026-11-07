# Pacer Match

App móvil (Flutter + Supabase) que conecta corredores por ritmo, distancia, fecha y zona para entrenar juntos. Antes de trabajar, lee `docs/proyecto/reglas-de-sesion.md` y síguelo.

<!-- Máx. 200 líneas: el detalle vive en docs/ y vault/. -->

## Qué va en este repo
- `docs/proyecto/`: el plan y los documentos del proyecto (contexto, plan del MVP, fases, visión, bitácora). Mandan sobre cualquier copia (por ejemplo, la del Project de claude.ai).
- `vault/`: las notas del proyecto, para personas y agentes. Se carga por capas: `vault/00-mapa.md` siempre; la nota de dominio al tocar su código; las decisiones, por búsqueda.
- `app/` (desde B1): la app Flutter.
- `supabase/` (desde S3): migraciones, tests SQL y Edge Functions.
- `scripts/`: utilidades del repo. `md_a_html.py` crea la copia en Google Docs de un documento de `docs/proyecto/`; `docs_sugerir.py` le aplica las versiones siguientes como sugerencias.

## Qué no va
- El spec del PO: vive en su Google Doc y se comenta allí. Lo decidido se copia aquí (`vision.md` o un ADR).
- Secretos y claves (Supabase, Firebase, Google Maps, Didit): van en variables de entorno o en el gestor de secretos del CI, nunca en git.

## Siempre
- Una sesión, una función. Si aparece trabajo de otra, se anota en `docs/proyecto/fases.md` (regla 9) y no se hace.
- No inventar casos borde ni requisitos. Si falta información, una sola pregunta.
- El punto de encuentro exacto nunca sale de la base de datos hacia quien no tiene match: lo garantiza RLS, no la app.

## Agent skills

### Issue tracker

Los tickets viven en GitHub Issues de `maec2204/pacer-match` (CLI `gh`); `docs/proyecto/fases.md` sigue siendo el plan. See `docs/agents/issue-tracker.md`.

### Triage labels

Etiquetas por defecto: `needs-triage`, `needs-info`, `ready-for-agent`, `ready-for-human`, `wontfix`. See `docs/agents/triage-labels.md`.

### Domain docs

Un solo contexto: glosario en `vault/glosario.md` y ADRs en `vault/decisiones/`. See `docs/agents/domain.md`.
