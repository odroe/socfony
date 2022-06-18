import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers/root_key.dart';
import 'providers/theme/theme_color.dart';
import 'providers/theme/theme_data.dart';
import 'providers/theme/theme_mode.dart';
import 'screens/home_screen.dart';

/// Socfony App
class SocfonyApp extends StatelessWidget {
  const SocfonyApp({super.key});

  /// Build the app
  @override
  Widget build(BuildContext context) {
    return const ProviderScope(child: _InternalSocfonyApp());
  }
}

class _InternalSocfonyApp extends ConsumerWidget {
  const _InternalSocfonyApp();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<void>(
      builder: builder,
      future: _createInitialFuture(ref),
    );
  }

  Widget builder(BuildContext context, AsyncSnapshot<void> snapshot) {
    return const _InitializedSocfonyApp();
  }

  Future<void> _createInitialFuture(WidgetRef ref) async {
    await ref.read(themeColorProvider.notifier).load();
    await ref.read(themeModeProvider.notifier).load();
  }
}

class _InitializedSocfonyApp extends ConsumerWidget {
  const _InitializedSocfonyApp();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      key: ref.watch(rootKeyProvider),
      theme: ref.watch(themeDataProvider.create(Brightness.light)),
      darkTheme: ref.watch(themeDataProvider.create(Brightness.dark)),
      themeMode: ref.watch(themeModeProvider),
      home: const HomeScreen(),
    );
  }
}
