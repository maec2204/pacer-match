# Bitácora

<!-- Una entrada por sesión, la más nueva arriba. Máx. 8 líneas. Formato:

## AAAA-MM-DD · SN · <función>
- Qué se hizo, con enlaces a archivos, commits o MRs.
- Decisiones cerradas (y en qué documento quedaron).
- Descubierto: lo que cambia sesiones siguientes.
- Pendientes movidos: <qué> → SN, o → "Pendientes sin sesión". Nunca el pendiente suelto aquí.
- Excepción (si la hubo): qué regla se saltó y por qué.
-->

## 2026-10-26 · S5 · Esqueleto de la app
- `app/`: Flutter (Android e iOS, org `com.pacermatch`), entornos dev/prod con `--dart-define=ENTORNO`, lints estrictos, estructura por funcionalidad, Riverpod y go_router; pantalla provisional con el entorno y una cifra en Archivo ancho 62.
- Decisión cerrada: D3 → [ADR-0006](../../vault/decisiones/ADR-0006-estado-navegacion-y-fuente-archivo.md) (Riverpod, go_router, Archivo variable empaquetada, sin google_fonts).
- Descubierto: `google_fonts` 9.0.0 no sirve el eje de ancho de Archivo (comprobado en su código); `DESIGN.md` lo dice. Visto en el emulador Android API 36.
- Pendientes movidos: simulador de iOS → ola de cierre de B1 (necesita la Mac); Outfit empaquetada → sesión del tema (B2).

## 2026-10-26 · Reunión con el PO · Lo preparado para la presentación
- Presentación de la reunión (Slides, claude.ai): avance, adelanto, fases, costos de terceros, soporte, dorsales y nuevas ideas de ingresos.
- `plan.md`: costos anclados a cada bloque (dominio, Resend, Google Cloud, Apple antes de B5, Play antes de B8); fondos, avatares, patrocinios y buzón de soporte fuera del estimado. `vision.md` pasa a borrador v0.3 (D-PO7, D-PO13, D-PO14, hipótesis de ingresos en §8). ADR-0004 con el precio nuevo de Didit.
- Hechos: no hay empresa constituida (cuentas personales, sin D-U-N-S); tarifa de Moisés US$5/h; adelanto por lo hecho 8 h = US$40.
- Descubierto: desde el 1-11-2026 Didit da ~30 verificaciones gratis al mes, no 500; la prueba interna de Play no exige los 12 testers (solo publicar).
- Pendientes movidos: tarifa, adelanto e hitos → S1; dominio y Resend → B2; Google Cloud → B3; Didit → B7; regla de dorsales → B9; Play → B8; aplicar la v0.3 al Google Doc, D-PO13, D-PO14, mantenimiento, inscripción de Apple, extras de ingresos y 12 testers → "Pendientes sin sesión".
- Soporte (D-PO13): Moisés lo amplía de un buzón (~4 h) a una sección de ayuda con hojas por tipo y mensajes estructurados (10–14 h, estimado).
- Excepción (regla 2): trabajo fuera de las sesiones del plan, pedido por Moisés para preparar la reunión.

## 2026-10-26 · Harness · Plan en el formato del harness
- `.harness/`: `plan.yaml` con las sesiones de `fases.md` (S0–S8 y B2 como la que divide su bloque), política (riesgo alto en la ola, con el diff leído por Moisés antes de integrar), puertas de Flutter en `app/`, kit `flutter`, QA en Android y `contexto.md`.
- `fases.md` manda: si cambia una fila, se cambia también en `plan.yaml`.
- Descubierto: S3 depende de S6 (la migración vive en `supabase/`, que crea S6) y S8 de S6 (las dos tocan `app/pubspec.yaml`); quedan anotadas en `plan.yaml`. De las sesiones abiertas, solo S5 y S3 corren solas; el resto necesita cuentas o aprobaciones de Moisés.
- Excepción (regla 2): trabajo fuera de las sesiones del plan, pedido por Moisés para correr pacer-match con el harness (H6).

## 2026-10-25 · Alcance · Dorsales en el MVP
- La PO pidió gamificación en un comentario sobre la visión; la v0.2 la tenía en el producto v1. Moisés la pasa al MVP.
- Diseño: dorsales coleccionables en `DESIGN.md` (PR #1) y en el prototipo [Pista viva](https://claude.ai/artifact/3WgeXhnFs91ZTeQC51YWH5).
- Nuevo bloque B9 (8–12 h, estimado) en `fases.md` y `plan.md`; sobre el estimado de S2, el total pasa a 102–152 h (6–8 semanas a ~20 h/semana).
- Pendientes movidos: llevar al PO los dorsales en el MVP (`vision.md` §5) y la fecha de 6–8 semanas (D-PO9) → "Pendientes sin sesión" (S2 cerró antes de recibirlo).
- Excepción (regla 2): cambio de alcance fuera de una sesión del plan, pedido por Moisés.

## 2026-10-25 · S2 · Cerrar alcance con el PO
- Leídos los 16 comentarios del PO en la visión v0.1. La v0.2 se aplicó como sugerencias en el [mismo Google Doc](https://docs.google.com/document/d/16gY_llUEUO-UbaJUMU7ppwtJaawN02LGoh0xwBLNlS8/edit) (`scripts/docs_sugerir.py`), con sus comentarios intactos. Un primer intento como doc nuevo quedó marcado "[DESCARTAR]" en Drive.
- Decisiones: mercado Venezuela, Caracas; suscripción por conexiones con primer match gratis y, en el MVP, pantalla de planes sin cobro (ADR-0005); Didit para crear y solicitar (ADR-0004); sin diseñador, con referencias de Mobbin; fecha de 5–7 semanas a ~20 h/semana.
- Descubierto: cobrar dentro de la app exige el sistema de cada tienda, y en Venezuela Apple solo acepta tarjetas. Estimado total: 94–140 h (+4–6 h de pantalla de planes, +6–10 h de componentes visuales propios).
- Pendientes movidos: D-PO7 (cuentas de tienda) → B5; biblioteca de imágenes → B2; D-PO12 (precios) y D6 (cobro en Venezuela) → "Pendientes sin sesión".

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
