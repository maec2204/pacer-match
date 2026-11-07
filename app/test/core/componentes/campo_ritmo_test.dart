import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pacer_match/core/componentes/campo_ritmo.dart';
import 'package:pacer_match/core/dominio/ritmo.dart';

/// Monta el campo con [valor] y devuelve la lista de lo que entrega `alCambiar`.
Future<List<Ritmo>> montar(WidgetTester tester, Ritmo? valor) async {
  final entregados = <Ritmo>[];
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: CampoRitmo(valor: valor, alCambiar: entregados.add),
      ),
    ),
  );
  return entregados;
}

void main() {
  testWidgets('vacío muestra "–:––.–" y la unidad "/km"', (tester) async {
    await montar(tester, null);
    expect(find.text('–:––.–'), findsOneWidget);
    expect(find.text('/km'), findsOneWidget);
  });

  testWidgets('muestra el valor que recibe', (tester) async {
    await montar(tester, Ritmo.parse('4:05.3'));
    expect(find.text('4:05.3'), findsOneWidget);
  });

  for (final icono in [Icons.remove, Icons.add]) {
    testWidgets('desde vacío, el primer toque entrega 5:00.0 ($icono)', (
      tester,
    ) async {
      final entregados = await montar(tester, null);
      await tester.tap(find.byIcon(icono));
      expect(entregados, [Ritmo.parse('5:00.0')]);
    });
  }

  testWidgets('con 4:05.3, − entrega 4:04.3', (tester) async {
    final entregados = await montar(tester, Ritmo.parse('4:05.3'));
    await tester.tap(find.byIcon(Icons.remove));
    expect(entregados, [Ritmo.parse('4:04.3')]);
  });

  testWidgets('con 4:05.3, + entrega 4:06.3', (tester) async {
    final entregados = await montar(tester, Ritmo.parse('4:05.3'));
    await tester.tap(find.byIcon(Icons.add));
    expect(entregados, [Ritmo.parse('4:06.3')]);
  });
}
