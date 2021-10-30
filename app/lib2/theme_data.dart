import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const MaterialColor themeColor = MaterialColor(0xFF5E6CE7, {
  50: Color(0xFFE9EBFC),
  100: Color(0xFFC8CBF7),
  200: Color(0xFFA3AAF1),
  300: Color(0xFF7C88EC),
  400: Color(0xFF5E6CE7),
  500: Color(0xFF3F50E1),
  600: Color(0xFF3A47D5),
  700: Color(0xFF303CC9),
  800: Color(0xFF2630BD),
  900: Color(0xFF1C1AA6),
});

ThemeData themeData = ThemeData.from(
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: themeColor,
    backgroundColor: Colors.grey[50],
    brightness: Brightness.light,
  ),
).copyWith(
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    color: Colors.white,
    elevation: 0.4,
    foregroundColor: Colors.black,
  ),
);

ThemeData darkThemeData = ThemeData.from(
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: themeColor,
    backgroundColor: Colors.grey[900],
    brightness: Brightness.dark,
  ),
).copyWith(
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    color: Colors.black,
    elevation: 0,
    foregroundColor: Colors.white,
  ),
);
