# Bitácora

<!-- Una entrada por sesión, la más nueva arriba. Máx. 8 líneas. Formato:

## AAAA-MM-DD · SN · <función>
- Qué se hizo, con enlaces a archivos, commits o MRs.
- Decisiones cerradas (y en qué documento quedaron).
- Descubierto: lo que cambia sesiones siguientes.
- Pendientes movidos: <qué> → SN, o → "Pendientes sin sesión". Nunca el pendiente suelto aquí.
- Excepción (si la hubo): qué regla se saltó y por qué.
-->

## 2026-10-25 · H5 del harness · Dirección visual
- Tres direcciones estáticas en un lienzo; Moisés las rechazó por no tener vida ni parecerse a Strava y Runbuds.
- Se rehízo como prototipo vivo, [Pista viva](https://claude.ai/artifact/3WgeXhnFs91ZTeQC51YWH5), con las pantallas del MVP: azul eléctrico, la pista en Explorar, pisadas en la espera y el punto que cae en el match. Moisés la aprobó.
- Queda en `DESIGN.md` como propuesta para el PO (D-PO8 sigue abierta). Sin logo ni nombre de marca hasta la búsqueda de marcas.
- Pendientes movidos: aplicar o ajustar la dirección según D-PO8 → S4; verificar el eje de ancho de Archivo en Flutter → S5.
- Excepción (regla 2): trabajo fuera de las sesiones del plan, pedido por Moisés como piloto de la Fase 0 de diseño del harness.

## 2026-10-18 · S0 · Iniciar el proyecto
- 16 comentarios en el [spec del PO](https://docs.google.com/document/d/1oZ5anU2qvN136UN4q90sNrJSEVbRNKRBnlcPZb9QKf0/edit): verificación de identidad, mapas, monetización, arquitectura, tiendas, seguridad del punto de encuentro y más.
- Llenados `contexto.md`, `plan.md` (estimado 84–124 h y costos), `fases.md`, `vision.md`, glosario, `CLAUDE.md` y `README.md`.
- Decisiones: Flutter + Supabase Free en el MVP (ADR-0001); producto en Supabase Pro con migración por piezas a AWS (ADR-0002); tracking fuera del MVP (ADR-0003).
- Descubierto: Google Maps SDK móvil sin map ID cuesta US$0; Firebase Storage exige Blaze desde feb-2026; ya existe la app "Pacer" de Pacer Health.
- Visión publicada para el PO como [Google Doc v0.1](https://docs.google.com/document/d/16gY_llUEUO-UbaJUMU7ppwtJaawN02LGoh0xwBLNlS8/edit), generado con `scripts/md_a_html.py`. Pendientes movidos: revisión legal y búsqueda de marcas → "Pendientes sin sesión".
- Ajuste: B1 no depende de S3 ni del PO; quedó dividido en S5–S8 para arrancar en Claude Code mientras el PO responde.
- Excepción (regla 2): la sesión juntó tres funciones (S0, comentarios al spec y visión/stack) porque Moisés lo pidió así.
