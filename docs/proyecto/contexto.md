---
tipo: contexto
actualizado: "2026-10-25"
mantenimiento: cada sesión al cerrar, solo si cambió un hecho o se cerró una decisión. Máx. 150 líneas.
---
# Contexto — Pacer Match

## Qué es
App móvil que conecta corredores para coordinar entrenamientos puntuales según ritmo (min/km), distancia, fecha/hora y un punto de encuentro. Resuelve que un corredor no encuentre compañía de su ritmo o distancia en su club o zona. El spec es del PO y vive en un Google Doc (["App Pacer match"](https://docs.google.com/document/d/1oZ5anU2qvN136UN4q90sNrJSEVbRNKRBnlcPZb9QKf0/edit)); la versión real del producto está en `docs/proyecto/vision.md`.

Objetivo inmediato: presupuestar y construir un MVP usable que el PO pueda mostrar para levantar capital. Lo elegido para el MVP es lo más rápido y económico que entrega la funcionalidad, no necesariamente lo del producto final. Fecha (D-PO9): 5–7 semanas a ~20 h/semana desde que arranca la construcción; el PO la pidió "lo antes posible". Con los dorsales (B9), el estimado sube a 6–8 semanas; falta acordarlo con el PO.

## Personas
| Persona o rol | Qué hace en el proyecto |
|---|---|
| Moisés | Único desarrollador: presupuesta, diseña la arquitectura y construye el MVP (con desarrollo asistido por IA). ~20 h/semana (antes ~10). |
| Kimberlyn S. (PO) | Dueña del spec y de las decisiones de producto. Comenta en los Google Docs del spec y de la visión. |

## Producto y stack
- App: **Flutter** (iOS y Android, un código). Web fuera del MVP.
- Backend: **Supabase Free** en el MVP (Postgres + PostGIS, Auth, Storage, Realtime, Edge Functions); **Supabase Pro** en el producto, con migración por piezas a AWS si el volumen lo pide. Ver ADR-0001 y ADR-0002.
- Mapas: Google Maps SDK (`google_maps_flutter`) sin map ID → US$0. Push: FCM. Errores: Crashlytics. Verificación de identidad: Didit, para crear y solicitar (ADR-0004).
- Mercado: Venezuela, Caracas. Español, min/km.
- Ingresos: suscripción por conexiones con el primer match gratis; en el MVP, pantalla de planes sin cobro real (ADR-0005).
- Diseño: sin diseñador; dirección visual propia con referencias de Mobbin (`DESIGN.md`, PR #1) e imágenes de una biblioteca gratuita.
- Distribución del MVP: TestFlight y prueba interna de Google Play. A nombre de quién van las cuentas: abierto (D-PO7).
- Gestor de tareas: ninguno por ahora (D2). Repo: `maec2204/pacer-match` (GitHub, privado).

## Problemas u objetivos, por prioridad
1. Presupuesto del MVP para el PO (S1).
2. MVP con el flujo completo: registro → publicar o buscar → solicitud → match → chat, con push, seguridad mínima y pantalla de planes.
3. Métricas de tracción e intención de pago para la ronda (visión, sección 11).
4. Con el PO: precios y conexiones por plan (D-PO12) y a nombre de quién van las cuentas de tienda (D-PO7).

## Principios decididos
- Lo que no está en git no existe, ni para el agente ni para las personas.
- Determinista donde se pueda (hooks, permisos, CI, linters, scripts). El prompt queda para lo ambiguo.
- Instrucciones cortas: `CLAUDE.md` de 200 líneas como máximo. El detalle vive en `docs/` y `vault/` y se carga cuando hace falta.
- Costo de infraestructura del MVP ≈ US$0: solo planes gratuitos y las cuentas de tienda.
- El MVP se construye sobre la base del producto (Supabase + Flutter) para no tirarlo.
- Seguridad desde el MVP: punto exacto solo tras el match; reportar, bloquear y borrar cuenta.
- Al PO se le propone con comentarios en su Google Doc; lo que se decide se escribe aquí.

## Decisiones abiertas
Las del PO (D-PO1…D-PO12) están en `docs/proyecto/vision.md`, sección 12. Las técnicas:

| # | Decisión | Propuesta por defecto | Se cierra en |
|---|---|---|---|
| D2 | Dónde viven las tareas | GitHub Issues del repo | S3 |
| D3 | Gestión de estado y navegación en Flutter | Riverpod + go_router | S5 |
| D4 | Búsqueda de lugares al fijar el punto | Pin + dirección inversa; autocompletado solo si cabe en el cupo gratis | B3 |
| D5 | Evitar la pausa del plan gratis de Supabase | Ping programado con GitHub Actions; Pro durante la ronda de demos | S7 |
| D6 | Cómo se cobra la suscripción en Venezuela | Compras dentro de la app de Apple y Google, si las tarjetas locales funcionan | Antes del cobro real (producto v1) |

Cerradas:
- 2026-10-18 · Frontend Flutter y backend Supabase Free en el MVP → ADR-0001.
- 2026-10-18 · Producto en Supabase Pro, migración por piezas a AWS al escalar → ADR-0002.
- 2026-10-18 · Registro propio de recorrido y pasos fuera del MVP; en el producto se importan actividades → ADR-0003.
- 2026-10-25 · D1: verificación con Didit, obligatoria para crear y solicitar → ADR-0004.
- 2026-10-25 · Con el PO: mercado Venezuela, Caracas (D-PO1); ingresos por suscripción según conexiones (D-PO6) → ADR-0005; diseño sin diseñador (D-PO8); fecha de 5–7 semanas a ~20 h/semana (D-PO9). Detalle en `vision.md`, sección 12.

## Documentos del proyecto
Viven en `docs/proyecto/`; el vault, en `vault/`.
- `docs/proyecto/reglas-de-sesion.md`: cómo trabaja cada sesión. **Leerlo primero.**
- `docs/proyecto/fases.md`: las sesiones, con función, dependencias, "hecho cuando" y tiempos.
- `docs/proyecto/plan.md`: objetivo, alcance, lo que no entra, estimado y costos del MVP.
- `docs/proyecto/vision.md`: visión del producto real para el PO (objetivos, alcance, arquitectura, riesgos, decisiones del PO). La copia que ve el PO es un solo Google Doc, actualizado desde aquí como sugerencias (enlace en su frontmatter, `copia_po`).
- `docs/proyecto/bitacora.md`: una entrada por sesión.
