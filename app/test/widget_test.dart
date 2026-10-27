import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pacer_match/core/config/entorno.dart';
import 'package:pacer_match/core/config/entorno_provider.dart';
import 'package:pacer_match/core/tema/estilo_cifra.dart';
import 'package:pacer_match/main.dart';

void main() {
  testWidgets('muestra el entorno activo', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: PacerMatchApp()));
    await tester.pumpAndSettle();
    expect(find.text('DEV'), findsOneWidget);
  });

  testWidgets('muestra el entorno que da el provider', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [entornoProvider.overrideWithValue(Entorno.prod)],
        child: const PacerMatchApp(),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('PROD'), findsOneWidget);
  });

  testWidgets('la cifra usa Archivo con ancho 62', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: PacerMatchApp()));
    await tester.pumpAndSettle();
    final texto = tester.widget<Text>(find.byKey(const Key('cifra-archivo')));
    expect(texto.style?.fontFamily, familiaCifra);
    expect(
      texto.style?.fontVariations,
      contains(const FontVariation('wdth', 62)),
    );
  });

  test('un entorno desconocido cae en dev', () {
    expect(Entorno.fromNombre('xyz'), Entorno.dev);
    expect(Entorno.fromNombre('prod'), Entorno.prod);
  });
}
