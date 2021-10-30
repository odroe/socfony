import 'package:flutter/cupertino.dart';

abstract class AppTheme {
  static const Color primaryColor = Color(0xFF5E6CE7);

  static const CupertinoDynamicColor scaffoldBackgroundColor =
      CupertinoDynamicColor.withBrightness(
    color: CupertinoColors.systemGrey6,
    darkColor: CupertinoColors.black,
  );

  static const CupertinoDynamicColor barBackgroundColor =
      CupertinoDynamicColor.withBrightness(
    color: Color(0xF0F9F9F9),
    darkColor: Color(0xF01D1D1D),
  );

  static const CupertinoDynamicColor cardBackgroundColor =
      CupertinoDynamicColor.withBrightness(
    color: Color(0xFFFFFFFF),
    darkColor: Color(0xFF1D1D1D),
  );

  static CupertinoThemeData get theme => const CupertinoThemeData(
        primaryColor: primaryColor,
        barBackgroundColor: barBackgroundColor,
        scaffoldBackgroundColor: scaffoldBackgroundColor,
      );
}
