import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'home/home_screen.dart';

class SocfonyApp extends ConsumerWidget {
  final StateProviderFamily<ThemeData, Brightness> themeDataProvider;
  final StateProvider<ThemeMode> themeModeProvider;

  const SocfonyApp({
    super.key,
    required this.themeDataProvider,
    required this.themeModeProvider,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      theme: ref.watch(themeDataProvider.create(Brightness.light)),
      darkTheme: ref.watch(themeDataProvider.create(Brightness.dark)),
      themeMode: ref.watch(themeModeProvider),
      home: const HomeScreen(),
    );
  }
}
