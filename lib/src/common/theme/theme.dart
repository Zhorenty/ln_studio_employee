import 'package:flutter/material.dart';

/// Light theme of this application.
final $lightThemeData = ThemeData(
  colorScheme: lightColorScheme,
  brightness: Brightness.light,
  useMaterial3: true,
);

const lightColorScheme = ColorScheme.light(
  primary: Color(0xFFFFFFFF),
  secondary: Color(0xFFD9D9D9),
  onBackground: Color(0xFF000000),
);

/// Dark theme of this application.
final $darkThemeData = ThemeData(
  useMaterial3: true,
  colorScheme: darkColorScheme,
  bottomNavigationBarTheme: bottomNavigationBarThemeDataDark,
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  textTheme: Typography.whiteHelsinki,
  brightness: Brightness.dark,
  dividerTheme: const DividerThemeData(color: Color(0xFF191919)),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF191919),
    surfaceTintColor: Color(0x1FFFFFFF),
  ),
  iconTheme: const IconThemeData(
    color: Color(0xFFECD8BD),
  ),
  scaffoldBackgroundColor: const Color(0xFF101010),
  datePickerTheme: const DatePickerThemeData(
    backgroundColor: Color(0xFF191919),
  ),
);

const darkColorScheme = ColorScheme.dark(
  brightness: Brightness.dark,
  primary: Color(0xFFECD8BD),
  secondary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFF9E9E9E),
  secondaryContainer: Color(0xFFD9D9D9),
  background: Color(0xFF101010),
  onBackground: Color(0xFF191919),
  scrim: Color(0x00000000),
);

const bottomNavigationBarThemeDataDark = BottomNavigationBarThemeData(
  backgroundColor: Color(0x1F000000),
);
