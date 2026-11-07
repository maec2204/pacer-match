import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/componentes/campo_ritmo.dart';
import '../../core/dominio/ritmo.dart';
import '../../core/navegacion/router.dart';
import 'perfil.dart';
import 'repositorio_perfil.dart';

/// Formulario del perfil: ritmo de rodaje, hueco de la foto, ciudad y 18+.
class PantallaPerfilNuevo extends ConsumerStatefulWidget {
  const PantallaPerfilNuevo({super.key});

  @override
  ConsumerState<PantallaPerfilNuevo> createState() =>
      _PantallaPerfilNuevoState();
}

class _PantallaPerfilNuevoState extends ConsumerState<PantallaPerfilNuevo> {
  Ritmo? _ritmo;
  String _ciudad = '';
  bool _mayorDeEdad = false;

  bool get _completo =>
      _ritmo != null && _ciudad.trim().isNotEmpty && _mayorDeEdad;

  Future<void> _seguir() async {
    await ref
        .read(repositorioPerfilProvider)
        .guardar(
          Perfil(
            ritmoRodaje: _ritmo!,
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
            // Hueco de la foto: elegirla es otro ticket.
            const Center(
              child: CircleAvatar(radius: 40, child: Icon(Icons.person)),
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
