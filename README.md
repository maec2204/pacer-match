# Pacer Match

App móvil que conecta corredores para entrenar juntos según ritmo (min/km), distancia, fecha y zona, con identidad verificada y punto de encuentro protegido hasta que hay match.

## Estado
- **S0 hecha (2026-10-18):** spec del PO comentado, stack decidido, visión del producto y plan del MVP.
- **Siguiente:** S1, presupuesto del MVP para el PO.
- **Stack:** Flutter (iOS y Android) + Supabase (Postgres/PostGIS, Auth, Realtime, Storage, Edge Functions). Ver `vault/decisiones/registro.md`.

## Documentos
| Ruta | Qué es |
|---|---|
| `docs/proyecto/vision.md` | Visión del producto real para el PO: objetivos, alcance, arquitectura, riesgos y decisiones abiertas. |
| `docs/proyecto/plan.md` | Plan del MVP: alcance, estimado por bloque y costos. |
| `docs/proyecto/fases.md` | Sesiones y bloques, cada uno con su "hecho cuando". |
| `docs/proyecto/contexto.md` | Qué es, quién participa, stack y decisiones abiertas. |
| `docs/proyecto/bitacora.md` | Una entrada por sesión. |
| `docs/proyecto/reglas-de-sesion.md` | Cómo trabaja cada sesión. |
| `vault/` | Dominios, decisiones (ADR), cambios, guías y glosario. |

## Cómo se trabaja
Cada sesión tiene una sola función y arranca con:

> «Sesión SN. Lee `docs/proyecto/reglas-de-sesion.md` y síguelo.»

Las sesiones de documentos y decisiones corren en el Project de claude.ai; las de código, en Claude Code dentro del clon.
