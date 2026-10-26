---
tipo: diseño
estado: propuesta para el PO (D-PO8)
actualizado: "2026-10-25"
mantenimiento: cuando el PO responde D-PO8 o S4 cambia la dirección. Las pantallas viven en vault/sistema/pantallas.md (S4).
---
# Dirección visual — Pacer Match

**Elegida por Moisés el 25-10-2026** entre tres direcciones ([lienzo](https://claude.ai/artifact/Dv3Z1FRndZApA7ccc6xbbc), fila "Elegida"): **el lugar manda y el ritmo se lee de un vistazo.** Es una propuesta: el PO puede traer diseño propio (D-PO8). Sin logo ni nombre de marca hasta la búsqueda de marcas.

## Principios
1. **La promesa de seguridad se ve.** Antes del match, una zona (círculo punteado); después, el punto exacto (pin). El paso de zona a punto es el momento central de la app.
2. **El ritmo es la cifra más grande** de cada pantalla, en números condensados. Distancia y hora lo acompañan con el mismo tratamiento.
3. **La gente aparece con su ritmo:** avatar con una placa de ritmo encima, en el mapa y en el match.
4. **Una sola acción fuerte por pantalla**, en rojo tartán. El resto, azul marino o contorno.

## Tokens
| Token | Valor | Uso | Contraste |
|---|---|---|---|
| `tinta` | `#13263A` | Texto, botón secundario, fondo del match | 15,4:1 sobre blanco |
| `tenue` | `#4A5D6B` | Texto secundario, etiquetas | 6,8:1 sobre blanco |
| `fondo` | `#F3F5F2` | Fondo de pantalla, campos | — |
| `linea` | `#E1E6E3` | Separadores | — |
| `tartan` | `#C23E22` | Acción principal, placa de ritmo, banda del día | blanco encima: 5,2:1 |
| `parque` | `#1E6E46` | Zona aproximada, verificado | 6,2:1 sobre blanco |
| `mapa` | `#E3E8E4` · parque `#CFE0D3` · agua `#C9DCE6` · calles `#FFFFFF` | Estilo JSON del mapa (sin map ID) | — |

- **Tipografía:** Archivo, una sola familia con eje de ancho. Cifras en ancho 62–75 y peso 800–900 con números tabulares; textos en ancho 100 y peso 400–800. Etiquetas en mayúsculas, 11–12 px, con espaciado de 0,08 em. *Por verificar en S5:* si `google_fonts` sirve el eje `wdth`; si no, se empaqueta el TTF variable y se usa `fontVariations`.
- **Forma:** acciones y filtros en píldora (radio completo); hoja inferior con radio 22; campos con radio 14; chip de fecha con radio 8–10. Margen lateral de 20 y ritmo de 4.
- **Toque:** mínimo 44 × 44 (iOS) y 48 × 48 (Android); se usa 48.

## Componentes propios
| Componente | Qué es |
|---|---|
| Zona aproximada | Círculo de radio real, relleno `parque` al 16 % y borde punteado de 2 px. Etiqueta "Zona aproximada · 400 m". |
| Punto exacto | Pin `tartan` con borde blanco de 5 px. Solo existe tras el match y dice "solo para ustedes dos". |
| Placa de ritmo | Avatar con borde (`parque` si es quien publica) y, encima del borde inferior, una píldora `tartan` con el ritmo. |
| Chip de fecha | Banda superior con el día de la semana o el mes (`tartan` si es lo próximo, `tinta` si no) y el número grande condensado. |
| Cifra | Número condensado grande y unidad pequeña en `tenue` ("5:30 /km"). |
| Barra de acción | Fija abajo: una acción secundaria redonda y la principal en píldora `tartan`. |

## Referencias (Mobbin)
- Strava, detalle de evento de club: estructura de chip de fecha, datos, organizador y barra fija ([1](https://mobbin.com/screens/f157cfb3-2d58-4acd-a8f6-994d973fb678), [2](https://mobbin.com/screens/6eed7f76-44ec-4728-951c-d776178f7e6c), [lista](https://mobbin.com/screens/19cf74bc-5fc2-4e71-97bd-e1806025eeea)).
- Runbuds: avatares con placa de ritmo sobre la pista, cifras en tarjetas y CTA en píldora ([inicio](https://mobbin.com/screens/04f1ba5a-db89-40fd-8057-36106113b6a4), [perfil](https://mobbin.com/screens/05b59526-2d18-4d11-9c3c-aeb218bfa1a4)).
- Luma y Eventbrite: tarjeta de ubicación dentro del detalle.

## No hacer
- El naranja de Strava ni el rojo con degradado a pantalla completa de Runbuds: el tartán va en piezas pequeñas.
- Degradados, emojis, tarjetas con borde lateral de color, vidrio esmerilado.
- Mostrar la ubicación del usuario en el mapa (visión §6). La distancia "desde ti" sí se puede mostrar.
- Pin exacto antes del match, en ninguna pantalla ni miniatura.
