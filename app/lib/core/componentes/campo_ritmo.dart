import 'package:flutter/material.dart';

import '../dominio/ritmo.dart';
import '../tema/estilo_cifra.dart';

/// Campo de ritmo compartido (perfil, entrenamiento y filtro): la cifra grande
/// con − / +, de segundo en segundo. No guarda nada: muestra [valor] y avisa
/// con [alCambiar].
class CampoRitmo extends StatelessWidget {
  const CampoRitmo({super.key, required this.valor, required this.alCambiar});

  /// Ritmo que se muestra; `null` es "sin ritmo".
  final Ritmo? valor;

  final ValueChanged<Ritmo> alCambiar;

  /// Desde donde parte el primer − / + cuando no hay ritmo.
  static final Ritmo inicial = Ritmo.parse('5:00.0');

  static const String _vacio = '–:––.–';

  void _mover(int segundos) =>
      alCambiar(valor?.sumarSegundos(segundos) ?? inicial);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(icon: const Icon(Icons.remove), onPressed: () => _mover(-1)),
        Text(valor?.toString() ?? _vacio, style: estiloCifra()),
        const SizedBox(width: 6),
        const Text('/km'),
        IconButton(icon: const Icon(Icons.add), onPressed: () => _mover(1)),
      ],
    );
  }
}
