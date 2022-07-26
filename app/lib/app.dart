import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_theme.dart';
import 'home/home_screen.dart';

class SocfonyApp extends ConsumerWidget {
  const SocfonyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch theme mode controller.
    final ThemeMode themeMode = ref.watch(themeModeProvider);

    return MaterialApp(
      theme: ref.watch(themeDataProvider(Brightness.light)),
      darkTheme: ref.watch(themeDataProvider(Brightness.dark)),
      themeMode: themeMode,
      home: const HomeScreen(),
    );
  }
}
