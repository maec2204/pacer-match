import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/navegacion/router.dart';

void main() => runApp(const ProviderScope(child: PacerMatchApp()));

class PacerMatchApp extends ConsumerWidget {
  const PacerMatchApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Pacer Match',
      theme: ThemeData(brightness: Brightness.dark, useMaterial3: true),
      routerConfig: ref.watch(routerProvider),
    );
  }
}
