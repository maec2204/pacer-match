# Bitácora

<!-- Una entrada por sesión, la más nueva arriba. Máx. 8 líneas. Formato:

## AAAA-MM-DD · SN · <función>
- Qué se hizo, con enlaces a archivos, commits o MRs.
- Decisiones cerradas (y en qué documento quedaron).
- Descubierto: lo que cambia sesiones siguientes.
- Pendientes movidos: <qué> → SN, o → "Pendientes sin sesión". Nunca el pendiente suelto aquí.
- Excepción (si la hubo): qué regla se saltó y por qué.
-->

## 2026-10-18 · S0 · Iniciar el proyecto
- 16 comentarios en el [spec del PO](https://docs.google.com/document/d/1oZ5anU2qvN136UN4q90sNrJSEVbRNKRBnlcPZb9QKf0/edit): verificación de identidad, mapas, monetización, arquitectura, tiendas, seguridad del punto de encuentro y más.
- Llenados `contexto.md`, `plan.md` (estimado 84–124 h y costos), `fases.md`, `vision.md`, glosario, `CLAUDE.md` y `README.md`.
- Decisiones: Flutter + Supabase Free en el MVP (ADR-0001); producto en Supabase Pro con migración por piezas a AWS (ADR-0002); tracking fuera del MVP (ADR-0003).
- Descubierto: Google Maps SDK móvil sin map ID cuesta US$0; Firebase Storage exige Blaze desde feb-2026; ya existe la app "Pacer" de Pacer Health.
- Pendientes movidos: compartir la visión con el PO → S1; revisión legal y búsqueda de marcas → "Pendientes sin sesión".
- Excepción (regla 2): la sesión juntó tres funciones (S0, comentarios al spec y visión/stack) porque Moisés lo pidió así.
