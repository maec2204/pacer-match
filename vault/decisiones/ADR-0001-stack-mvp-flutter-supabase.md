---
tipo: decision
audiencia: ambos
id: ADR-0001
titulo: El MVP se construye con Flutter y Supabase Free
estado: aceptada
fecha: "2026-10-18"
decidido-por: [Moisés]
afecta: [stack, app, backend, mvp]
reemplaza:
reemplazada-por:
origen: [S0]
resumen: App en Flutter (iOS y Android) y backend en Supabase Free con PostGIS, Realtime, Storage y Edge Functions.
---
# ADR-0001 · El MVP se construye con Flutter y Supabase Free

## En formato historia (HU)
Como único desarrollador, quiero un stack que entregue chat, mapas y búsqueda por radio con infraestructura ≈ US$0, para que el PO muestre un MVP usable a inversionistas sin tirarlo después.
Para decidir: se gana velocidad y costo cero; se pierde la comodidad de Expo (push y OTA); si no se hace, se monta serverless en AWS, con más horas y créditos que vencen a los 6 meses.

## Contexto
- Moisés domina Flutter y React Native. En RN ha sufrido diferencias de UI entre plataformas, como vistas cortadas por la barra de navegación de Android.
- Lo clave del MVP: chat, mapas, búsqueda por radio y ciclo de solicitudes.
- Firebase exige el plan Blaze para Storage (desde feb-2026) y para Functions. La búsqueda por radio en Firestore usa geohash y varias consultas.
- Supabase Free incluye 500 MB de Postgres con PostGIS, 50k MAU, 1 GB de Storage, Realtime (200 conexiones, 2M mensajes/mes) y 500k invocaciones de Edge Functions. El proyecto se pausa tras 1 semana sin actividad.

## Decisión
- App: Flutter, un código para iOS y Android.
- Backend: Supabase Free. PostGIS para radio y zonas, RLS para el ciclo de solicitudes, Realtime para el chat, Storage para fotos y Edge Functions para lógica y push.
- Mapas: `google_maps_flutter` sin map ID (US$0). Push: FCM. Errores: Crashlytics.

## Alternativas descartadas y por qué
- **Expo / React Native:** mismo stack que Handerr, pero arrastra las diferencias de UI entre plataformas que Moisés quiere evitar.
- **Firebase:** fotos y funciones solo en plan de pago; geo por geohash; el producto ya se decidió en Supabase (ADR-0002).
- **AWS serverless:** el terreno de Moisés, pero lento para un MVP; los créditos gratis duran 6 meses, y Aurora tarda unos 15 s en reanudarse tras una pausa (mala demo).

## Consecuencias: qué obliga hoy
- Dos proyectos Supabase gratis (dev y prod) y un ping programado contra la pausa (D5).
- Un proyecto de Firebase solo para FCM y Crashlytics; cuenta de Apple Developer para el push en iOS.
- Builds en la Mac de Moisés o en CI; no hay OTA de serie.

## Cómo se verifica: test, linter o hook (si existe)
- `flutter analyze` y `flutter test` en CI (B1).
- Tests SQL de RLS en `supabase/tests/` (S3).

Fuentes: https://supabase.com/pricing · https://firebase.google.com/pricing · https://firebase.google.com/docs/storage/faqs-storage-changes-announced-sept-2024 · https://developers.google.com/maps/billing-and-pricing/pricing
