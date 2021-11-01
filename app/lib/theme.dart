import 'package:flutter/cupertino.dart';

extension AppTextThemeData on CupertinoTextThemeData {
  TextStyle get largeTitle => const _TextStyleFactory(
        fontSize: 34.0,
        fontWeight: FontWeight.bold,
      );

  TextStyle get title1 => const _TextStyleFactory(
        fontSize: 28.0,
        fontWeight: FontWeight.bold,
      );

  TextStyle get title2 => const _TextStyleFactory(
        fontSize: 22.0,
        fontWeight: FontWeight.bold,
      );

  TextStyle get title3 => const _TextStyleFactory(
        fontSize: 20.0,
        fontWeight: FontWeight.w600,
      );

  TextStyle get headline => const _TextStyleFactory(
        fontSize: 17.0,
        fontWeight: FontWeight.w500,
      );

  TextStyle get body => const _TextStyleFactory(
        fontSize: 17.0,
        fontWeight: FontWeight.w600,
      );

  TextStyle get callout => const _TextStyleFactory(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
      );

  TextStyle get subheadline => const _TextStyleFactory(
        fontSize: 15.0,
        fontWeight: FontWeight.w600,
      );

  TextStyle get footnote => const _TextStyleFactory(
        fontSize: 13.0,
        fontWeight: FontWeight.w600,
      );

  TextStyle get caption1 => const _TextStyleFactory(
        fontSize: 12.0,
        fontWeight: FontWeight.w500,
      );

  TextStyle get caption2 => const _TextStyleFactory(
        fontSize: 11.0,
        fontWeight: FontWeight.w600,
      );
}

class _TextStyleFactory extends TextStyle {
  const _TextStyleFactory({
    required double fontSize,
    required FontWeight fontWeight,
  }) : super(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: const CupertinoDynamicColor.withBrightness(
            color: Color(0xFF000000),
            darkColor: Color(0xFFFFFFFF),
          ),
        );
}

extension AppTextStyle on TextStyle {
  TextStyle resolveFrom(BuildContext context) => copyWith(
        color: CupertinoDynamicColor.maybeResolve(color, context),
        backgroundColor:
            CupertinoDynamicColor.maybeResolve(backgroundColor, context),
      );
}

extension AppThemeData on CupertinoThemeData {
  CupertinoDynamicColor get cardBackgroundColor =>
      const CupertinoDynamicColor.withBrightness(
        color: Color(0xFFFFFFFF),
        darkColor: Color(0xFF1D1D1D),
      );
}

class AppTheme extends CupertinoTheme {
  const AppTheme({
    Key? key,
    required CupertinoThemeData data,
    required Widget child,
  }) : super(
          key: key,
          child: child,
          data: data,
        );

  static const CupertinoThemeData defaultTheme = CupertinoThemeData(
    primaryColor: Color(0xFF5E6CE7),
    scaffoldBackgroundColor: CupertinoDynamicColor.withBrightness(
      color: CupertinoColors.systemGrey6,
      darkColor: CupertinoColors.black,
    ),
    barBackgroundColor: CupertinoDynamicColor.withBrightness(
      color: Color(0xFFFFFFFF),
      darkColor: Color(0xFF1D1D1D),
    ),
  );

  static CupertinoThemeData of(BuildContext context) =>
      CupertinoTheme.of(context);
}
