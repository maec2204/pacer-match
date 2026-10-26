# Contexto: Pacer Match

App móvil (Flutter + Supabase) que conecta corredores por ritmo, distancia, fecha y zona para
entrenar juntos, en Caracas. MVP para un PO que busca ronda de inversión: registro → publicar o
buscar → solicitud → match → chat, con push, seguridad mínima, pantalla de planes y dorsales.

## Dónde está cada cosa
- `CLAUDE.md` y `docs/proyecto/reglas-de-sesion.md`: reglas del proyecto. Se siguen en cada sesión.
- `docs/proyecto/`: contexto, plan del MVP, fases (manda sobre `.harness/plan.yaml`), visión y bitácora.
- `DESIGN.md`: dirección visual "Pista viva", aprobada por Moisés; propuesta para el PO (D-PO8).
- `vault/`: notas por capas (`00-mapa.md` siempre; dominios al tocar su código; ADRs en `vault/decisiones/`).
- `app/` (desde S5): la app Flutter. `supabase/` (desde S6): migraciones, tests SQL y Edge Functions.

## Reglas que no se discuten
- Una sesión, una función. Lo que aparezca de otra se anota en `fases.md` (regla 9) y no se hace.
- No inventar casos borde ni requisitos. Si falta información, una tarjeta con una sola pregunta.
- El punto de encuentro exacto nunca sale de la base de datos hacia quien no tiene match: lo
  garantiza RLS, no la app. Toda sesión que toque esa regla es de riesgo alto.
- Secretos y claves (Supabase, Firebase, Google Maps, Didit) nunca en git.
- Al cerrar: entrada en la bitácora (8 líneas como máximo), su fila de `fases.md` marcada y los
  pendientes en la sesión que los resuelve.
- Nadie hace push ni fusiona a `main`: lo decide Moisés en cada hito.
