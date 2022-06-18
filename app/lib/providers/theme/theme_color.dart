import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _colorCacheKey = r'SOCFONY#THEME';

class ThemeColorNotifier extends StateNotifier<Color> {
  ThemeColorNotifier() : super(const Color(0xff5e6ce7));

  /// Load cached color.
  Future<Color> load() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final int? colorValue = sharedPreferences.getInt(_colorCacheKey);

    return Color(colorValue ?? state.value);
  }

  /// Save color to cache.
  Future<void> save(Color color) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    if (await sharedPreferences.setInt(_colorCacheKey, color.value) == false) {
      throw Exception('Failed to save theme color to cache.');
    }

    state = color;
  }
}

/// Theme color provider.
final StateNotifierProvider<ThemeColorNotifier, Color> themeColorProvider =
    StateNotifierProvider<ThemeColorNotifier, Color>(
        (Ref ref) => ThemeColorNotifier());
