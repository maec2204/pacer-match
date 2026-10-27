---
tipo: decision
audiencia: ambos
id: ADR-0006
titulo: Estado con Riverpod, navegación con go_router y Archivo variable empaquetada
estado: aceptada
fecha: "2026-10-26"
decidido-por: [Moisés]
afecta: [app, estado, navegacion, tipografia, mvp]
reemplaza:
reemplazada-por:
origen: [S5]
resumen: La app usa flutter_riverpod para el estado, go_router para navegar y el TTF variable de Archivo empaquetado, sin google_fonts.
---
# ADR-0006 · Estado con Riverpod, navegación con go_router y Archivo variable empaquetada

## En formato historia (HU)
Como Moisés, que construye las pantallas de B2 a B9, quiero fijar ahora cómo se maneja el estado, cómo se navega y cómo se carga la fuente de las cifras, para que todas las pantallas sigan el mismo patrón y la cifra condensada se vea igual en cualquier teléfono, con o sin red.
Para decidir: se gana un patrón único y una fuente que no depende de la red; se pierde la comodidad de `google_fonts`; si se cambia el estado después de B2, cuesta 10–20 h (estimado).

## Contexto
- D3 (estado y navegación) estaba abierta con propuesta Riverpod + go_router; se cierra en S5.
- `DESIGN.md` pide Archivo con ancho 62 para las cifras. Se comprobó que `google_fonts` 9.0.0 no sirve el eje de ancho: su `GoogleFonts.archivo()` no acepta `fontVariations` y descarga archivos estáticos por peso e itálica (alrededor de 110 KB cada uno), no el variable (658 KB). El TTF variable del repo de Google Fonts sí trae los ejes `wdth` 62–125 y `wght` 100–900.

## Decisión
- Estado: `flutter_riverpod`. Navegación: `go_router`. Ambos en su última versión estable al día de hoy (3.4.3 y 18.1.1 en `pubspec.lock`).
- Fuente: Archivo variable (normal e itálica) empaquetada en `app/assets/fonts/` con su licencia OFL, y declarada en `pubspec.yaml`. El ancho se fija con `fontVariations` (`estiloCifra()` en `core/tema/`).
- No se agrega `google_fonts`. Outfit, el resto de la tipografía, se resolverá en la sesión que construya el tema, con la misma regla: empaquetada.

## Alternativas descartadas y por qué
- **google_fonts:** no sirve el eje de ancho; habría que empaquetar el TTF igual, y quedaría una dependencia de red.
- **Bloc + auto_route:** más ceremonia y código generado.
- **Navigator 2.0 + setState:** cero dependencias, pero no escala a deep links ni a chat, y se rehace en B2.

## Consecuencias: qué obliga hoy
- Todo estado compartido va en providers de Riverpod; las rutas se declaran en `core/navegacion/router.dart`.
- Las pruebas sustituyen dependencias con `overrideWithValue` en `ProviderScope`.
- La app pesa ~1,4 MB más por las dos fuentes variables.
