import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Create the app theme data provider.
Future<StateProviderFamily<ThemeData, Brightness>>
    createThemeDataProvider() async {
  /// Create shared preferences instance.
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  /// Read theme color from cache.
  final int? cachedColorValue = sharedPreferences.getInt('socfony_theme_color');

  /// Create the theme data provider.
  return StateProvider.family<ThemeData, Brightness>(
    (Ref ref, Brightness brightness) => ThemeData.from(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Color(cachedColorValue ?? 0xff5e6ce7),
        brightness: brightness,
      ),
      useMaterial3: true,
    ),
  );
}

/// Create theme mode provider.
Future<StateProvider<ThemeMode>> createThemeModeProvider() async {
  /// Create shared preferences instance.
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  /// Read theme mode from cache.
  final String? cachedThemeMode =
      sharedPreferences.getString('socfony_theme_mode');

  /// Create the theme mode provider.
  return StateProvider(
    (Ref ref) => ThemeMode.values.firstWhere(
      (ThemeMode mode) => mode.name == cachedThemeMode,
      orElse: () => ThemeMode.system,
    ),
  );
}

/// Save theme color to cache.
Future<bool> saveThemeColor(Color color) async {
  /// Create shared preferences instance.
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  /// Save theme color to cache.
  return await sharedPreferences.setInt('socfony_theme_color', color.value);
}

/// Save theme mode to cache.
Future<bool> saveThemeMode(ThemeMode mode) async {
  /// Create shared preferences instance.
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  /// Save theme mode to cache.
  return await sharedPreferences.setString('socfony_theme_mode', mode.name);
}
