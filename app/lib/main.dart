import 'package:flutter/material.dart';

import 'features/inicio/pantalla_inicio.dart';

void main() => runApp(const PacerMatchApp());

class PacerMatchApp extends StatelessWidget {
  const PacerMatchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pacer Match',
      theme: ThemeData(brightness: Brightness.dark, useMaterial3: true),
      home: const PantallaInicio(),
    );
  }
}
