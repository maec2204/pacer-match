---
tipo: contexto
actualizado: "2026-10-18"
mantenimiento: cada sesión al cerrar, solo si cambió un hecho o se cerró una decisión. Máx. 150 líneas.
---
# Contexto — Pacer Match

## Qué es
App móvil que conecta corredores para coordinar entrenamientos puntuales según ritmo (min/km), distancia, fecha/hora y un punto de encuentro. Resuelve que un corredor no encuentre compañía de su ritmo o distancia en su club o zona. El spec es del PO y vive en un Google Doc (["App Pacer match"](https://docs.google.com/document/d/1oZ5anU2qvN136UN4q90sNrJSEVbRNKRBnlcPZb9QKf0/edit)); la versión real del producto está en `docs/proyecto/vision.md`.

Objetivo inmediato: presupuestar y construir un MVP usable que el PO pueda mostrar para levantar capital. Lo elegido para el MVP es lo más rápido y económico que entrega la funcionalidad, no necesariamente lo del producto final. Fecha: la define el PO (D-PO9 en la visión).

## Personas
| Persona o rol | Qué hace en el proyecto |
|---|---|
| Moisés | Único desarrollador: presupuesta, diseña la arquitectura y construye el MVP (con desarrollo asistido por IA). ~10 h/semana. |
| PO (cliente) | Dueño del spec y de las decisiones de producto. Responde las preguntas comentadas en su Google Doc. |

## Producto y stack
- App: **Flutter** (iOS y Android, un código). Web fuera del MVP.
- Backend: **Supabase Free** en el MVP (Postgres + PostGIS, Auth, Storage, Realtime, Edge Functions); **Supabase Pro** en el producto, con migración por piezas a AWS si el volumen lo pide. Ver ADR-0001 y ADR-0002.
- Mapas: Google Maps SDK (`google_maps_flutter`) sin map ID → US$0. Push: FCM. Errores: Crashlytics. Verificación de identidad: Didit (propuesta, depende de D-PO4).
- Distribución del MVP: TestFlight y prueba interna de Google Play (propuesta, depende de D-PO7).
- Gestor de tareas: ninguno por ahora (D2). Repo: `maec2204/pacer-match` (GitHub, privado).

## Problemas u objetivos, por prioridad
1. Presupuesto del MVP para el PO.
2. Cerrar con el PO las decisiones abiertas del spec (16 comentarios en su Google Doc).
3. MVP con el flujo completo: registro → publicar o buscar → solicitud → match → chat, con push y seguridad mínima.
4. Métricas de tracción para la ronda (visión §11).

## Principios decididos
- Lo que no está en git no existe, ni para el agente ni para las personas.
- Determinista donde se pueda (hooks, permisos, CI, linters, scripts). El prompt queda para lo ambiguo.
- Instrucciones cortas: `CLAUDE.md` de 200 líneas como máximo. El detalle vive en `docs/` y `vault/` y se carga cuando hace falta.
- Costo de infraestructura del MVP ≈ US$0: solo planes gratuitos y las cuentas de tienda.
- El MVP se construye sobre la base del producto (Supabase + Flutter) para no tirarlo.
- Seguridad desde el MVP: punto exacto solo tras el match; reportar, bloquear y borrar cuenta.
- Al PO se le propone con comentarios en su Google Doc; lo que se decide se escribe aquí.

## Decisiones abiertas
Las del PO (D-PO1…D-PO11) están en `docs/proyecto/vision.md` §12. Las técnicas:

| # | Decisión | Propuesta por defecto | Se cierra en |
|---|---|---|---|
| D1 | Proveedor de verificación de identidad | Didit (500 gratis/mes, cédula VE y CO, SDK Flutter) | S2, tras D-PO1 y D-PO4 |
| D2 | Dónde viven las tareas | GitHub Issues del repo | S3 |
| D3 | Gestión de estado y navegación en Flutter | Riverpod + go_router | S5 |
| D4 | Búsqueda de lugares al fijar el punto | Pin + dirección inversa; autocompletado solo si cabe en el cupo gratis | B3 |
| D5 | Evitar la pausa del plan gratis de Supabase | Ping programado con GitHub Actions; Pro durante la ronda de demos | S7 |

Cerradas:
- 2026-10-18 · Frontend Flutter y backend Supabase Free en el MVP → ADR-0001.
- 2026-10-18 · Producto en Supabase Pro, migración por piezas a AWS al escalar → ADR-0002.
- 2026-10-18 · Registro propio de recorrido y pasos fuera del MVP; en el producto se importan actividades → ADR-0003.

## Documentos del proyecto
Viven en `docs/proyecto/`; el vault, en `vault/`.
- `docs/proyecto/reglas-de-sesion.md`: cómo trabaja cada sesión. **Leerlo primero.**
- `docs/proyecto/fases.md`: las sesiones, con función, dependencias, "hecho cuando" y tiempos.
- `docs/proyecto/plan.md`: objetivo, alcance, lo que no entra, estimado y costos del MVP.
- `docs/proyecto/vision.md`: visión del producto real para el PO (objetivos, alcance, arquitectura, riesgos, decisiones del PO). La copia que ve el PO es un Google Doc generado desde aquí (enlace en su frontmatter, `copia_po`).
- `docs/proyecto/bitacora.md`: una entrada por sesión.
