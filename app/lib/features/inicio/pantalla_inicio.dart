import 'package:flutter/material.dart';

import '../../core/config/entorno.dart';

/// Pantalla provisional: muestra el entorno activo.
class PantallaInicio extends StatelessWidget {
  const PantallaInicio({super.key, this.entorno});

  final Entorno? entorno;

  @override
  Widget build(BuildContext context) {
    final activo = entorno ?? Entorno.actual;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('ENTORNO'),
            Text(
              activo.name.toUpperCase(),
              key: const Key('entorno-activo'),
              style: const TextStyle(
                fontSize: 64,
                fontWeight: FontWeight.w900,
                fontStyle: FontStyle.italic,
                fontFeatures: [FontFeature.tabularFigures()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
