---
tipo: decision
audiencia: ambos
id: ADR-0003
titulo: El registro propio de recorrido y pasos queda fuera del MVP
estado: aceptada
fecha: "2026-10-18"
decidido-por: [Moisés]
afecta: [alcance, mvp, ubicacion, producto]
reemplaza:
reemplazada-por:
origen: [S0]
resumen: Sin tracking GPS propio en el MVP; en el producto se importan actividades de Apple Salud, Health Connect o Garmin.
---
# ADR-0003 · El registro propio de recorrido y pasos queda fuera del MVP

## En formato historia (HU)
Como único desarrollador, quiero dejar fuera el tracking GPS, para concentrar el MVP en lo que lo diferencia: el match por ritmo.
Para decidir: se ahorran 16–55 h (estimado) y la revisión de ubicación en segundo plano; se pierde mostrar el recorrido en la demo; si no se hace, el MVP compite de frente con Strava y Garmin en lo que mejor hacen.

## Contexto
- El spec del PO no incluye tracking. Moisés lo mencionó como función clave, y se evaluó en S0.
- Estimados: registro básico con la app abierta, +16–24 h; tracking completo en segundo plano con pasos, +35–55 h.

## Decisión
- El MVP no registra recorridos ni pasos.
- En el producto se importan actividades desde Apple Salud, Health Connect o Garmin. Eso alimenta el "ritmo verificado" (visión §4, objetivo 6).

## Alternativas descartadas y por qué
- **Registro básico en el MVP:** suma horas a un flujo que no prueba la hipótesis del match.
- **Tracking completo:** es lo más caro, pide el permiso de ubicación "siempre" (con más escrutinio de las tiendas) y obliga a probar batería en dispositivos reales.

## Consecuencias: qué obliga hoy
- La app pide ubicación solo en primer plano: para el feed y para fijar el punto.

## Cómo se verifica: test, linter o hook (si existe)
- La configuración de la app no declara ubicación en segundo plano (revisar en B1).
