---
tipo: decision
audiencia: ambos            # humano | agente | ambos
id: ADR-NNNN
titulo: <decisión en una frase>
estado: propuesta           # propuesta | aceptada | rechazada | reemplazada
fecha: "{{date}}"
decidido-por: []
afecta: []                  # dominios o temas; es lo que se busca
reemplaza:
reemplazada-por:
origen: []                  # issue, MR/PR o sesión
resumen: <una línea; alimenta registro.md>
---
# ADR-NNNN · <título>

## En formato historia (HU)
Como <rol>, quiero <capacidad>, para <beneficio>.
Para decidir: qué se gana, qué se pierde y qué pasa si no se hace.

## Contexto

## Decisión

## Alternativas descartadas y por qué

## Consecuencias: qué obliga hoy

## Cómo se verifica: test, linter o hook (si existe)

<!-- En el código, junto a lo que esta decisión gobierna: // ADR-NNNN: <una línea> -->
