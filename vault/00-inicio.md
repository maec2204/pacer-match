---
tipo: inicio
audiencia: humano
estado: esqueleto
revisado: "2026-10-18"
---
# Vault de Pacer Match

Aquí vive lo que no debe quedarse en la cabeza de nadie: cómo funciona cada parte, qué se decidió, cuándo y por qué. Lo leen las personas (en Obsidian o en una vista web) y los agentes como contexto.

## Qué hay en cada carpeta
| Carpeta | Qué contiene |
|---|---|
| `00-mapa.md` | Índice para los agentes: dominio → nota → código. Se genera desde el frontmatter; no se edita a mano. |
| `glosario.md` | Término de negocio ↔ identificador en el código (tal cual). |
| `sistema/` | Visión general: arquitectura y flujos principales. |
| `dominios/` | Una nota por dominio: qué hace, sus reglas, sus contratos y lo que no hace. |
| `integraciones/` | Una nota por integración externa. |
| `decisiones/` | Una decisión por archivo (`ADR-NNNN-…`) y `registro.md`, el índice cronológico. |
| `cambios/` | Un archivo por cambio de contrato, regla o dato que otros deben conocer. |
| `guias/` | Cómo hacer X en este proyecto. |
| `plantillas/` | Plantillas de dominio, decisión y cambio. |

## Cómo encontrar algo
- **¿Cómo funciona X?** Busca el dominio en `dominios/` o en `00-mapa.md`.
- **¿Qué se decidió sobre X, y cuándo?** Abre `decisiones/registro.md`, o busca `afecta:` con el tema en `decisiones/`.
- **¿Qué cambió?** Mira `cambios/`, ordenado por fecha.

## Reglas
- **Los cambios de otras personas entran por PR/MR;** Moisés revisa. El vault es contexto para los agentes, y revisar es la defensa contra notas equivocadas.
- **Una nota, un tema, máximo 150 líneas.** Si crece, se divide.
- **Cada hecho vive en un solo lugar.** Lo demás enlaza con `[[nota]]`.
- **Las decisiones tienen fecha y estado.** Una reemplazada no se borra: se marca `reemplazada` y apunta a la nueva.
- **`audiencia` en cada nota:** `humano` (solo personas), `agente` (contexto técnico para los agentes) o `ambos`. Una vista para un PO muestra `humano` y `ambos`.
- **La prosa va en español y el código tal cual:** tablas, rutas y funciones con su nombre real.
- **Las vistas de Obsidian (Bases, Dataview) son para personas.** El agente necesita las listas como texto; por eso `00-mapa.md` y `decisiones/registro.md` se generan.
