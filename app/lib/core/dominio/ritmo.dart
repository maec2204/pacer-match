/// Ritmo en min/km con precisión de décima de segundo (ver `vault/glosario.md`).
///
/// Se guarda como un entero de décimas para que comparar sea exacto:
/// "4:05.3" → 2453. Menor es más rápido.
class Ritmo implements Comparable<Ritmo> {
  const Ritmo._(this.decimas);

  /// Décimas de segundo por kilómetro. Siempre mayor que cero.
  final int decimas;

  /// Segundos por kilómetro: "4:05.3" → 245.3.
  double get segundos => decimas / 10;

  // M:SS o M:SS.d — minutos de 1 o 2 cifras, segundos 00–59, una décima opcional.
  static final _formato = RegExp(r'^(\d{1,2}):([0-5]\d)(?:\.(\d))?$');

  /// Lee "M:SS.d" o "M:SS". Lanza [FormatException] si el texto no cumple
  /// el formato o vale 0:00.
  static Ritmo parse(String texto) =>
      tryParse(texto) ??
      (throw FormatException('Ritmo mal escrito (se espera M:SS.d)', texto));

  /// Como [parse], pero devuelve `null` en vez de lanzar.
  static Ritmo? tryParse(String texto) {
    final m = _formato.firstMatch(texto);
    if (m == null) return null;
    final decimas =
        (int.parse(m[1]!) * 60 + int.parse(m[2]!)) * 10 +
        int.parse(m[3] ?? '0');
    return decimas == 0 ? null : Ritmo._(decimas);
  }

  /// Siempre "M:SS.d": 2450 → "4:05.0".
  @override
  String toString() {
    final minutos = decimas ~/ 600;
    final segundos = (decimas ~/ 10) % 60;
    return '$minutos:${segundos.toString().padLeft(2, '0')}.${decimas % 10}';
  }

  @override
  int compareTo(Ritmo otro) => decimas.compareTo(otro.decimas);

  /// `a < b`: `a` es más rápido que `b`.
  bool operator <(Ritmo otro) => decimas < otro.decimas;
  bool operator <=(Ritmo otro) => decimas <= otro.decimas;
  bool operator >(Ritmo otro) => decimas > otro.decimas;
  bool operator >=(Ritmo otro) => decimas >= otro.decimas;

  @override
  bool operator ==(Object other) => other is Ritmo && other.decimas == decimas;

  @override
  int get hashCode => decimas.hashCode;
}
