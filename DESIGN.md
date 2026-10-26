---
tipo: diseño
estado: aprobada por Moisés el 25-10-2026; propuesta para el PO (D-PO8)
actualizado: "2026-10-25"
mantenimiento: cuando el PO responde D-PO8 o una sesión cambia la dirección. Las pantallas viven en vault/sistema/pantallas.md (S4).
---
# Dirección visual: Pacer Match

**Aprobada por Moisés el 25-10-2026** después de rechazar tres direcciones estáticas: **"Pista viva": color eléctrico de borde a borde, los corredores se mueven a su ritmo y el ritmo es la cifra más grande.** Prototipo navegable con las pantallas del MVP: [Pista viva](https://claude.ai/artifact/3WgeXhnFs91ZTeQC51YWH5). Es la propuesta que se lleva al PO; él puede traer diseño propio (D-PO8). Sin logo ni nombre de marca hasta la búsqueda de marcas.

## Principios
1. **Todo se mueve al ritmo de alguien.** En Explorar, cada corredor da vueltas a la pista a una velocidad que sale de su ritmo: el de 4:50 adelanta al de 6:00. En la espera, las pisadas avanzan de ti hacia la otra persona.
2. **El ritmo es la cifra más grande de cada pantalla**, en números condensados e inclinados ("5:30 /km"). Distancia y hora lo acompañan con el mismo tratamiento.
3. **La promesa de seguridad se ve.** Antes del match, una zona que late (círculo punteado); en el match, la zona se encoge, cae el pin del punto exacto y dice "solo para ustedes dos".
4. **La gente aparece con su ritmo:** avatar con una placa de ritmo debajo, en la pista, en las tarjetas, en las solicitudes y en el match.
5. **Una sola acción fuerte por pantalla:** píldora blanca con texto en el tono. Lo secundario va en contorno blanco o como texto.

## Tokens
Contraste calculado con `contraste.py` de la skill `direccion-visual` del harness (WCAG 2.x, redondeado hacia abajo).

| Token | Valor | Uso | Contraste |
|---|---|---|---|
| `tono` | `#2533E6` | Color de la app: fondo, texto de la acción principal | blanco encima: 7,7:1 |
| `fondo` | degradado `#4351FF` → `#2533E6` → `#10187F` (180°) | Fondo de pantalla completo; oscurece hacia abajo para que la barra inferior y las acciones lean mejor | blanco sobre `#10187F`: 14,3:1 |
| `volt` | `#D8FF3E` | Placa de ritmo, "tu ritmo", zona, pisadas, verificado | tinta encima: 16,2:1; sobre `tono`: 6,7:1 |
| `tinta` | `#10140A` | Texto sobre volt y sobre blanco en placas | — |
| `superficie` | `rgba(0,0,0,.22)` + borde `rgba(255,255,255,.14)` | Tarjetas, fichas de datos, campos | — |
| `tenue` | blanco al 85 % | Texto secundario y etiquetas | 6,0:1 sobre `tono` |
| `alerta` | `#FFB4A2` | "Borrar mi cuenta" y acciones destructivas | 5,8:1 sobre `#1B27C2` |
| `mapa` / `parque` | `#0D1470` / `#18249E` | Mapa oscuro con estilo JSON (sin map ID) | — |

- **Tonos alternativos** (probados en el prototipo con el selector de tono): rojo tartán `#C83A26` y verde pista `#0B7A54`. El elegido es el azul.
- **Modo oscuro:** la app es oscura por diseño; no hay modo claro.
- **Tipografía:** Archivo para las cifras (ancho 62–70 %, peso 900, itálica, números tabulares) y Outfit para todo lo demás (400–800). Etiquetas en mayúsculas de 11–12 px con espaciado de 0,06 em. *Por verificar en S5:* si `google_fonts` sirve el eje de ancho de Archivo; si no, se empaqueta el TTF variable y se usa `fontVariations`.
- **Forma:** acciones y filtros en píldora; tarjetas con radio 20–22; chip de fecha con radio 10–12; avatares con borde blanco de 3 px. Margen lateral de 20 y ritmo de 4.
- **Toque:** 48 × 48 como mínimo. Texto base de 15–16 y respeto del tamaño de texto del sistema.
- **Movimiento** (curva de entrada `cubic-bezier(.2,.8,.2,1)`):
  - Explorar: corredores en la pista, una vuelta cada 9–13 s según su ritmo; tarjetas que suben al entrar (0,6 s, escalonadas 0,12 s).
  - Detalle: la zona late en dos anillos (2,8 s); el anfitrión flota; un brillo recorre "Pedir unirme".
  - Espera: seis pisadas que avanzan de izquierda a derecha, con el talón a la izquierda; la otra persona late y "escribe"; la barra de "Aceptada" se llena.
  - Match: los avatares entran desde los lados, "¡ES UN MATCH!" estalla, cae confeti dos veces, la zona se encoge y cae el pin; cuenta regresiva a la salida segundo a segundo.
  - Verificación: una línea volt escanea el marco de la selfie. Publicar: la zona late y el pin rebota.
  - Con "reducir movimiento" se detiene lo decorativo y queda el cambio de estado sin recorrido.

## Componentes propios
| Componente | Qué es |
|---|---|
| Pista | Óvalo de 4 carriles (bordes blancos del 34 % al 16 %). Cada corredor es un avatar con placa de ritmo; su velocidad sale del ritmo. En el centro, cuántos entrenamientos hay cerca. |
| Placa de ritmo | Píldora `volt` (o blanca si no es "tu ritmo") con el ritmo en Archivo itálica, montada sobre el borde inferior del avatar. |
| Chip de fecha | Tarjeta blanca con banda `volt` (día de la semana) y el número grande condensado. |
| Tarjeta de entrenamiento | `superficie` con chip de fecha, título, zona, ritmo enorme, distancia y anfitrión verificado; se desliza en carrusel horizontal. |
| Zona aproximada | Círculo punteado `volt` al 16 % con anillos que laten. Etiqueta "Zona aproximada · 400 m". |
| Punto exacto | Pin `volt` con borde blanco que cae al hacer match, con una onda. Siempre acompañado de "solo para ustedes dos". |
| Rastro de pisadas | Pisadas `volt` en zigzag sobre una línea punteada entre los dos avatares; avanzan hacia la otra persona y se borran detrás. |
| Ficha de dato | `superficie`, cifra en Archivo de 30–44 px y etiqueta debajo (min/km, km, min aprox.). |
| Solicitud | Avatar con placa, "identidad verificada", el mensaje como globo, "vence en N h" y Aceptar (píldora blanca) / Rechazar (contorno). |

## Referencias
- Runbuds: color saturado de borde a borde, avatares con su cifra, cifras enormes, píldoras blancas ([inicio](https://mobbin.com/screens/04f1ba5a-db89-40fd-8057-36106113b6a4), [perfil](https://mobbin.com/screens/05b59526-2d18-4d11-9c3c-aeb218bfa1a4); 122 pantallas revisadas).
- Strava, eventos de club: chip de fecha, datos del evento, organizador y barra de acción fija ([detalle](https://mobbin.com/screens/f157cfb3-2d58-4acd-a8f6-994d973fb678), [lista](https://mobbin.com/screens/19cf74bc-5fc2-4e71-97bd-e1806025eeea)).

## No hacer
- El rojo con degradado de Runbuds ni su pista como pantalla de espera: la espera usa el rastro de pisadas, propio de Pacer Match.
- El naranja de Strava.
- Emojis como adorno, tarjetas con borde lateral de color, vidrio esmerilado. El degradado del fondo sí: oscurece hacia abajo para que lean la barra inferior y las acciones.
- Mostrar la ubicación del usuario en el mapa (visión §6). La distancia "desde ti" sí se puede mostrar.
- Pin exacto antes del match, en ninguna pantalla ni miniatura.
