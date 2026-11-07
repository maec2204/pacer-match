import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('el manifiesto de Android declara la cámara y las fotos para la foto '
      'del perfil', () {
    final manifiesto = File('android/app/src/main/AndroidManifest.xml')
        .readAsStringSync();
    for (final permiso in ['CAMERA', 'READ_MEDIA_IMAGES']) {
      expect(
        manifiesto,
        contains(
          '<uses-permission android:name="android.permission.$permiso"/>',
        ),
      );
    }
  });
}
