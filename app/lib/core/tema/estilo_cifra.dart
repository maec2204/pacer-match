import 'package:flutter/painting.dart';

/// Familia de las cifras: Archivo variable empaquetada (ADR-0006).
const String familiaCifra = 'Archivo';

/// Estilo de las cifras de Pista viva: Archivo condensada (ancho 62), peso 900,
/// itálica y números tabulares. El ancho se fija con `fontVariations`, porque
/// `google_fonts` no sirve ese eje (ver DESIGN.md).
TextStyle estiloCifra({double tamano = 64, Color? color}) => TextStyle(
      fontFamily: familiaCifra,
      fontSize: tamano,
      color: color,
      fontWeight: FontWeight.w900,
      fontStyle: FontStyle.italic,
      fontVariations: const [
        FontVariation('wdth', 62),
        FontVariation('wght', 900),
      ],
      fontFeatures: const [FontFeature.tabularFigures()],
    );
