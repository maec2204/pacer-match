# plantilla-proyecto

El método de trabajo del Handerr Dev System, sin Handerr: sesiones con una sola función, el repo como fuente de verdad, pendientes atados a la sesión que los resuelve y un vault que leen las personas y los agentes. Cada proyecto nuevo nace de aquí.

## Crear un proyecto nuevo
1. **Repo:** en GitHub, *Use this template* → repo nuevo (privado, en tu cuenta).
2. **Project de claude.ai:** créalo, conéctale el repo y pega en sus instrucciones el texto de `docs/proyecto/instrucciones-claude-ai.md`.
3. **Sesión S0:** en Claude Code dentro del clon, `/iniciar-proyecto`. En claude.ai, «Sesión S0. Inicia el proyecto con la skill iniciar-proyecto». Te hace una ronda de preguntas y llena contexto, plan, fases y glosario.
4. **Desde S1:** «Sesión SN. Lee `docs/proyecto/reglas-de-sesion.md` y síguelo.»

Para adoptar el método en un repo que ya existe: copia `docs/proyecto/`, `vault/`, `CLAUDE.md` y `.claude/skills/` a ese repo y corre la S0. La skill detecta el stack leyendo el código en vez de preguntarlo.

## Qué hay
| Ruta | Qué es |
|---|---|
| `docs/proyecto/reglas-de-sesion.md` | Cómo trabaja cada sesión. Lo primero que lee Claude. |
| `docs/proyecto/contexto.md` | Qué es el proyecto, quién participa, el stack, principios y decisiones abiertas. Máx. 150 líneas. |
| `docs/proyecto/plan.md` | Objetivo, alcance, lo que no entra y cómo se sabe que funcionó. |
| `docs/proyecto/fases.md` | Las sesiones (S1…SN), cada una con su "hecho cuando", y la tabla "Pendientes sin sesión". |
| `docs/proyecto/bitacora.md` | Una entrada por sesión, la más nueva arriba. |
| `docs/proyecto/instrucciones-claude-ai.md` | El texto para las instrucciones del Project de claude.ai. |
| `vault/` | Notas del proyecto para personas y agentes: dominios, decisiones (ADR), cambios, guías y glosario. |
| `.claude/skills/iniciar-proyecto/` | La sesión S0. |
| `CLAUDE.md` | Lo que Claude Code carga siempre: dónde están las reglas y qué va o no en el repo. |

## Cómo se mantiene la plantilla
- **Las reglas nuevas se marcan `[universal]` o `[proyecto]`** al cerrar la sesión que las deja (regla 12). Las universales se suben aquí con un commit, para que el siguiente proyecto nazca con ellas. Los proyectos que ya existen las copian cuando les toque.
- **Lo importante vive en archivos, no en la memoria de Claude.** La memoria de cada Project de claude.ai puede estar separada de la de los demás; los archivos viajan con el repo.
- **El vault es para personas y agentes.** El campo `audiencia` del frontmatter (`humano`, `agente` o `ambos`) dice quién lo lee; una wiki o vista para un PO muestra solo `humano` y `ambos`.

## Obsidian (opcional)
Abre como vault la **raíz** del repo, no la carpeta `vault/`: obsidian-git necesita el repo entero. En *Ajustes → Plantillas*, usa `vault/plantillas`. Sincroniza con git (obsidian-git), no con Obsidian Sync.
