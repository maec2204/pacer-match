import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'entorno.dart';

/// Entorno activo de esta compilación. Las pruebas lo sustituyen con override.
final entornoProvider = Provider<Entorno>((ref) => Entorno.actual);
