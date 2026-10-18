# Reglas de sesión — {{nombre-del-proyecto}}

## Al empezar
1. Leer `docs/proyecto/contexto.md`, la fila de esta sesión en `docs/proyecto/fases.md` (con lo que dice "Heredado de…"), la tabla "Pendientes sin sesión" de ese archivo y las últimas 5 entradas de `docs/proyecto/bitacora.md`. Si el proyecto tiene más de un frente, cada uno con su archivo `fases-<frente>.md`, se lee el de la sesión.
2. Decir en una línea qué sesión es (S1, S2…) y cuál es su entregable. Una sesión cumple una sola función. Si aparece trabajo de otra función, no se hace: se anota según la regla 9.
3. Los documentos largos de referencia (investigaciones, informes) se consultan con búsquedas puntuales. Nunca se cargan enteros.

## Durante
4. Respuestas cortas: pasos accionables y, si hay números, una tabla. Nada de informes largos, salvo que Moisés los pida.
5. Los costos se dan siempre como rango, con la fuente o con la marca "estimado".
6. Antes de afirmar cómo funciona una herramienta o una feature, verificarlo en su documentación o README actual.
7. Preferir lo determinista (hook, permiso, CI, script) a una instrucción en el prompt.
8. No inventar casos borde ni requisitos. Si falta información, hacer una sola pregunta.

## Al cerrar
9. **Los pendientes no se quedan en la bitácora ni en el resumen final.** Cada uno se agrega a la fila de la sesión que lo resuelve, en `fases.md`, como "Heredado de SN" en su función y con su comprobación en el "hecho cuando". Si ninguna sesión lo resuelve, va a la tabla "Pendientes sin sesión" de ese archivo, con fecha.
10. Agregar una entrada arriba de `docs/proyecto/bitacora.md` con fecha, sesión, qué se hizo y decisiones, en 8 líneas como máximo. De los pendientes, solo dice adónde se movió cada uno.
11. Actualizar `docs/proyecto/contexto.md` solo si cambió un hecho o se cerró una decisión. En ese caso, actualizar también la tabla de decisiones abiertas.
12. Si la sesión dejó una regla nueva, agregarla abajo con su fecha y la marca `[universal]` (sirve a cualquier proyecto) o `[proyecto]` (solo a este). Las `[universal]` se suben también al repo `plantilla-proyecto`.
13. Límites de tamaño: `contexto.md` hasta 150 líneas y este archivo hasta 60.
14. Si Moisés pide saltarse una regla (por ejemplo, mezclar funciones en una sesión), se hace, y la entrada de la bitácora lo marca como **excepción** con su motivo.

## Reglas aprendidas
Heredadas del Handerr Dev System.
- 2026-10-17 [universal]: Un documento gigante no sirve como herramienta de trabajo. Los entregables son de una página o una tabla.
- 2026-10-17 [universal]: Cada fase es una sesión de 1–2 h con una sola función y un "hecho cuando" comprobable. Si no cabe, se divide; no se alarga. Una sesión no se da por cerrada si su "hecho cuando" no se cumplió.
- 2026-10-17 [universal]: Estos documentos viven en `docs/proyecto/` del repo y se cambian con commits. El Project de claude.ai es una copia: si las dos versiones difieren, manda el repo.
- 2026-10-18 [universal]: Un pendiente que solo vive en la bitácora o en el resumen de una sesión se pierde. Va a la fila de la sesión que lo resuelve, con su comprobación, o a "Pendientes sin sesión" (regla 9).
