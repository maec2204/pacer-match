import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pacer_match/core/componentes/campo_ritmo.dart';
import 'package:pacer_match/core/dominio/ritmo.dart';

/// Monta el campo con [valor] y devuelve la lista de lo que entrega `alCambiar`.
/// Como en un formulario, lo entregado pasa a ser el valor que se muestra.
Future<List<Ritmo>> montar(WidgetTester tester, Ritmo? valor) async {
  final entregados = <Ritmo>[];
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: StatefulBuilder(
          builder: (context, setState) => CampoRitmo(
            valor: valor,
            alCambiar: (ritmo) {
              entregados.add(ritmo);
              setState(() => valor = ritmo);
            },
          ),
        ),
      ),
    ),
  );
  return entregados;
}

/// Toca la cifra que muestra [cifra] y escribe [cifras] con el teclado, sin
/// confirmar.
Future<void> escribir(WidgetTester tester, String cifra, String cifras) async {
  await tester.tap(find.text(cifra));
  await tester.pump();
  await tester.enterText(find.byType(TextField), cifras);
  await tester.pump();
}

/// Confirma lo escrito con "Listo" en el teclado.
Future<void> confirmar(WidgetTester tester) async {
  await tester.testTextInput.receiveAction(TextInputAction.done);
  await tester.pump();
}

/// Si el botón − / + con [icono] está activo.
bool activo(WidgetTester tester, IconData icono) =>
    tester
        .widget<IconButton>(
          find.ancestor(
            of: find.byIcon(icono),
            matching: find.byType(IconButton),
          ),
        )
        .onPressed !=
    null;

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

  testWidgets('con 2:30.5, − se queda en 2:30.0', (tester) async {
    final entregados = await montar(tester, Ritmo.parse('2:30.5'));
    await tester.tap(find.byIcon(Icons.remove));
    expect(entregados, [Ritmo.parse('2:30.0')]);
  });

  testWidgets('con 9:59.5, + se queda en 10:00.0', (tester) async {
    final entregados = await montar(tester, Ritmo.parse('9:59.5'));
    await tester.tap(find.byIcon(Icons.add));
    expect(entregados, [Ritmo.parse('10:00.0')]);
  });

  testWidgets('en 2:30.0, − está apagado y + activo', (tester) async {
    await montar(tester, Ritmo.parse('2:30.0'));
    expect(activo(tester, Icons.remove), isFalse);
    expect(activo(tester, Icons.add), isTrue);
  });

  testWidgets('en 10:00.0, + está apagado y − activo', (tester) async {
    await montar(tester, Ritmo.parse('10:00.0'));
    expect(activo(tester, Icons.add), isFalse);
    expect(activo(tester, Icons.remove), isTrue);
  });

  testWidgets('con 2:00.0 (más rápido que el mínimo), − está apagado y + '
      'entrega 2:30.0', (tester) async {
    final entregados = await montar(tester, Ritmo.parse('2:00.0'));
    expect(activo(tester, Icons.remove), isFalse);
    await tester.tap(find.byIcon(Icons.add));
    expect(entregados, [Ritmo.parse('2:30.0')]);
  });

  testWidgets('con 11:00.0 (más lento que el máximo), + está apagado y − '
      'entrega 10:00.0', (tester) async {
    final entregados = await montar(tester, Ritmo.parse('11:00.0'));
    expect(activo(tester, Icons.add), isFalse);
    await tester.tap(find.byIcon(Icons.remove));
    expect(entregados, [Ritmo.parse('10:00.0')]);
  });

  testWidgets('en 2:30.5, − y + están activos', (tester) async {
    await montar(tester, Ritmo.parse('2:30.5'));
    expect(activo(tester, Icons.remove), isTrue);
    expect(activo(tester, Icons.add), isTrue);
  });

  testWidgets('escribir "4053" y confirmar entrega 4:05.3 y muestra "4:05.3"', (
    tester,
  ) async {
    final entregados = await montar(tester, null);
    await escribir(tester, '–:––.–', '4053');
    await confirmar(tester);
    expect(entregados, [Ritmo.parse('4:05.3')]);
    expect(find.text('4:05.3'), findsOneWidget);
  });

  testWidgets('"4653" (65 s) avisa el formato, vuelve al valor anterior y no '
      'entrega nada', (tester) async {
    final entregados = await montar(tester, Ritmo.parse('5:00.0'));
    await escribir(tester, '5:00.0', '4653');
    await confirmar(tester);
    expect(find.text('Escribe el ritmo como 4:05.3'), findsOneWidget);
    expect(find.text('5:00.0'), findsOneWidget);
    expect(entregados, isEmpty);
  });

  for (final cifras in ['2000', '12300']) {
    testWidgets('"$cifras" avisa el rango, vuelve al valor anterior y no '
        'entrega nada', (tester) async {
      final entregados = await montar(tester, Ritmo.parse('5:00.0'));
      await escribir(tester, '5:00.0', cifras);
      await confirmar(tester);
      expect(find.text('Entre 2:30 y 10:00 /km'), findsOneWidget);
      expect(find.text('5:00.0'), findsOneWidget);
      expect(entregados, isEmpty);
    });
  }

  testWidgets('tras un valor rechazado, tocar + borra el mensaje', (
    tester,
  ) async {
    await montar(tester, Ritmo.parse('5:00.0'));
    await escribir(tester, '5:00.0', '4653');
    await confirmar(tester);
    expect(find.text('Escribe el ritmo como 4:05.3'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    expect(find.text('5:01.0'), findsOneWidget);
    expect(find.text('Escribe el ritmo como 4:05.3'), findsNothing);
  });

  testWidgets('mientras se escribe no aparece ningún mensaje', (tester) async {
    await montar(tester, Ritmo.parse('5:00.0'));
    await escribir(tester, '5:00.0', '4653');
    expect(find.text('Escribe el ritmo como 4:05.3'), findsNothing);
    await tester.enterText(find.byType(TextField), '2000');
    await tester.pump();
    expect(find.text('Entre 2:30 y 10:00 /km'), findsNothing);

    // Tampoco queda el aviso de un intento anterior.
    await confirmar(tester);
    expect(find.text('Entre 2:30 y 10:00 /km'), findsOneWidget);
    await escribir(tester, '5:00.0', '4');
    expect(find.text('Entre 2:30 y 10:00 /km'), findsNothing);
  });

  testWidgets('mientras se escribe, las cifras se acomodan de derecha a '
      'izquierda', (tester) async {
    await montar(tester, null);
    await escribir(tester, '–:––.–', '4053');
    expect(find.text('4:05.3'), findsOneWidget);
    await tester.enterText(find.byType(TextField), '12300');
    await tester.pump();
    expect(find.text('12:30.0'), findsOneWidget);
  });

  testWidgets('confirmar sin escribir nada avisa el formato, vuelve al valor '
      'anterior y no entrega nada', (tester) async {
    final entregados = await montar(tester, Ritmo.parse('5:00.0'));
    await escribir(tester, '5:00.0', '');
    await confirmar(tester);
    expect(find.text('Escribe el ritmo como 4:05.3'), findsOneWidget);
    expect(find.text('5:00.0'), findsOneWidget);
    expect(entregados, isEmpty);
  });

  testWidgets('salir del campo también revisa lo escrito', (tester) async {
    final entregados = await montar(tester, Ritmo.parse('5:00.0'));
    await escribir(tester, '5:00.0', '4053');
    FocusManager.instance.primaryFocus!.unfocus();
    await tester.pump();
    expect(entregados, [Ritmo.parse('4:05.3')]);
    expect(find.text('4:05.3'), findsOneWidget);
  });
  testWidgets('el lector de pantalla anuncia − como "Más rápido" y + como '
      '"Más lento"', (tester) async {
    final semantica = tester.ensureSemantics();
    await montar(tester, Ritmo.parse('4:05.3'));
    expect(
      find.ancestor(
        of: find.byIcon(Icons.remove),
        matching: find.bySemanticsLabel('Más rápido'),
      ),
      findsOneWidget,
    );
    expect(
      find.ancestor(
        of: find.byIcon(Icons.add),
        matching: find.bySemanticsLabel('Más lento'),
      ),
      findsOneWidget,
    );
    semantica.dispose();
  });

  testWidgets(
    'con 4:05.3, el lector de pantalla anuncia la cifra en palabras',
    (tester) async {
      final semantica = tester.ensureSemantics();
      await montar(tester, Ritmo.parse('4:05.3'));
      expect(
        find.bySemanticsLabel('Ritmo, 4 minutos 5,3 segundos por kilómetro'),
        findsOneWidget,
      );
      expect(find.bySemanticsLabel('4:05.3'), findsNothing);
      expect(find.bySemanticsLabel('/km'), findsNothing);
      semantica.dispose();
    },
  );

  testWidgets('vacío, el lector de pantalla anuncia que todavía no hay ritmo '
      'y tocar la cifra abre el teclado', (tester) async {
    final semantica = tester.ensureSemantics();
    await montar(tester, null);
    expect(
      find.bySemanticsLabel('Ritmo, todavía no hay ritmo'),
      findsOneWidget,
    );
    tester.semantics.tap(find.semantics.byLabel('Ritmo, todavía no hay ritmo'));
    await tester.pump();
    expect(find.byType(TextField), findsOneWidget);
    semantica.dispose();
  });
}
