---
tipo: decision
audiencia: ambos
id: ADR-0004
titulo: La verificación de identidad se hace con Didit, para crear y solicitar
estado: aceptada
fecha: "2026-10-25"
decidido-por: [Moisés, PO]
afecta: [verificacion, identidad, seguridad, mvp, costos]
reemplaza:
reemplazada-por:
origen: [S2]
resumen: Didit verifica documento + selfie antes de crear o solicitar un entrenamiento; plan gratis de 500 al mes; solo se guarda el resultado.
---
# ADR-0004 · La verificación de identidad se hace con Didit, para crear y solicitar

## En formato historia (HU)
Como corredor que va a encontrarse con un desconocido, quiero saber que la otra persona verificó su identidad, para sentirme seguro al ir al punto de encuentro.
Para decidir: se gana confianza, que es parte del diferencial; se pierde algo de conversión en el registro; si no se hace, la app cita a desconocidos sin ningún respaldo.

## Contexto
- Mercado de lanzamiento: Venezuela, Caracas (D-PO1, decidido por el PO el 25-10-2026).
- Didit acepta la cédula venezolana (V y E) y tiene SDK para Flutter.
- Plan gratis de Didit (página publicada el 19-08-2026): 500 verificaciones al mes por cada función (documento, prueba de vida pasiva, comparación de rostro, análisis de dispositivo e IP), sin tarjeta, contrato ni mínimo. Lo que no se usa no pasa al mes siguiente. El cupo gratis aplica cuando las funciones corren dentro de un *workflow*; las llamadas sueltas a la API se cobran.
- Alternativas revisadas en S0: Veriff (US$0,80–1,89 por verificación, con mínimo mensual), Sumsub (US$1,35–1,85, con mínimo mensual) y Stripe Identity, que solo acepta empresas con sede en EE. UU., Reino Unido, Japón y otros países en beta.
- El PO no objetó la propuesta D-PO4 (obligatoria para crear y solicitar) y preguntó si el plan gratis exige suscripción. No la exige.

## Decisión
- Didit, con un *workflow* de documento + prueba de vida pasiva + comparación de rostro.
- Obligatoria para crear un entrenamiento y para enviar una solicitud. Explorar el feed no la exige.
- Se guarda solo el resultado y el ID de la sesión de Didit. La cédula y la biometría quedan en Didit.

## Alternativas descartadas y por qué
- **Veriff y Sumsub:** cuestan más por verificación y tienen mínimo mensual.
- **Stripe Identity:** no sirve a una empresa constituida en Venezuela.
- **Sin verificación en el MVP:** se pierde el argumento de seguridad frente a inversionistas.

## Consecuencias: qué obliga hoy
- Integrar Didit por *workflow*, no con llamadas sueltas a la API, para que aplique el cupo gratis.
- El resultado llega por webhook a una Edge Function, que marca al perfil como verificado.
- Pantalla de consentimiento explícito antes de la selfie.
- Vigilar el uso mensual: por encima de 500, cada verificación cuesta cerca de US$0,30.

## Cómo se verifica: test, linter o hook (si existe)
- Test de RLS o de función (B7): un perfil sin verificar no puede insertar un entrenamiento ni una solicitud.

Fuentes: https://help.didit.me/getting-started/free-plan · https://didit.me/solutions/countries/venezuela/
