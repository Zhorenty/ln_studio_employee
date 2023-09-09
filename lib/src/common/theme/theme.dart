import 'package:flutter/material.dart';

/// Light theme of this application.
final $lightThemeData = ThemeData(
  colorScheme: lightColorScheme,
  brightness: Brightness.light,
  useMaterial3: true,
);

final lightColorScheme = ColorScheme.fromSeed(
  seedColor: const Color(0xFFFFFFFF),
  primary: const Color(0xFFFFFFFF),
  secondary: const Color(0xFFD9D9D9),
  onBackground: const Color(0xFF000000),
);

/// Dark theme of this application.
final $darkThemeData = ThemeData(
  colorScheme: darkColorScheme,
  bottomNavigationBarTheme: bottomNavigationBarThemeDataDark,
  textTheme: Typography.whiteHelsinki,
  brightness: Brightness.dark,
  useMaterial3: true,
  dividerTheme: const DividerThemeData(color: Color(0xFF191919)),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF191919),
    surfaceTintColor: Color(0x1FFFFFFF),
  ),
  iconTheme: const IconThemeData(
    color: Color(0xFFECD8BD),
  ),
  scaffoldBackgroundColor: const Color(0xFF101010),
);

final darkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color(0xFF000000),
  primary: const Color(0xFFECD8BD),
  secondary: const Color(0xFFFFFFFF),
  primaryContainer: const Color(0xFF9E9E9E),
  secondaryContainer: const Color(0xFFD9D9D9),
  background: const Color(0xFF101010),
  onBackground: const Color(0xFF191919),
  scrim: const Color(0x00000000),
);

const bottomNavigationBarThemeDataDark = BottomNavigationBarThemeData(
  backgroundColor: Color(0x1F000000),
);
