/// Entorno activo, fijado al compilar con `--dart-define=ENTORNO=dev|prod`.
enum Entorno {
  dev,
  prod;

  static const String _valor =
      String.fromEnvironment('ENTORNO', defaultValue: 'dev');

  /// Entorno de esta compilación. Un valor desconocido cae en [dev].
  static Entorno get actual => fromNombre(_valor);

  static Entorno fromNombre(String nombre) => Entorno.values
      .firstWhere((e) => e.name == nombre, orElse: () => Entorno.dev);
}
