import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final TextTheme _kTextTheme = TextTheme(
  headline1: GoogleFonts.roboto(
      fontSize: 96, fontWeight: FontWeight.w300, letterSpacing: -1.5),
  headline2: GoogleFonts.roboto(
      fontSize: 60, fontWeight: FontWeight.w300, letterSpacing: -0.5),
  headline3: GoogleFonts.roboto(fontSize: 48, fontWeight: FontWeight.w400),
  headline4: GoogleFonts.roboto(
      fontSize: 34, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  headline5: GoogleFonts.roboto(fontSize: 24, fontWeight: FontWeight.w400),
  headline6: GoogleFonts.roboto(
      fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15),
  subtitle1: GoogleFonts.roboto(
      fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
  subtitle2: GoogleFonts.roboto(
      fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
  bodyText1: GoogleFonts.roboto(
      fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
  bodyText2: GoogleFonts.roboto(
      fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  button: GoogleFonts.roboto(
      fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
  caption: GoogleFonts.roboto(
      fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
  overline: GoogleFonts.roboto(
      fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
);

const Color _kPrimaryColor = Color(0xff5e6ce7);

class AppTheme {
  static const Color defaultPrimaryColor = _kPrimaryColor;

  const AppTheme([Color? color]) : primaryColor = color ?? _kPrimaryColor;

  final Color primaryColor;

  ColorScheme colorSchemeGenerator(Brightness brightness) {
    final bool isDark = brightness == Brightness.dark;
    final bool primaruIsDark =
        ThemeData.estimateBrightnessForColor(primaryColor) == Brightness.dark;
    final Color onPrimaryColor = primaruIsDark ? Colors.white : Colors.black;
    final Color onDarkColor = isDark ? Colors.white : Colors.black;

    return ColorScheme(
      brightness: brightness,
      primary: primaryColor,
      primaryVariant: primaryColor,
      secondary: primaryColor,
      secondaryVariant: primaryColor,
      surface: isDark ? Colors.black : Colors.white,
      background: isDark ? Colors.grey.shade900 : Colors.grey.shade200,
      error: Colors.red,
      onBackground: onDarkColor,
      onError: onDarkColor,
      onPrimary: onPrimaryColor,
      onSecondary: onPrimaryColor,
      onSurface: onDarkColor,
    );
  }

  ThemeData themeGenerator(Brightness brightness) {
    final ColorScheme colorScheme = colorSchemeGenerator(brightness);

    return ThemeData(
      textTheme: _kTextTheme,
      brightness: brightness,
      colorScheme: colorScheme,
      primaryColor: colorScheme.primary,
      scaffoldBackgroundColor: colorScheme.background,
      cardColor: colorScheme.surface,
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        centerTitle: true,
        iconTheme: IconThemeData(color: colorScheme.onSurface),
      ),
      tabBarTheme: TabBarTheme(
        labelColor: colorScheme.onSurface,
        unselectedLabelColor: colorScheme.onSurface,
        indicator: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: colorScheme.primary,
              width: 2,
            ),
          ),
          shape: BoxShape.rectangle,
        ),
        indicatorSize: TabBarIndicatorSize.label,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colorScheme.surface,
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: colorScheme.onSurface,
        type: BottomNavigationBarType.shifting,
      ),
      checkboxTheme: CheckboxThemeData(
        checkColor: MaterialStateProperty.all<Color>(colorScheme.onPrimary),
        fillColor: MaterialStateProperty.all<Color>(colorScheme.primary),
      ),
    );
  }

  ThemeData get light => themeGenerator(Brightness.light);
  ThemeData get dark => themeGenerator(Brightness.dark);
}
