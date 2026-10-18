---
tipo: plan
actualizado: "{{fecha}}"
mantenimiento: al cerrar una sesión, ajustar las siguientes solo si descubrió algo que las cambia. El avance va en la bitácora.
---
# Fases — {{nombre-del-proyecto}}

Cada fase es una sesión: **una sola función, 1–2 h y un "hecho cuando" que se puede comprobar.** Si una sesión no cabe, se divide; no se alarga. Se numeran S1…SN. Si el proyecto abre otro frente, ese frente tiene su propio archivo (`fases-<frente>.md`) con su propia letra (T1…, M1…) para no chocar.

## Dónde corre cada sesión
- **Claude Code, en el clon del repo:** las que tocan código o prueban herramientas.
- **Project de claude.ai:** las de diseño, decisiones y documentos.

## Resumen
| Sesión | Función | Entregable | Necesita | Cierra | Tiempo (estimado) |
|---|---|---|---|---|---|
| S0 | Iniciar el proyecto | `contexto.md`, `plan.md` y estas fases llenas | — | — | 30–60 min |
| S1 | {{…}} | {{…}} | S0 | {{D…}} | {{…}} |

**Total:** {{…}} h (estimado).

**Orden de recorte, si falta tiempo:** {{qué sesión se cae primero}}. **No se recortan:** {{…}}.

## Detalle por sesión
Para arrancar cualquiera: «Sesión SN. Lee `docs/proyecto/reglas-de-sesion.md` y síguelo.»

### S1 · {{función}}
- **Hace:** {{…}}
- **Hecho cuando:** {{algo que se puede comprobar: un comando que pasa, un archivo que existe, una persona que aprueba}}

<!-- Un pendiente que llega de otra sesión se agrega a la sesión que lo resuelve así:
- **Heredado de S3:** <qué>. Y su comprobación se suma al "Hecho cuando". -->

## Pendientes sin sesión
Lo que no tiene una sesión que lo resuelva. Al cerrar cada sesión se revisa esta tabla; si una sesión lo absorbe, la fila pasa a esa sesión y sale de aquí.

| Fecha | Pendiente | Origen |
|---|---|---|
| — | (vacía) | — |
