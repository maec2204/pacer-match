import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:pacer_match/core/dominio/ritmo.dart';
import 'package:pacer_match/core/navegacion/router.dart';
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
}
