---
tipo: decision
audiencia: ambos
id: ADR-0005
titulo: Ingresos por suscripción según conexiones; el MVP muestra los planes sin cobrar
estado: aceptada
fecha: "2026-10-25"
decidido-por: [PO, Moisés]
afecta: [ingresos, suscripcion, solicitudes, metricas, mvp]
reemplaza:
reemplazada-por:
origen: [S2]
resumen: El corredor independiente paga por cantidad de conexiones (match confirmado), con el primero gratis; en el MVP solo se cuenta y se muestra la pantalla de planes.
---
# ADR-0005 · Ingresos por suscripción según conexiones; el MVP muestra los planes sin cobrar

## En formato historia (HU)
Como PO, quiero mostrar a los inversionistas cómo gana dinero la app y cuántos usuarios quieren pagar, sin construir todavía el cobro, para levantar capital con un modelo validado.
Para decidir: se gana una métrica de intención de pago con pocas horas; se pierde el ingreso real durante el MVP; si no se hace, el modelo solo existe en el pitch.

## Contexto
- El PO (25-10-2026): el corredor independiente es el público principal y debe pagar una membresía por cantidad de conexiones; el plan gratis consta de un match; los clubes son un objetivo secundario. Rechazó la palabra "freemium", que en la v0.1 se usaba para lo mismo.
- Una suscripción que desbloquea funciones dentro de la app se cobra con el sistema de cada tienda (Apple, guía 3.1.1; Google Play, política de pagos).
- En Venezuela, Apple solo acepta tarjetas de crédito o débito; Google Play vende apps de pago en el país. No está verificado si las tarjetas de los usuarios en Caracas funcionan en las tiendas.

## Decisión
- **Conexión** = match confirmado (solicitud aceptada).
- El primer match es gratis. Al pedir el segundo, la app muestra la pantalla de planes con "Próximamente" y un botón "Me interesa", y registra el evento.
- En el MVP no hay cobro real, y la pantalla no bloquea, para no cortar las métricas de uso. Esto último es propuesta y el PO puede cambiarlo.
- Pendiente con el PO (D-PO12): precios, conexiones por plan y si un match descuenta a los dos corredores o solo a quien solicita.

## Alternativas descartadas y por qué
- **Freemium por funciones** (filtros avanzados, ver quién se interesó): el PO lo descartó; el corredor independiente debe pagar.
- **Cobro real en el MVP:** +16–24 h (estimado) y el riesgo de las tarjetas en Venezuela sin resolver.
- **Packs de conexiones:** se evaluó; el PO pidió suscripción.

## Consecuencias: qué obliga hoy
- El modelo de datos cuenta los matches confirmados por usuario (S3).
- B5 suma la pantalla de planes y el evento "Me interesa" (+4–6 h, estimado).
- La consulta de métricas (B8) incluye la intención de pago.
- Antes de construir el cobro real (producto v1): verificar las tarjetas locales en las dos tiendas (D6 en `contexto.md`).

## Cómo se verifica: test, linter o hook (si existe)
- Test (B5): con un match confirmado, pedir otro muestra la pantalla de planes y guarda un evento "Me interesa" al tocar el botón.

Fuentes: https://support.apple.com/111741 · https://support.google.com/googleplay/answer/143779 · https://support.google.com/googleplay/android-developer/answer/10281818
