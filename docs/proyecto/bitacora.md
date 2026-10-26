# Bitácora

<!-- Una entrada por sesión, la más nueva arriba. Máx. 8 líneas. Formato:

## AAAA-MM-DD · SN · <función>
- Qué se hizo, con enlaces a archivos, commits o MRs.
- Decisiones cerradas (y en qué documento quedaron).
- Descubierto: lo que cambia sesiones siguientes.
- Pendientes movidos: <qué> → SN, o → "Pendientes sin sesión". Nunca el pendiente suelto aquí.
- Excepción (si la hubo): qué regla se saltó y por qué.
-->

## 2026-10-25 · S2 · Cerrar alcance con el PO
- Leídos los 16 comentarios del PO en la visión v0.1; publicada la [v0.2](https://docs.google.com/document/d/1BLJyRg8du7J6fFNlXnUyCbm2pbpTGDvPjG3Jv4cs2Jc/edit), que los responde en el texto; la v0.1 quedó renombrada como reemplazada.
- Decisiones: mercado Venezuela, Caracas; suscripción por conexiones con primer match gratis y, en el MVP, pantalla de planes sin cobro (ADR-0005); Didit para crear y solicitar (ADR-0004); sin diseñador, con referencias de Mobbin; fecha de 5–7 semanas a ~20 h/semana.
- Descubierto: cobrar dentro de la app exige el sistema de cada tienda, y en Venezuela Apple solo acepta tarjetas. Estimado total: 94–140 h (+4–6 h de pantalla de planes, +6–10 h de componentes visuales propios).
- Pendientes movidos: D-PO7 (cuentas de tienda) → B5; biblioteca de imágenes → B2; D-PO12 (precios) y D6 (cobro en Venezuela) → "Pendientes sin sesión".

## 2026-10-18 · S0 · Iniciar el proyecto
- 16 comentarios en el [spec del PO](https://docs.google.com/document/d/1oZ5anU2qvN136UN4q90sNrJSEVbRNKRBnlcPZb9QKf0/edit): verificación de identidad, mapas, monetización, arquitectura, tiendas, seguridad del punto de encuentro y más.
- Llenados `contexto.md`, `plan.md` (estimado 84–124 h y costos), `fases.md`, `vision.md`, glosario, `CLAUDE.md` y `README.md`.
- Decisiones: Flutter + Supabase Free en el MVP (ADR-0001); producto en Supabase Pro con migración por piezas a AWS (ADR-0002); tracking fuera del MVP (ADR-0003).
- Descubierto: Google Maps SDK móvil sin map ID cuesta US$0; Firebase Storage exige Blaze desde feb-2026; ya existe la app "Pacer" de Pacer Health.
- Visión publicada para el PO como [Google Doc v0.1](https://docs.google.com/document/d/16gY_llUEUO-UbaJUMU7ppwtJaawN02LGoh0xwBLNlS8/edit), generado con `scripts/md_a_html.py`. Pendientes movidos: revisión legal y búsqueda de marcas → "Pendientes sin sesión".
- Ajuste: B1 no depende de S3 ni del PO; quedó dividido en S5–S8 para arrancar en Claude Code mientras el PO responde.
- Excepción (regla 2): la sesión juntó tres funciones (S0, comentarios al spec y visión/stack) porque Moisés lo pidió así.
