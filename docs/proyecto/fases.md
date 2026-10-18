---
tipo: plan
actualizado: "2026-10-18"
mantenimiento: al cerrar una sesión, ajustar las siguientes solo si descubrió algo que las cambia. El avance va en la bitácora.
---
# Fases — Pacer Match

Cada fase es una sesión: **una sola función, 1–2 h y un "hecho cuando" que se puede comprobar.** Si una sesión no cabe, se divide; no se alarga. Se numeran S1…SN. Si el proyecto abre otro frente, ese frente tiene su propio archivo (`fases-<frente>.md`) con su propia letra (T1…, M1…) para no chocar.

Los bloques de construcción (B1…B8) se dividen en sesiones en la primera sesión de cada bloque, que agrega aquí sus filas SN con su "hecho cuando".

## Dónde corre cada sesión
- **Claude Code, en el clon del repo:** las que tocan código o prueban herramientas (S3 en adelante).
- **Project de claude.ai:** las de diseño, decisiones y documentos (S1, S2).

## Resumen
| Sesión | Función | Entregable | Necesita | Cierra | Tiempo (estimado) |
|---|---|---|---|---|---|
| S0 ✓ | Iniciar el proyecto | Contexto, plan, fases, visión y comentarios al spec | — | ADR-0001…0003 | 2–3 h |
| S1 | Presupuesto del MVP | `docs/proyecto/presupuesto.md` | S0 | — | 1–2 h |
| S2 | Cerrar alcance con el PO | Visión, plan y contexto con las respuestas del PO | Respuestas del PO | D1, D-PO1/2/4/5/7/8 | 1–2 h |
| S3 | Modelo de datos y reglas | Migración inicial + RLS + nota de dominio | S2 | D2 | 2 h |
| S4 | Flujo de pantallas | Mapa de pantallas y navegación | S2 | — | 1–2 h |
| B1 | Fundaciones | App Flutter base con CI, Supabase y FCM | S3 | D3, D5 | 6–10 h |
| B2 | Registro y perfil | Auth, onboarding, perfil | B1, S4 | — | 10–16 h |
| B3 | Entrenamientos | Crear con mapa y zona aproximada | B2 | D4 | 10–14 h |
| B4 | Feed y filtros | Feed por radio, ritmo y fecha | B3 | — | 10–14 h |
| B5 | Solicitudes y push | Ciclo de la solicitud + notificaciones | B4 | — | 12–18 h |
| B6 | Chat | Chat 1:1 en tiempo real | B5 | — | 8–12 h |
| B7 | Confianza y tiendas | Verificación, reportes, bloqueo, borrado de cuenta | B5 | — | 12–18 h |
| B8 | Demo y entrega | Builds en TestFlight y Play, métricas, datos de demo | B6, B7 | — | 10–14 h |

**Total:** 84–124 h (estimado). A ~10 h/semana, 9–13 semanas.

**Orden de recorte, si falta tiempo:** 1) modo visitante, 2) login con Google y Apple (queda correo), 3) filtro por distancia y marcas 10k/21k/42k, 4) autocompletado de lugares (queda pin + dirección inversa), 5) verificación de identidad (pasa al producto y se muestra en el pitch). **No se recortan:** registro → feed → solicitud → match → chat, push, zona aproximada antes del match, reportar, bloquear y borrar cuenta (los exigen las tiendas).

## Detalle por sesión
Para arrancar cualquiera: «Sesión SN. Lee `docs/proyecto/reglas-de-sesion.md` y síguelo.»

### S0 · Iniciar el proyecto ✓ (2026-10-18)
- **Hizo:** comentarios al spec del PO, stack del MVP y del producto, visión (y su copia en Google Docs para el PO), plan y estas fases.

### S1 · Presupuesto del MVP
- **Hace:** convierte el estimado por bloque de `plan.md` en un presupuesto para el PO: horas por bloque × tarifa de Moisés, costos de terceros, supuestos y lo que cambia el precio (diseño a medida, grupal, tracking).
- **Hecho cuando:** `docs/proyecto/presupuesto.md` existe y Moisés lo aprueba para enviar junto con la [visión v0.1](https://docs.google.com/document/d/16gY_llUEUO-UbaJUMU7ppwtJaawN02LGoh0xwBLNlS8/edit).

### S2 · Cerrar alcance con el PO
- **Hace:** lee las respuestas del PO en los comentarios del spec y actualiza `vision.md` §12, `plan.md` y `contexto.md`. Cierra D1 (proveedor de verificación) con el mercado ya definido.
- **Hecho cuando:** D-PO1, D-PO2, D-PO4, D-PO5, D-PO7 y D-PO8 tienen respuesta en `vision.md` o están en "Pendientes sin sesión" con fecha, y existe el ADR de verificación.

### S3 · Modelo de datos y reglas
- **Hace:** esquema Postgres (perfiles, entrenamientos con `geography`, solicitudes, mensajes, reportes, bloqueos, verificaciones, dispositivos), políticas RLS y la vista que expone solo la zona aproximada antes del match. Cierra D2 (dónde viven las tareas).
- **Hecho cuando:** `supabase db reset` aplica la migración inicial sin errores en local, un test SQL comprueba que un usuario sin match no lee el punto exacto, y existe la nota de dominio en `vault/dominios/`.

### S4 · Flujo de pantallas
- **Hace:** lista de pantallas, navegación, estados vacíos y de error; elige el kit de componentes (o incorpora el diseño del PO, según D-PO8).
- **Hecho cuando:** `vault/sistema/pantallas.md` existe con el mapa de pantallas y Moisés lo aprueba.

### B1 · Fundaciones
- **Hecho cuando:** `flutter analyze` y `flutter test` pasan en CI de GitHub Actions; la app arranca en iOS y Android contra Supabase dev; Crashlytics recibe un error de prueba; el ping anti-pausa corre programado.

### B2 · Registro y perfil
- **Hecho cuando:** un usuario nuevo se registra, completa el perfil con foto y ritmo, y lo ve guardado al reabrir la app, en iOS y Android.

### B3 · Entrenamientos
- **Hecho cuando:** un usuario crea un entrenamiento con pin; otro usuario sin match ve solo la zona aproximada (test de RLS en verde).

### B4 · Feed y filtros
- **Hecho cuando:** el feed devuelve solo entrenamientos dentro del radio, ritmo y fecha elegidos, con un test de la consulta sobre datos sembrados.

### B5 · Solicitudes y push
- **Hecho cuando:** solicitud → aceptar → match llega como push a otro dispositivo; cancelar y expirar cambian el estado y avisan.

### B6 · Chat
- **Hecho cuando:** dos dispositivos con match intercambian mensajes en tiempo real y reciben push con la app cerrada.

### B7 · Confianza y tiendas
- **Hecho cuando:** sin verificación no se puede crear ni solicitar; reportar y bloquear funcionan; borrar la cuenta elimina los datos, y el enlace web de borrado responde.

### B8 · Demo y entrega
- **Hecho cuando:** hay build en TestFlight y en la prueba interna de Google Play, la consulta de métricas devuelve datos, y está grabada la demo del flujo completo.

## Pendientes sin sesión
Lo que no tiene una sesión que lo resuelva. Al cerrar cada sesión se revisa esta tabla; si una sesión lo absorbe, la fila pasa a esa sesión y sale de aquí.

| Fecha | Pendiente | Origen |
|---|---|---|
| 2026-10-18 | Revisión legal (privacidad, biometría, términos) según el país de lanzamiento | S0 |
| 2026-10-18 | Búsqueda de marcas para "Pacer Match" (USPTO, SIC, SAPI) | S0 |
