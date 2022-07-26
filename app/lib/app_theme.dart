import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'riverpod/value_state_notifier.dart';

/// Default theme color.
const Color kThemeColor = Color(0xff5e6ce7);

/// Theme color notifier.
final ValueStateNotifier<Color> themeColorNotifier =
    ValueStateNotifier<Color>(kThemeColor);

/// Theme color provider.
final StateNotifierProvider<ValueStateNotifier<Color>, Color>
    themeColorProvider =
    StateNotifierProvider<ValueStateNotifier<Color>, Color>(
        (Ref ref) => themeColorNotifier);

/// Theme mode notifier.
final ValueStateNotifier<ThemeMode> themeModeNotifier =
    ValueStateNotifier<ThemeMode>(ThemeMode.system);

/// Theme mode provider.
final StateNotifierProvider<ValueStateNotifier<ThemeMode>, ThemeMode>
    themeModeProvider =
    StateNotifierProvider<ValueStateNotifier<ThemeMode>, ThemeMode>(
        (Ref ref) => themeModeNotifier);

/// Create theme data.
ThemeData createThemeData(Brightness brightness, Color color) => ThemeData.from(
      colorScheme: ColorScheme.fromSeed(
        seedColor: color,
        brightness: brightness,
      ),
      useMaterial3: true,
    );

/// Theme data provider.
final ProviderFamily<ThemeData, Brightness> themeDataProvider =
    Provider.family<ThemeData, Brightness>((Ref ref, Brightness brightness) {
  return createThemeData(brightness, ref.watch(themeColorProvider));
});

/// Read theme color from shared preferences.
Future<Color> readThemeColor() async {
  /// Create shared preferences instance.
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  /// Read theme color from cache.
  final int? cachedColorValue = sharedPreferences.getInt('socfony_theme_color');

  /// If theme color is not null, return it.
  if (cachedColorValue != null) {
    return Color(cachedColorValue);
  }

  /// Return default theme color.
  return kThemeColor;
}

/// Read theme mode from shared preferences.
Future<ThemeMode> readThemeMode() async {
  /// Create shared preferences instance.
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  /// Read theme mode from cache.
  final String? cachedThemeMode =
      sharedPreferences.getString('socfony_theme_mode');

  return ThemeMode.values.firstWhere(
    (ThemeMode mode) => mode.name == cachedThemeMode,
    orElse: () => ThemeMode.system,
  );
}

/// Save theme color to cache.
Future<bool> saveThemeColor(Reader reader, Color color) async {
  /// Update theme color.
  reader(themeColorProvider.notifier).update(color);

  /// Create shared preferences instance.
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  /// Save theme color to cache.
  return await sharedPreferences.setInt('socfony_theme_color', color.value);
}

/// Save theme mode to cache.
Future<bool> saveThemeMode(Reader reader, ThemeMode mode) async {
  // Update theme mode.
  reader(themeModeProvider.notifier).update(mode);

  /// Create shared preferences instance.
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  /// Save theme mode to cache.
  return await sharedPreferences.setString('socfony_theme_mode', mode.name);
}
