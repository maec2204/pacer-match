---
tipo: decision
audiencia: ambos
id: ADR-0002
titulo: El producto sigue en Supabase Pro y migra por piezas a AWS al escalar
estado: aceptada
fecha: "2026-10-18"
decidido-por: [Moisés]
afecta: [stack, backend, producto, costos]
reemplaza:
reemplazada-por:
origen: [S0]
resumen: Producto en Supabase Pro (desde US$25/mes); al escalar, migración por piezas a AWS porque es Postgres estándar.
---
# ADR-0002 · El producto sigue en Supabase Pro y migra por piezas a AWS al escalar

## En formato historia (HU)
Como responsable técnico, quiero que el producto crezca sobre la base del MVP, para no reescribir el backend cuando lleguen la inversión y los usuarios.
Para decidir: se gana continuidad y bajo costo base; se pierde control fino de infraestructura frente a AWS; si no se hace, la v1 empieza con una reescritura.

## Contexto
- MVP en Supabase (ADR-0001).
- Supabase Pro: desde US$25/mes, con 100k MAU, 8 GB de base de datos, 100 GB de archivos, 250 GB de tráfico saliente y 500 conexiones de Realtime.
- Supabase es Postgres estándar, así que la base, las funciones y los archivos se pueden mover por separado.

## Decisión
- Producto v1 en Supabase Pro.
- Cuando el volumen, el costo o un cliente lo pidan, se migra por piezas a AWS: base de datos a RDS/Aurora, funciones a Lambda y archivos a S3, una pieza a la vez.

## Alternativas descartadas y por qué
- **AWS serverless desde la v1:** más control, pero obliga a reescribir el backend del MVP y suma operación para una sola persona.
- **Firebase / GCP:** geo por geohash, sin joins y con lock-in fuerte.

## Consecuencias: qué obliga hoy
- La lógica de negocio vive en SQL estándar y en funciones fáciles de portar. Nada atado a extensiones exclusivas de Supabase sin una alternativa en RDS.

## Cómo se verifica: test, linter o hook (si existe)
- Las migraciones de `supabase/migrations/` aplican en un Postgres + PostGIS limpio (S3).

Fuente: https://supabase.com/pricing
