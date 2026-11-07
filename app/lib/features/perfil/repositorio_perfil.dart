import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'perfil.dart';

/// Dónde se guarda el perfil. La versión en Supabase llega con S3 y S6.
abstract interface class RepositorioPerfil {
  Future<void> guardar(Perfil perfil);
}

/// Guarda el perfil en memoria; se pierde al cerrar la app.
class RepositorioPerfilEnMemoria implements RepositorioPerfil {
  /// Último perfil guardado, o `null` si todavía no hay.
  Perfil? guardado;

  @override
  Future<void> guardar(Perfil perfil) async => guardado = perfil;
}

/// Repositorio de perfil activo. Las pruebas lo sustituyen con override.
final repositorioPerfilProvider = Provider<RepositorioPerfil>(
  (ref) => RepositorioPerfilEnMemoria(),
);
