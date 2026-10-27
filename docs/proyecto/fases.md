---
tipo: plan
actualizado: "2026-10-26"
mantenimiento: al cerrar una sesión, ajustar las siguientes solo si descubrió algo que las cambia. El avance va en la bitácora.
---
# Fases — Pacer Match

Cada fase es una sesión: **una sola función, 1–2 h y un "hecho cuando" que se puede comprobar.** Si una sesión no cabe, se divide; no se alarga. Se numeran S1…SN. Si el proyecto abre otro frente, ese frente tiene su propio archivo (`fases-<frente>.md`) con su propia letra (T1…, M1…) para no chocar.

Los bloques de construcción (B1…B8) se dividen en sesiones en la primera sesión de cada bloque, que agrega aquí sus filas SN con su "hecho cuando". B1 ya está dividido (S5–S8). Los números identifican la sesión, no el orden: S5–S8 pueden correr antes que S3 y S4.

## Dónde corre cada sesión
- **Claude Code, en el clon del repo:** las que tocan código o prueban herramientas (S3 y de S5 en adelante).
- **Project de claude.ai:** las de diseño, decisiones y documentos (S1, S2).

## Resumen
| Sesión | Función | Entregable | Necesita | Cierra | Tiempo (estimado) |
|---|---|---|---|---|---|
| S0 ✓ | Iniciar el proyecto | Contexto, plan, fases, visión y comentarios al spec | — | ADR-0001…0003 | 2–3 h |
| S1 | Presupuesto del MVP | `docs/proyecto/presupuesto.md` | S0 | — | 1–2 h |
| S2 ✓ | Cerrar alcance con el PO | Visión v0.2, plan y contexto con las respuestas del PO | Respuestas del PO | D1, D-PO1/6/8/9 | 1–2 h |
| S3 | Modelo de datos y reglas | Migración inicial + RLS + nota de dominio | S2 | D2 | 2 h |
| S4 | Flujo de pantallas | Mapa de pantallas y navegación | S2 | — | 1–2 h |
| S5 (B1) | Esqueleto de la app | `app/` Flutter con entornos, lints, estado y navegación | S0 | D3 | 1,5–2 h |
| S6 (B1) | Supabase | `supabase/` local + proyectos dev y prod conectados a la app | S5 | — | 1,5–2 h |
| S7 (B1) | CI y anti-pausa | GitHub Actions (analyze, test) + ping programado | S6 | D5 | 1–1,5 h |
| S8 (B1) | Firebase | FCM y Crashlytics configurados | S5 | — | 1,5–2 h |
| B2 | Registro y perfil | Auth, onboarding, perfil | B1, S3, S4 | — | 10–16 h (+ dirección visual) |
| B3 | Entrenamientos | Crear con mapa y zona aproximada | B2 | D4 | 10–14 h |
| B4 | Feed y filtros | Feed por radio, ritmo y fecha | B3 | — | 10–14 h |
| B5 | Solicitudes y push | Ciclo de la solicitud, notificaciones y pantalla de planes | B4 | — | 16–24 h |
| B6 | Chat | Chat 1:1 en tiempo real | B5 | — | 8–12 h |
| B7 | Confianza y tiendas | Verificación, reportes, bloqueo, borrado de cuenta | B5 | — | 12–18 h |
| B8 | Demo y entrega | Builds en TestFlight y Play, métricas, datos de demo | B6, B7, B9 | — | 10–14 h |
| B9 | Dorsales (gamificación) | Dorsales coleccionables que se ganan corriendo acompañado | B5 | — | 8–12 h |

**Total:** 102–152 h (estimado), contando 6–10 h de componentes propios de la dirección visual repartidas en B2–B6. A ~20 h/semana, 6–8 semanas.

**Orden de recorte, si falta tiempo:** 1) modo visitante, 2) login con Google y Apple (queda correo), 3) autocompletado de lugares (queda pin + dirección inversa), 4) verificación de identidad (pasa al producto y se muestra en el pitch). El filtro por distancia y marcas ya salió del MVP (PO, 25-10). **No se recortan:** registro → feed → solicitud → match → chat, push, zona aproximada antes del match, pantalla de planes (es la métrica de intención de pago), reportar, bloquear y borrar cuenta (los exigen las tiendas).

## Detalle por sesión
Para arrancar cualquiera: «Sesión SN. Lee `docs/proyecto/reglas-de-sesion.md` y síguelo.»

### S0 · Iniciar el proyecto ✓ (2026-10-18)
- **Hizo:** comentarios al spec del PO, stack del MVP y del producto, visión (y su copia en Google Docs para el PO), plan y estas fases.

### S1 · Presupuesto del MVP
- **Hace:** convierte el estimado por bloque de `plan.md` en un presupuesto para el PO: horas por bloque × tarifa de Moisés, costos de terceros, supuestos y lo que cambia el precio (diseño a medida, grupal, tracking).
- **Heredado de la reunión del 26-10:** tarifa de Moisés para este PO, US$5/h; adelanto por lo hecho, 8 h (visión 4 h, prototipo 3 h, logo 1 h) = US$40; pagos propuestos: anticipo al arrancar y tres hitos contra el "hecho cuando" de sus bloques (B1–B2, B3–B5, B6–B9). Con la tarifa, el MVP de 102–152 h da US$510–760 (estimado). Costos de terceros por bloque: `plan.md`, Costos.
- **Hecho cuando:** `docs/proyecto/presupuesto.md` existe y Moisés lo aprueba para enviar junto con la [visión v0.1](https://docs.google.com/document/d/16gY_llUEUO-UbaJUMU7ppwtJaawN02LGoh0xwBLNlS8/edit).

### S2 · Cerrar alcance con el PO ✓ (2026-10-25)
- **Hizo:** leyó los 16 comentarios del PO en la visión v0.1, publicó la v0.2 y cerró D1 (ADR-0004), D-PO1, D-PO6 (ADR-0005), D-PO8 y D-PO9. D-PO2, D-PO4, D-PO5 y D-PO11 quedan como propuestas aceptadas salvo objeción en la v0.2. D-PO7 (a nombre de quién van las cuentas) pasa a B5; D-PO12 (precios) y D6 (cobro en Venezuela) van a "Pendientes sin sesión".

### S3 · Modelo de datos y reglas
- **Hace:** esquema Postgres (perfiles, entrenamientos con `geography`, solicitudes, mensajes, reportes, bloqueos, verificaciones, dispositivos), políticas RLS y la vista que expone solo la zona aproximada antes del match. Cierra D2 (dónde viven las tareas).
- **Hecho cuando:** `supabase db reset` aplica la migración inicial sin errores en local, un test SQL comprueba que un usuario sin match no lee el punto exacto, y existe la nota de dominio en `vault/dominios/`.

### S4 · Flujo de pantallas
- **Hace:** lista de pantallas, navegación, estados vacíos y de error; elige el kit de componentes. Heredado de H5 (harness): parte de la dirección visual de `DESIGN.md` (no hay diseño del PO, D-PO8) y la ajusta según lo que diga el PO al verla.
- **Hecho cuando:** `vault/sistema/pantallas.md` existe con el mapa de pantallas y Moisés lo aprueba; `DESIGN.md` dice si la dirección quedó aprobada por el PO o cambió.

### B1 · Fundaciones (S5–S8)
No depende de las respuestas del PO: todo está decidido en ADR-0001. Se puede construir mientras S1 y S2 esperan.
- **Hecho cuando (bloque):** `flutter analyze` y `flutter test` pasan en CI de GitHub Actions; la app arranca en iOS y Android contra Supabase dev; Crashlytics recibe un error de prueba; el ping anti-pausa corre programado.

#### S5 · Esqueleto de la app
- **Hace:** `flutter create` en `app/`; entornos dev y prod (con `--dart-define`); lints estrictos; estructura por funcionalidad; cierra D3 (estado y navegación) con un ADR. Heredado de H5 (harness): comprobar si Archivo con eje de ancho funciona con `google_fonts` o hay que empaquetar el TTF variable (ver `DESIGN.md`).
- **Hecho cuando:** `flutter analyze` sin avisos y `flutter test` en verde; la app abre en el simulador de iOS y en el emulador de Android y muestra el entorno activo, con una cifra en Archivo condensado (ancho 62).

#### S6 · Supabase
- **Hace:** `supabase init` en la raíz y entorno local con Docker; Moisés crea los proyectos Free dev y prod; la app se conecta con `supabase_flutter`, con claves fuera de git.
- **Hecho cuando:** `supabase start` corre en local; la app en dev hace una consulta de prueba al proyecto dev; `git status` no muestra ningún archivo con claves.

#### S7 · CI y anti-pausa
- **Hace:** workflow de GitHub Actions con `flutter analyze` y `flutter test` en cada push y PR; workflow programado que consulta los proyectos de Supabase para que no se pausen. Antes, verificar en la documentación de Supabase qué cuenta como actividad. Cierra D5.
- **Hecho cuando:** los dos workflows están en verde en GitHub, y el ping corrido a mano (`workflow_dispatch`) recibe respuesta 200.

#### S8 · Firebase
- **Hace:** proyecto de Firebase solo para FCM y Crashlytics; `flutterfire configure` para dev y prod. El permiso de notificaciones todavía no se pide (eso va en B5).
- **Hecho cuando:** Crashlytics muestra un crash de prueba de Android, y la app obtiene un token de FCM en Android. iOS espera la cuenta de Apple Developer (B5).

### B2 · Registro y perfil
- **Heredado de S2:** elegir la biblioteca gratuita de imágenes (con licencia de uso comercial) y anotarla en `DESIGN.md`.
- **Heredado de la reunión del 26-10:** dominio comprado (tras D-PO10) y correo de registro con SMTP propio (Resend Free) en Supabase: sin él, Supabase manda solo 2 correos por hora.
- **Hecho cuando:** un usuario nuevo se registra, completa el perfil con foto y ritmo, y lo ve guardado al reabrir la app, en iOS y Android.

### B3 · Entrenamientos
- **Heredado de la reunión del 26-10:** cuenta de facturación de Google Cloud a nombre de la PO (pide tarjeta), con cuotas y alertas de presupuesto antes de activar las APIs.
- **Hecho cuando:** un usuario crea un entrenamiento con pin; otro usuario sin match ve solo la zona aproximada (test de RLS en verde).

### B4 · Feed y filtros
- **Hecho cuando:** el feed devuelve solo entrenamientos dentro del radio, ritmo y fecha elegidos, con un test de la consulta sobre datos sembrados.

### B5 · Solicitudes y push
- **Heredado de S2:** primer match gratis y pantalla de planes sin cobro real, que no bloquea y registra "Me interesa" (ADR-0005). Antes de empezar, D-PO7 resuelta con el PO y la cuenta de Apple Developer creada: sin ella no hay push en iPhone. Como no hay empresa constituida (26-10), la propuesta es una cuenta personal a nombre de la PO, con Moisés invitado.
- **Hecho cuando:** solicitud → aceptar → match llega como push a otro dispositivo; cancelar y expirar cambian el estado y avisan; con un match confirmado, pedir otro muestra la pantalla de planes y "Me interesa" queda registrado.

### B6 · Chat
- **Hecho cuando:** dos dispositivos con match intercambian mensajes en tiempo real y reciben push con la app cerrada.

### B7 · Confianza y tiendas
- **Heredado de la reunión del 26-10:** desde el 1-11-2026 el plan gratis de Didit es un crédito de US$10 al mes (unas 30 verificaciones completas; luego US$0,33 c/u). Ajustar la vigilancia del uso mensual de ADR-0004.
- **Hecho cuando:** sin verificación no se puede crear ni solicitar; reportar y bloquear funcionan; borrar la cuenta elimina los datos, y el enlace web de borrado responde.

### B9 · Dorsales (gamificación)
- **Hace:** pedido de la PO en un comentario sobre la visión; entra al MVP por decisión de Moisés del 25-10-2026. Dorsales coleccionables que se ganan corriendo con otras personas (primer match, número de compañeros, zonas de Caracas, especiales), la racha semanal, la colección, el momento de ganar uno y la tira en el perfil, según `DESIGN.md`. Las reglas de cada dorsal se cierran con la PO en la primera sesión del bloque. Heredado de la reunión del 26-10: decidir con ella si un dorsal se gana al confirmar el match o cuando los dos confirman que corrieron; lo segundo agrega un paso de confirmación que hay que estimar antes.
- **Hecho cuando:** un match confirmado otorga "Primer match" una sola vez (test sobre datos sembrados), la colección muestra ganados y bloqueados, y el momento de ganar uno se ve en iOS y Android.

### B8 · Demo y entrega
- **Heredado de la reunión del 26-10:** cuenta de Google Play (US$25) creada antes de empezar. La prueba interna no exige los 12 testers durante 14 días; eso aplica al publicar en la tienda.
- **Hecho cuando:** hay build en TestFlight y en la prueba interna de Google Play, la consulta de métricas devuelve datos, y está grabada la demo del flujo completo.

## Pendientes sin sesión
Lo que no tiene una sesión que lo resuelva. Al cerrar cada sesión se revisa esta tabla; si una sesión lo absorbe, la fila pasa a esa sesión y sale de aquí.

| Fecha | Pendiente | Origen |
|---|---|---|
| 2026-10-18 | Revisión legal (privacidad, biometría, términos) según el país de lanzamiento | S0 |
| 2026-10-18 | Búsqueda de marcas para "Pacer Match" (USPTO, SIC, SAPI) | S0 |
| 2026-10-25 | D-PO12: precios, conexiones por plan y a quién descuenta cada match, con el PO, antes de la ronda | S2 |
| 2026-10-25 | D6: verificar si las tarjetas venezolanas funcionan en App Store y Google Play, antes de construir el cobro real | S2 |
| 2026-10-26 | Aplicar la visión v0.3 (dorsales en el MVP, fecha de 6–8 semanas, Didit, D-PO7, soporte D-PO13/14, hipótesis de ingresos) como sugerencias en el Google Doc de la visión con `scripts/docs_sugerir.py`, ajustada con lo que la PO diga en la reunión | Dorsales en el MVP · reunión del 26-10 |
| 2026-10-26 | D-PO13: si la PO aprueba el buzón de soporte por Telegram (~4 h, aparte del estimado), agregarlo como bloque con su "hecho cuando" | Reunión del 26-10 |
| 2026-10-26 | D-PO14: nombre del responsable de seguridad y reportes, y su tiempo de respuesta, antes de lanzar | Reunión del 26-10 |
| 2026-10-26 | Contrato de mantenimiento técnico aparte (bolsa de horas mensual, sin atención a usuarios ni moderación), antes de entregar el MVP | Reunión del 26-10 |
| 2026-10-26 | Probar la inscripción en Apple Developer con datos y tarjeta de Venezuela, antes de B5 | Reunión del 26-10 |
| 2026-10-26 | Fondos, avatares desbloqueables y patrocinios de marca: decidir con la PO si son parte del producto v1 y si algo va como demo en el MVP | Reunión del 26-10 |
| 2026-10-26 | Publicar en Google Play con cuenta personal: prueba cerrada con 12 testers durante 14 días seguidos antes de pedir producción (producto v1) | Reunión del 26-10 |
