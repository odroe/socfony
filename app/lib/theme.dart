import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final TextTheme textTheme = TextTheme(
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

final ThemeData lightThemeData = ThemeData.from(
  colorScheme: const ColorScheme.light(
    primary: Color(0xff5e6ce7),
    primaryVariant: Color(0xff2730bd),
  ),
  textTheme: textTheme,
);

final ThemeData darkThemeData = ThemeData.from(
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFF5e6ce7),
    primaryVariant: Color(0xff2730bd),
  ),
  textTheme: textTheme,
);

ThemeData theme(ThemeData data) {
  final ColorScheme colorScheme = data.colorScheme;

  return data.copyWith(
    appBarTheme: AppBarTheme(
      color: colorScheme.background,
      elevation: 0,
      iconTheme: IconThemeData(
        color: colorScheme.onBackground,
      ),
      foregroundColor: colorScheme.onBackground,
      centerTitle: true,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: colorScheme.background,
      elevation: 0,
      selectedItemColor: colorScheme.primary,
      unselectedItemColor: colorScheme.onBackground,
    ),
    bottomAppBarTheme: BottomAppBarTheme(
      color: colorScheme.background,
      elevation: 0,
    ),
    tabBarTheme: TabBarTheme(
      labelColor: colorScheme.onBackground,
      unselectedLabelColor: colorScheme.onBackground,
      indicator: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: colorScheme.primary,
            width: 2,
          ),
        ),
      ),
      indicatorSize: TabBarIndicatorSize.tab,
    ),
  );
}
