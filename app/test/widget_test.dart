import 'package:flutter_test/flutter_test.dart';
import 'package:pacer_match/core/config/entorno.dart';
import 'package:pacer_match/main.dart';

void main() {
  testWidgets('muestra el entorno activo', (tester) async {
    await tester.pumpWidget(const PacerMatchApp());
    expect(find.text('DEV'), findsOneWidget);
  });

  test('un entorno desconocido cae en dev', () {
    expect(Entorno.fromNombre('xyz'), Entorno.dev);
    expect(Entorno.fromNombre('prod'), Entorno.prod);
  });
}
