import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/config/entorno_provider.dart';
import '../../core/tema/estilo_cifra.dart';

/// Pantalla provisional: muestra el entorno activo y una cifra en Archivo
/// condensado (ancho 62) para comprobar la fuente empaquetada.
class PantallaInicio extends ConsumerWidget {
  const PantallaInicio({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activo = ref.watch(entornoProvider);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('ENTORNO'),
            Text(
              activo.name.toUpperCase(),
              key: const Key('entorno-activo'),
              style: estiloCifra(),
            ),
            const SizedBox(height: 24),
            Text(
              '62',
              key: const Key('cifra-archivo'),
              style: estiloCifra(tamano: 96),
            ),
            const Text('ANCHO DE ARCHIVO'),
          ],
        ),
      ),
    );
  }
}
