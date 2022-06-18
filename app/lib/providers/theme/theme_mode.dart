import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _modeCacheKey = r'SOCFONY#THEME_MODE';

class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  ThemeModeNotifier() : super(ThemeMode.system);

  /// Load theme mode from cache.
  Future<ThemeMode> load() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final String? modeName = sharedPreferences.getString(_modeCacheKey);

    return ThemeMode.values.firstWhere(
      (element) => element.name == modeName,
      orElse: () => ThemeMode.system,
    );
  }

  /// Save theme mode to cache.
  Future<void> save(ThemeMode mode) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    if (await sharedPreferences.setString(_modeCacheKey, mode.name) == false) {
      throw Exception('Failed to save theme mode to cache.');
    }

    state = mode;
  }
}

/// Theme mode provider.
final StateNotifierProvider<ThemeModeNotifier, ThemeMode> themeModeProvider =
    StateNotifierProvider<ThemeModeNotifier, ThemeMode>(
        (Ref ref) => ThemeModeNotifier());
