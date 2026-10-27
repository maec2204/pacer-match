---
tipo: plan
actualizado: "2026-10-26"
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
- Fondos y avatares desbloqueables, pacers de marca y patrocinios — por qué: son hipótesis de ingresos para el producto (`vision.md` §8), propuestas a la PO el 26-10; en el MVP, a lo sumo una marca ficticia en la demo.
- Buzón de soporte — por qué: no estaba en el estimado; se propuso a la PO el 26-10 como línea aparte (D-PO13, abajo en Ajustes).

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

A ~20 h/semana: 6–8 semanas. Ajustes (estimado): cobro real con Apple y Google +16–24 h; entrenamientos grupales +12–20 h; registro básico de recorrido +16–24 h; buzón de soporte por Telegram +~4 h (D-PO13, propuesto el 26-10); confirmar que los dos corrieron antes de otorgar un dorsal, por estimar si la PO lo pide.

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
Cada costo va anclado al bloque que lo necesita. Las cuentas van a nombre de la PO, con Moisés invitado; como no hay empresa constituida (26-10), son cuentas personales y no aplica el número D-U-N-S.

| Cuándo | Concepto | Costo | Por qué | Fuente |
|---|---|---|---|---|
| S6 (B1) | Supabase Free | US$0/mes | Base de datos, cuentas, fotos y chat | [supabase.com/pricing](https://supabase.com/pricing) |
| S8 (B1) | FCM y Crashlytics | US$0 | Push y reporte de errores | [firebase.google.com/pricing](https://firebase.google.com/pricing) |
| B2 | Dominio | ~US$10–15/año (estimado) | Remitente propio de los correos y página de privacidad y borrado. Se compra después de cerrar el nombre (D-PO10) | — |
| B2 | Correo de registro con Resend Free | US$0 hasta 3.000/mes y 100/día | Sin SMTP propio, Supabase manda solo 2 correos de registro por hora | [resend.com/pricing](https://resend.com/pricing) · [Supabase](https://supabase.com/docs/guides/deployment/going-into-prod) |
| B2 | Imágenes | US$0 | Biblioteca gratuita con licencia de uso comercial | — |
| B3 | Google Maps SDK móvil sin map ID | US$0 | El mapa; la cuenta de facturación de Google Cloud pide tarjeta, con cuotas y alertas | [Google Maps pricing](https://developers.google.com/maps/billing-and-pricing/pricing) |
| B3 | Geocodificación / autocompletado | US$0 hasta 10.000/mes cada uno | Dirección del punto de encuentro | ídem |
| Antes de B5 | Apple Developer Program | US$99/año | Push en iPhone y TestFlight | [developer.apple.com](https://developer.apple.com/support/compare-memberships/) |
| B7 | Didit | US$0 hasta ~30 verificaciones completas al mes; luego US$0,33 c/u | Desde el 1-11-2026 el plan gratis es un crédito de US$10 al mes (antes, 500 al mes) | [Didit, precios nuevos](https://didit.me/blog/new-pricing-november-2026/) |
| B7 | Privacidad y términos | Variable | Las tiendas exigen el enlace; plantilla revisada o abogado (revisión legal en "Pendientes sin sesión") | — |
| Antes de B8 | Google Play | US$25, pago único | Prueba interna para repartir el MVP. Publicar en la tienda con cuenta personal exige antes 12 testers durante 14 días seguidos (producto) | [Play Console](https://support.google.com/googleplay/android-developer/answer/14151465) |
| Ronda de demos | Supabase Pro (opcional) | US$25/mes | Evita la pausa del plan gratis durante las demos | [supabase.com/pricing](https://supabase.com/pricing) |

**Total del MVP:** unos US$134–139 el primer año en cuentas y dominio (estimado) + US$0/mes de infraestructura (US$25/mes si se usa Pro durante las demos). Aparte: la revisión legal y las verificaciones por encima del crédito de Didit. Las horas de desarrollo van en el presupuesto (S1).

**Fuera de este plan (propuesto a la PO el 26-10):** el mantenimiento técnico (errores, actualizaciones, disponibilidad) va en un contrato aparte con bolsa de horas mensual, sin atención a usuarios ni moderación.

## Después
Producto v1 según `vision.md`: Supabase Pro, login social completo, cobro de la suscripción por conexiones, valoraciones, insignias, ritmo verificado con actividades importadas, compartir el plan, panel de moderación y publicación en tiendas.
