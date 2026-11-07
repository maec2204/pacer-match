import '../../core/dominio/ritmo.dart';

/// Perfil del corredor (ver `vault/glosario.md`). Todavía sin foto.
class Perfil {
  const Perfil({
    required this.ritmoRodaje,
    required this.ciudad,
    required this.mayorDeEdad,
  });

  /// Ritmo promedio de su rodaje.
  final Ritmo ritmoRodaje;

  /// Texto libre.
  final String ciudad;

  /// Marcó "Tengo 18 años o más".
  final bool mayorDeEdad;
}
