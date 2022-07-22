import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Default theme color.
const Color kThemeColor = Color(0xff5e6ce7);

/// Theme color controller.
class ThemeColorController extends ValueNotifier<Color> {
  ThemeColorController._() : super(kThemeColor);

  factory ThemeColorController() => _instance;

  static final ThemeColorController _instance = ThemeColorController._();

  /// Change theme color.
  void update(Color color) {
    value = color;
  }
}

/// Theme color provider.
final ChangeNotifierProvider<ThemeColorController>
    themeColorControllerProvider = ChangeNotifierProvider<ThemeColorController>(
        (Ref ref) => ThemeColorController());

/// Theme mode controller.
class ThemeModeController extends ValueNotifier<ThemeMode> {
  ThemeModeController._() : super(ThemeMode.system);

  factory ThemeModeController() => _instance;

  static final ThemeModeController _instance = ThemeModeController._();

  /// Change theme mode.
  void update(ThemeMode mode) {
    value = mode;
  }
}

/// Theme mode provider.
final ChangeNotifierProvider<ThemeModeController> themeModeControllerProvider =
    ChangeNotifierProvider((Ref ref) => ThemeModeController());

/// Theme data provider.
final ProviderFamily<ThemeData, Brightness> themeDataProvider =
    Provider.family<ThemeData, Brightness>((Ref ref, Brightness brightness) {
  return ThemeData.from(
    colorScheme: ColorScheme.fromSeed(
      seedColor: ref.watch(themeColorControllerProvider).value,
      brightness: brightness,
    ),
    useMaterial3: true,
  );
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
  reader(themeColorControllerProvider).update(color);

  /// Create shared preferences instance.
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  /// Save theme color to cache.
  return await sharedPreferences.setInt('socfony_theme_color', color.value);
}

/// Save theme mode to cache.
Future<bool> saveThemeMode(Reader reader, ThemeMode mode) async {
  // Update theme mode.
  reader(themeModeControllerProvider).update(mode);

  /// Create shared preferences instance.
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  /// Save theme mode to cache.
  return await sharedPreferences.setString('socfony_theme_mode', mode.name);
}
