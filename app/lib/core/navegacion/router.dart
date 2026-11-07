import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/inicio/pantalla_inicio.dart';
import '../../features/perfil/pantalla_perfil_nuevo.dart';

/// Rutas de la app. Cada funcionalidad agrega las suyas aquí.
abstract final class Rutas {
  static const String inicio = '/';

  /// Formulario del perfil. Sin conectar al recorrido hasta S4.
  static const String perfilNuevo = '/perfil/nuevo';
}

final routerProvider = Provider<GoRouter>(
  (ref) => GoRouter(
    initialLocation: Rutas.inicio,
    routes: [
      GoRoute(
        path: Rutas.inicio,
        builder: (context, state) => const PantallaInicio(),
      ),
      GoRoute(
        path: Rutas.perfilNuevo,
        builder: (context, state) => const PantallaPerfilNuevo(),
      ),
    ],
  ),
);
