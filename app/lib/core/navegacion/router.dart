import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/inicio/pantalla_inicio.dart';

/// Rutas de la app. Cada funcionalidad agrega las suyas aquí.
abstract final class Rutas {
  static const String inicio = '/';
}

final routerProvider = Provider<GoRouter>(
  (ref) => GoRouter(
    initialLocation: Rutas.inicio,
    routes: [
      GoRoute(
        path: Rutas.inicio,
        builder: (context, state) => const PantallaInicio(),
      ),
    ],
  ),
);
