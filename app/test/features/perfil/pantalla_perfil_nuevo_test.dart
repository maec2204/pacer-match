import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:pacer_match/core/componentes/campo_ritmo.dart';
import 'package:pacer_match/core/dominio/ritmo.dart';
import 'package:pacer_match/core/navegacion/router.dart';
import 'package:pacer_match/features/perfil/perfil.dart';
import 'package:pacer_match/features/perfil/repositorio_perfil.dart';
import 'package:pacer_match/features/perfil/selector_foto.dart';
import 'package:pacer_match/main.dart';

/// Bytes de una imagen PNG de 1×1 px, para la foto elegida en las pruebas.
final fotoDePrueba = Uint8List.fromList(const [
  0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, 0x00, 0x00, 0x00, 0x0D, //
  0x49, 0x48, 0x44, 0x52, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01,
  0x08, 0x06, 0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4, 0x89, 0x00, 0x00, 0x00,
  0x0D, 0x49, 0x44, 0x41, 0x54, 0x78, 0x9C, 0x63, 0xF8, 0xCF, 0xC0, 0xF0,
  0x1F, 0x00, 0x05, 0x00, 0x01, 0xFF, 0x89, 0x99, 0x3D, 0x1D, 0x00, 0x00,
  0x00, 0x00, 0x49, 0x45, 0x4E, 0x44, 0xAE, 0x42, 0x60, 0x82,
]);

/// Selector de foto falso: devuelve [foto] y anota de dónde se pidió.
class SelectorFotoFalso implements SelectorFoto {
  SelectorFotoFalso(this.foto);

  final Uint8List? foto;
  final origenes = <OrigenFoto>[];

  @override
  Future<Uint8List?> elegir(OrigenFoto origen) async {
    origenes.add(origen);
    return foto;
  }
}

/// Abre la app en `/perfil/nuevo` con [repositorio] y [selector] en lugar de
/// los reales y devuelve el router para ver dónde quedó.
Future<GoRouter> abrirPerfilNuevo(
  WidgetTester tester,
  RepositorioPerfil repositorio, {
  SelectorFoto? selector,
}) async {
  final container = ProviderContainer.test(
    overrides: [
      repositorioPerfilProvider.overrideWithValue(repositorio),
      selectorFotoProvider.overrideWithValue(
        selector ?? SelectorFotoFalso(fotoDePrueba),
      ),
    ],
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

/// Toca el hueco de la foto y elige la opción [opcion].
Future<void> elegirFoto(WidgetTester tester, String opcion) async {
  await tester.tap(find.bySemanticsLabel('Elegir foto'));
  await tester.pumpAndSettle();
  await tester.tap(find.text(opcion));
  await tester.pumpAndSettle();
}

/// La foto que se ve en el hueco, o `null` si está vacío.
Uint8List? fotoEnElHueco(WidgetTester tester) {
  final hueco = tester.widget<CircleAvatar>(find.byType(CircleAvatar));
  return (hueco.backgroundImage as MemoryImage?)?.bytes;
}

void main() {
  testWidgets('elegir una foto de la galería la muestra en el hueco y se '
      'guarda con el perfil', (tester) async {
    final repositorio = RepositorioPerfilEnMemoria();
    final selector = SelectorFotoFalso(fotoDePrueba);
    await abrirPerfilNuevo(tester, repositorio, selector: selector);
    expect(fotoEnElHueco(tester), isNull);

    await _llenarFormulario(tester);

    expect(selector.origenes, [OrigenFoto.galeria]);
    expect(fotoEnElHueco(tester), fotoDePrueba);

    await tester.tap(_seguir);
    await tester.pumpAndSettle();

    expect(repositorio.guardado!.foto, fotoDePrueba);
  });

  testWidgets('completar foto, ritmo, ciudad y 18+ guarda el perfil y vuelve '
      'al inicio', (tester) async {
    final repositorio = RepositorioPerfilEnMemoria();
    final router = await abrirPerfilNuevo(tester, repositorio);
    await elegirFoto(tester, 'Elegir de la galería');

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

  testWidgets('escribir el ritmo, más foto, ciudad y 18+, activa "Seguir"', (
    tester,
  ) async {
    final repositorio = RepositorioPerfilEnMemoria();
    await abrirPerfilNuevo(tester, repositorio);
    await elegirFoto(tester, 'Elegir de la galería');

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

  testWidgets('el campo de ciudad empieza vacío', (tester) async {
    await abrirPerfilNuevo(tester, RepositorioPerfilEnMemoria());

    final ciudad = tester.widget<EditableText>(
      find.descendant(
        of: find.widgetWithText(TextField, 'Ciudad'),
        matching: find.byType(EditableText),
      ),
    );
    expect(ciudad.controller.text, isEmpty);
  });

  testWidgets('"Seguir" se apaga si falta la foto, el ritmo, la ciudad o la '
      'casilla', (tester) async {
    final selector = SelectorFotoFalso(fotoDePrueba);
    await abrirPerfilNuevo(
      tester,
      RepositorioPerfilEnMemoria(),
      selector: selector,
    );
    expect(seguirActivo(tester), isFalse);

    // Ciudad y casilla, sin ritmo ni foto.
    await tester.enterText(find.byType(TextField), 'Caracas');
    await tester.tap(find.text('Tengo 18 años o más'));
    await tester.pump();
    expect(seguirActivo(tester), isFalse);

    // Ritmo, ciudad y casilla, sin foto.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    expect(seguirActivo(tester), isFalse);

    await elegirFoto(tester, 'Tomar foto');
    expect(selector.origenes, [OrigenFoto.camara]);
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
    expect(fotoEnElHueco(tester), fotoDePrueba);
    expect(find.text('5:00.0'), findsOneWidget);
    expect(find.text('Caracas'), findsOneWidget);
    expect(
      tester.widget<CheckboxListTile>(find.byType(CheckboxListTile)).value,
      isTrue,
    );
    expect(seguirActivo(tester), isTrue);
  });
}

/// Foto de la galería, ritmo 5:00.0, ciudad "Caracas" y casilla 18+ marcada.
Future<void> _llenarFormulario(WidgetTester tester) async {
  await elegirFoto(tester, 'Elegir de la galería');
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
