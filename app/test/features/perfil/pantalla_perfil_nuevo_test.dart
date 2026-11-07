import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:pacer_match/core/componentes/campo_ritmo.dart';
import 'package:pacer_match/core/dominio/ritmo.dart';
import 'package:pacer_match/core/navegacion/router.dart';
import 'package:pacer_match/features/perfil/perfil.dart';
import 'package:pacer_match/features/perfil/repositorio_perfil.dart';
import 'package:pacer_match/main.dart';

/// Abre la app en `/perfil/nuevo` con [repositorio] en lugar del real y
/// devuelve el router para ver dónde quedó.
Future<GoRouter> abrirPerfilNuevo(
  WidgetTester tester,
  RepositorioPerfil repositorio,
) async {
  final container = ProviderContainer.test(
    overrides: [repositorioPerfilProvider.overrideWithValue(repositorio)],
  );
  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: container,
      child: const PacerMatchApp(),
    ),
  );
  final router = container.read(routerProvider)..go(Rutas.perfilNuevo);
  await tester.pumpAndSettle();
  return router;
}

final _seguir = find.widgetWithText(FilledButton, 'Seguir');

bool seguirActivo(WidgetTester tester) =>
    tester.widget<FilledButton>(_seguir).onPressed != null;

void main() {
  testWidgets('completar ritmo, ciudad y 18+ guarda el perfil y vuelve al '
      'inicio', (tester) async {
    final repositorio = RepositorioPerfilEnMemoria();
    final router = await abrirPerfilNuevo(tester, repositorio);

    expect(find.text('¿A qué ritmo corres?'), findsOneWidget);
    await tester.tap(find.byIcon(Icons.remove));
    await tester.pump();
    expect(find.text('5:00.0'), findsOneWidget);
    await tester.tap(find.byIcon(Icons.remove));
    await tester.pump();
    expect(find.text('4:59.0'), findsOneWidget);
    await tester.enterText(find.byType(TextField), 'Caracas');
    await tester.tap(find.text('Tengo 18 años o más'));
    await tester.pump();

    expect(seguirActivo(tester), isTrue);
    await tester.tap(_seguir);
    await tester.pumpAndSettle();

    final perfil = repositorio.guardado!;
    expect(perfil.ritmoRodaje, Ritmo.parse('4:59.0'));
    expect(perfil.ciudad, 'Caracas');
    expect(perfil.mayorDeEdad, isTrue);
    expect(router.state.uri.path, Rutas.inicio);
  });

  testWidgets('escribir el ritmo, más ciudad y 18+, activa "Seguir"', (
    tester,
  ) async {
    final repositorio = RepositorioPerfilEnMemoria();
    await abrirPerfilNuevo(tester, repositorio);

    await tester.tap(find.text('–:––.–'));
    await tester.pump();
    await tester.enterText(
      find.descendant(
        of: find.byType(CampoRitmo),
        matching: find.byType(TextField),
      ),
      '4053',
    );
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump();
    expect(find.text('4:05.3'), findsOneWidget);
    expect(seguirActivo(tester), isFalse);

    await tester.enterText(find.byType(TextField), 'Caracas');
    await tester.tap(find.text('Tengo 18 años o más'));
    await tester.pump();
    expect(seguirActivo(tester), isTrue);

    await tester.tap(_seguir);
    await tester.pumpAndSettle();
    expect(repositorio.guardado!.ritmoRodaje, Ritmo.parse('4:05.3'));
  });

  testWidgets('"Seguir" se apaga si falta el ritmo, la ciudad o la casilla', (
    tester,
  ) async {
    await abrirPerfilNuevo(tester, RepositorioPerfilEnMemoria());
    expect(seguirActivo(tester), isFalse);

    // Ciudad y casilla, sin ritmo.
    await tester.enterText(find.byType(TextField), 'Caracas');
    await tester.tap(find.text('Tengo 18 años o más'));
    await tester.pump();
    expect(seguirActivo(tester), isFalse);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    expect(seguirActivo(tester), isTrue);

    // Se borra la ciudad.
    await tester.enterText(find.byType(TextField), '');
    await tester.pump();
    expect(seguirActivo(tester), isFalse);

    await tester.enterText(find.byType(TextField), 'Caracas');
    await tester.pump();
    expect(seguirActivo(tester), isTrue);

    // Se desmarca la casilla.
    await tester.tap(find.text('Tengo 18 años o más'));
    await tester.pump();
    expect(seguirActivo(tester), isFalse);
  });

  testWidgets('mientras guarda, "Seguir" se apaga y un segundo toque no vuelve '
      'a guardar', (tester) async {
    final repositorio = _RepositorioQueTarda();
    await abrirPerfilNuevo(tester, repositorio);
    await _llenarFormulario(tester);

    await tester.tap(_seguir);
    await tester.pump();
    expect(seguirActivo(tester), isFalse);
    await tester.tap(_seguir);
    await tester.pump();
    expect(repositorio.intentos, 1);

    repositorio.terminar();
    await tester.pumpAndSettle();
  });

  testWidgets('si el guardado falla, avisa, sigue en el formulario con los '
      'datos y "Seguir" vuelve a estar activo', (tester) async {
    final router = await abrirPerfilNuevo(tester, _RepositorioQueFalla());
    await _llenarFormulario(tester);

    await tester.tap(_seguir);
    await tester.pumpAndSettle();

    expect(
      find.text('No pudimos guardar tu perfil. Intenta de nuevo.'),
      findsOneWidget,
    );
    expect(router.state.uri.path, Rutas.perfilNuevo);
    expect(find.text('5:00.0'), findsOneWidget);
    expect(find.text('Caracas'), findsOneWidget);
    expect(
      tester.widget<CheckboxListTile>(find.byType(CheckboxListTile)).value,
      isTrue,
    );
    expect(seguirActivo(tester), isTrue);
  });
}

/// Ritmo 5:00.0, ciudad "Caracas" y casilla 18+ marcada.
Future<void> _llenarFormulario(WidgetTester tester) async {
  await tester.tap(find.byIcon(Icons.remove));
  await tester.enterText(find.byType(TextField), 'Caracas');
  await tester.tap(find.text('Tengo 18 años o más'));
  await tester.pump();
}

/// No termina de guardar hasta que se llama a [terminar].
class _RepositorioQueTarda implements RepositorioPerfil {
  final _guardado = Completer<void>();
  int intentos = 0;

  void terminar() => _guardado.complete();

  @override
  Future<void> guardar(Perfil perfil) {
    intentos++;
    return _guardado.future;
  }
}

/// Siempre falla al guardar.
class _RepositorioQueFalla implements RepositorioPerfil {
  @override
  Future<void> guardar(Perfil perfil) async => throw Exception('sin conexión');
}
