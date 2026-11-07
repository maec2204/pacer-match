import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/componentes/campo_ritmo.dart';
import '../../core/dominio/ritmo.dart';
import '../../core/navegacion/router.dart';
import 'perfil.dart';
import 'repositorio_perfil.dart';
import 'selector_foto.dart';

/// Formulario del perfil: ritmo de rodaje, hueco de la foto, ciudad y 18+.
class PantallaPerfilNuevo extends ConsumerStatefulWidget {
  const PantallaPerfilNuevo({super.key});

  @override
  ConsumerState<PantallaPerfilNuevo> createState() =>
      _PantallaPerfilNuevoState();
}

class _PantallaPerfilNuevoState extends ConsumerState<PantallaPerfilNuevo> {
  Ritmo? _ritmo;
  Uint8List? _foto;
  String _ciudad = '';
  bool _mayorDeEdad = false;

  bool get _completo =>
      _ritmo != null &&
      _foto != null &&
      _ciudad.trim().isNotEmpty &&
      _mayorDeEdad;

  Future<void> _elegirFoto() async {
    final origen = await showModalBottomSheet<OrigenFoto>(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: const Text('Elegir de la galería'),
              onTap: () => Navigator.pop(context, OrigenFoto.galeria),
            ),
            ListTile(
              leading: const Icon(Icons.photo_camera_outlined),
              title: const Text('Tomar foto'),
              onTap: () => Navigator.pop(context, OrigenFoto.camara),
            ),
          ],
        ),
      ),
    );
    if (origen == null) return;
    final foto = await ref.read(selectorFotoProvider).elegir(origen);
    if (foto != null && mounted) setState(() => _foto = foto);
  }

  Future<void> _seguir() async {
    await ref
        .read(repositorioPerfilProvider)
        .guardar(
          Perfil(
            ritmoRodaje: _ritmo!,
            foto: _foto!,
            ciudad: _ciudad.trim(),
            mayorDeEdad: _mayorDeEdad,
          ),
        );
    if (mounted) context.go(Rutas.inicio);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Text(
              '¿A qué ritmo corres?',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            CampoRitmo(
              valor: _ritmo,
              alCambiar: (ritmo) => setState(() => _ritmo = ritmo),
            ),
            const SizedBox(height: 24),
            Center(
              child: Semantics(
                button: true,
                label: 'Elegir foto',
                child: InkWell(
                  onTap: _elegirFoto,
                  customBorder: const CircleBorder(),
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: _foto == null ? null : MemoryImage(_foto!),
                    child: _foto == null
                        ? const Icon(Icons.add_a_photo_outlined)
                        : null,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              decoration: const InputDecoration(labelText: 'Ciudad'),
              onChanged: (texto) => setState(() => _ciudad = texto),
            ),
            CheckboxListTile(
              value: _mayorDeEdad,
              title: const Text('Tengo 18 años o más'),
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
              onChanged: (marcada) =>
                  setState(() => _mayorDeEdad = marcada ?? false),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _completo ? _seguir : null,
              child: const Text('Seguir'),
            ),
          ],
        ),
      ),
    );
  }
}
