import 'dart:typed_data';

import '../../core/dominio/ritmo.dart';

/// Perfil del corredor (ver `vault/glosario.md`).
class Perfil {
  const Perfil({
    required this.ritmoRodaje,
    required this.foto,
    required this.ciudad,
    required this.mayorDeEdad,
  });

  /// Ritmo promedio de su rodaje.
  final Ritmo ritmoRodaje;

  /// Foto recortada, en bytes. Subirla al servidor llega con Supabase.
  final Uint8List foto;

  /// Texto libre.
  final String ciudad;

  /// Marcó "Tengo 18 años o más".
  final bool mayorDeEdad;
}
