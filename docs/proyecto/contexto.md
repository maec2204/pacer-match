---
tipo: contexto
actualizado: "{{fecha}}"
mantenimiento: cada sesión al cerrar, solo si cambió un hecho o se cerró una decisión. Máx. 150 líneas.
---
# Contexto — {{nombre-del-proyecto}}

<!-- Lo llena la sesión S0 (skill iniciar-proyecto). Solo hechos que dijo Moisés o que están en el repo; nada supuesto. -->

## Qué es
{{Qué es el proyecto, en 3–5 líneas: qué problema resuelve y para quién.}}

Objetivo inmediato: {{lo que tiene que existir y para cuándo}}.

## Personas
| Persona o rol | Qué hace en el proyecto |
|---|---|
| Moisés | {{rol}} |

## Producto y stack
- {{plataforma, lenguajes, servicios, dónde se despliega}}
- Gestor de tareas: {{Linear, GitHub Issues, GitLab o ninguno}}. Repos: {{dónde viven}}.

## Problemas u objetivos, por prioridad
1. {{…}}

## Principios decididos
- Lo que no está en git no existe, ni para el agente ni para las personas.
- Determinista donde se pueda (hooks, permisos, CI, linters, scripts). El prompt queda para lo ambiguo.
- Instrucciones cortas: `CLAUDE.md` de 200 líneas como máximo. El detalle vive en `docs/` y `vault/` y se carga cuando hace falta.
- {{principios propios del proyecto}}

## Decisiones abiertas
| # | Decisión | Propuesta por defecto | Se cierra en |
|---|---|---|---|
| D1 | {{…}} | {{…}} | {{SN}} |

Cerradas:
- (ninguna todavía)

## Documentos del proyecto
Viven en `docs/proyecto/`; el vault, en `vault/`.
- `docs/proyecto/reglas-de-sesion.md`: cómo trabaja cada sesión. **Leerlo primero.**
- `docs/proyecto/fases.md`: las sesiones, con función, dependencias, "hecho cuando" y tiempos.
- `docs/proyecto/plan.md`: objetivo, alcance, lo que no entra y cómo se mide.
- `docs/proyecto/bitacora.md`: una entrada por sesión.
