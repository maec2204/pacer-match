import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

/// De dónde sale la foto del perfil.
enum OrigenFoto { galeria, camara }

/// Elige la foto del perfil y la deja recortada.
abstract interface class SelectorFoto {
  /// Bytes de la foto recortada, o `null` si se canceló.
  Future<Uint8List?> elegir(OrigenFoto origen);
}

/// Usa la galería o la cámara del teléfono (image_picker) y el recorte
/// nativo (image_cropper). En Android no se declaran permisos (ver
/// AndroidManifest.xml); los de iOS están en Info.plist.
class SelectorFotoDispositivo implements SelectorFoto {
  @override
  Future<Uint8List?> elegir(OrigenFoto origen) async {
    final imagen = await ImagePicker().pickImage(
      source: switch (origen) {
        OrigenFoto.galeria => ImageSource.gallery,
        OrigenFoto.camara => ImageSource.camera,
      },
    );
    if (imagen == null) return null;
    final recorte = await ImageCropper().cropImage(
      sourcePath: imagen.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Recortar foto',
          cropStyle: CropStyle.circle,
          lockAspectRatio: true,
        ),
        IOSUiSettings(
          title: 'Recortar foto',
          cropStyle: CropStyle.circle,
          aspectRatioLockEnabled: true,
          resetAspectRatioEnabled: false,
        ),
      ],
    );
    return recorte?.readAsBytes();
  }
}

/// Selector de foto activo. Las pruebas lo sustituyen con override.
final selectorFotoProvider = Provider<SelectorFoto>(
  (ref) => SelectorFotoDispositivo(),
);
