---
tipo: plan
actualizado: "2026-10-25"
mantenimiento: cuando cambia el objetivo o el alcance. Las sesiones viven en fases.md; el producto real, en vision.md.
---
# Plan — Pacer Match (MVP)

## Objetivo
Una app instalable en iOS y Android que recorra el flujo completo —registro → publicar o buscar un entrenamiento → solicitud → match → chat— con push y seguridad mínima, para que el PO la muestre a inversionistas. Infraestructura ≈ US$0/mes. Fecha (D-PO9): 5–7 semanas a ~20 h/semana desde que arranca la construcción; si arranca esta semana, entre fin de noviembre y mediados de diciembre de 2026. Con los dorsales (B9), el estimado sube a 6–8 semanas; falta acordarlo con el PO.

## Qué entra
- Registro con correo y perfil de corredor (foto, ritmo, ciudad, 18+). Apple y Google, si caben.
- Verificación de identidad con Didit para crear y solicitar (ADR-0004).
- Crear entrenamiento con pin en el mapa; zona aproximada antes del match y punto exacto después.
- Feed con filtros de radio (PostGIS), ritmo y fecha.
- Solicitud con mensaje; aceptar, rechazar, cancelar y expiración automática.
- Chat 1:1 en tiempo real y notificaciones push.
- Primer match gratis y pantalla de planes sin cobro real, que registra "Me interesa" (ADR-0005).
- Reportar, bloquear y borrar cuenta (en la app y por enlace web).
- Interfaz con la dirección visual propia (`DESIGN.md`) y referencias de Mobbin; imágenes de una biblioteca gratuita.
- Eventos para las métricas de la visión (sección 11), incluida la intención de pago, y datos de demo.
- Dorsales coleccionables que se ganan corriendo acompañado (gamificación pedida por la PO).
- Distribución por TestFlight y prueba interna de Google Play.

Detalle de MVP frente a producto: `vision.md` §5.

## Qué no entra (por ahora)
- Registro propio de recorrido y pasos — por qué: es lo más caro y compite con Strava; el producto importará actividades (ADR-0003).
- Web — por qué: un solo código móvil; la web llega en el producto como landing.
- Cobro real con Apple y Google — por qué: primero se mide la intención de pago y falta verificar que las tarjetas venezolanas funcionen en las tiendas (ADR-0005, D6).
- Filtro por distancia y marcas 10k/21k/42k — por qué: el PO lo recortó del MVP.
- Plan para clubes — por qué: el PO lo dejó como objetivo secundario.
- Entrenamientos grupales — por qué: el spec describe 1:1; espera D-PO2.
- Valoraciones, ritmo verificado, panel de administración — por qué: son del producto v1; en el MVP se modera desde Supabase.

## Estimado por bloque (estimado)
Supuestos: 1:1, sin diseñador (dirección visual propia, aplicada por Moisés), sin tracking ni web, desarrollo asistido por IA.

| Bloque | Qué incluye | Horas |
|---|---|---|
| S1–S4 | Presupuesto, cierre con el PO, modelo de datos, flujo de pantallas | 6–8 |
| B1 Fundaciones | Proyecto Flutter, entornos dev/prod, Supabase, CI, Crashlytics, FCM, ping anti-pausa | 6–10 |
| B2 Registro y perfil | Auth, onboarding, foto, ritmo, permisos en contexto | 10–16 |
| B3 Entrenamientos | Modelo + RLS, crear con mapa, zona aproximada, editar y cancelar | 10–14 |
| B4 Feed y filtros | Consulta por radio, ritmo y fecha; tarjetas; modo visitante | 10–14 |
| B5 Solicitudes y push | Enviar, bandeja, aceptar/rechazar, cancelar, expirar, push; primer match gratis y pantalla de planes | 16–24 |
| B6 Chat | Realtime 1:1, lista de chats, no leídos, push de mensaje | 8–12 |
| B7 Confianza y tiendas | Didit, reportar/bloquear, borrar cuenta, privacidad y términos | 12–18 |
| B8 Demo y entrega | Datos de demo, métricas, QA en dispositivos reales, TestFlight y Play | 10–14 |
| B9 Dorsales | Reglas de cada dorsal, otorgarlos al confirmar matches, colección, momento de ganar uno y tira en el perfil | 8–12 |
| Dirección visual | Componentes propios de `DESIGN.md` (zona aproximada, punto exacto, placa de ritmo, chip de fecha, cifra, barra de acción), repartidos en B2–B6 | 6–10 |
| **Total** | | **102–152 h** |

A ~20 h/semana: 6–8 semanas. Ajustes (estimado): cobro real con Apple y Google +16–24 h; entrenamientos grupales +12–20 h; registro básico de recorrido +16–24 h.

## Cómo se sabe que funcionó
| Criterio | Cómo se comprueba |
|---|---|
| Flujo completo en iOS y Android | Demo grabada en dos dispositivos reales, de registro a chat |
| Instalable por testers | Build activo en TestFlight y en la prueba interna de Google Play |
| El punto exacto no se filtra antes del match | Test de RLS: un usuario sin match no lee las coordenadas exactas |
| Métricas disponibles | Una consulta devuelve las 6 métricas de la visión (sección 11) |
| Pantalla de planes | Con un match confirmado, pedir otro muestra los planes y "Me interesa" queda registrado |
| Infraestructura ≈ US$0 | Facturas de Supabase, Google Cloud y Firebase en US$0 durante el MVP |
| El PO lo aprueba | El PO acepta la demo |

## Costos
| Concepto | Costo | Fuente |
|---|---|---|
| Supabase Free | US$0/mes | [supabase.com/pricing](https://supabase.com/pricing) |
| Google Maps SDK móvil sin map ID | US$0 | [Google Maps pricing](https://developers.google.com/maps/billing-and-pricing/pricing) |
| Geocodificación / autocompletado | US$0 hasta 10.000/mes cada uno | ídem |
| FCM y Crashlytics | US$0 | [firebase.google.com/pricing](https://firebase.google.com/pricing) |
| Didit | US$0 hasta 500 al mes por función, sin tarjeta ni suscripción; luego ≈ US$0,30 c/u | [help.didit.me](https://help.didit.me/getting-started/free-plan) |
| Imágenes | US$0 (biblioteca gratuita con licencia de uso comercial) | — |
| Apple Developer Program | US$99/año; hace falta antes de B5 (push en iPhone) y para TestFlight | [developer.apple.com](https://developer.apple.com/support/compare-memberships/) |
| Google Play | US$25, pago único | [Play Console](https://support.google.com/googleplay/android-developer/answer/6112435) |
| Supabase Pro durante la ronda (opcional) | US$25/mes | [supabase.com/pricing](https://supabase.com/pricing) |
| Página de privacidad y borrado de cuenta | US$0–15/año, si se compra dominio (estimado) | — |

**Total del MVP:** US$124 el primer año en cuentas + US$0/mes de infraestructura (US$25/mes si se usa Pro durante las demos). Las horas de desarrollo van en el presupuesto (S1).

## Después
Producto v1 según `vision.md`: Supabase Pro, login social completo, cobro de la suscripción por conexiones, valoraciones, insignias, ritmo verificado con actividades importadas, compartir el plan, panel de moderación y publicación en tiendas.
