# Bitácora

<!-- Una entrada por sesión, la más nueva arriba. Máx. 8 líneas. Formato:

## AAAA-MM-DD · SN · <función>
- Qué se hizo, con enlaces a archivos, commits o MRs.
- Decisiones cerradas (y en qué documento quedaron).
- Descubierto: lo que cambia sesiones siguientes.
- Pendientes movidos: <qué> → SN, o → "Pendientes sin sesión". Nunca el pendiente suelto aquí.
- Excepción (si la hubo): qué regla se saltó y por qué.
-->

## 2026-10-25 · Alcance · Dorsales en el MVP
- La PO pidió gamificación en un comentario sobre la visión; la v0.2 la tenía en el producto v1. Moisés la pasa al MVP.
- Diseño: dorsales coleccionables en `DESIGN.md` (PR #1) y en el prototipo [Pista viva](https://claude.ai/artifact/3WgeXhnFs91ZTeQC51YWH5).
- Nuevo bloque B9 (8–12 h, estimado) en `fases.md` y `plan.md`; el total pasa a 92–136 h.
- Pendientes movidos: llevar la visión v0.2 del Google Doc al repo con los dorsales en el MVP → S2.
- Excepción (regla 2): cambio de alcance fuera de una sesión del plan, pedido por Moisés.

## 2026-10-18 · S0 · Iniciar el proyecto
- 16 comentarios en el [spec del PO](https://docs.google.com/document/d/1oZ5anU2qvN136UN4q90sNrJSEVbRNKRBnlcPZb9QKf0/edit): verificación de identidad, mapas, monetización, arquitectura, tiendas, seguridad del punto de encuentro y más.
- Llenados `contexto.md`, `plan.md` (estimado 84–124 h y costos), `fases.md`, `vision.md`, glosario, `CLAUDE.md` y `README.md`.
- Decisiones: Flutter + Supabase Free en el MVP (ADR-0001); producto en Supabase Pro con migración por piezas a AWS (ADR-0002); tracking fuera del MVP (ADR-0003).
- Descubierto: Google Maps SDK móvil sin map ID cuesta US$0; Firebase Storage exige Blaze desde feb-2026; ya existe la app "Pacer" de Pacer Health.
- Visión publicada para el PO como [Google Doc v0.1](https://docs.google.com/document/d/16gY_llUEUO-UbaJUMU7ppwtJaawN02LGoh0xwBLNlS8/edit), generado con `scripts/md_a_html.py`. Pendientes movidos: revisión legal y búsqueda de marcas → "Pendientes sin sesión".
- Ajuste: B1 no depende de S3 ni del PO; quedó dividido en S5–S8 para arrancar en Claude Code mientras el PO responde.
- Excepción (regla 2): la sesión juntó tres funciones (S0, comentarios al spec y visión/stack) porque Moisés lo pidió así.
