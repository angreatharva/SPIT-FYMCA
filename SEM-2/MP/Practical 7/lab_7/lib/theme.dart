import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF1565C0); // Blue
  static const Color secondaryColor = Color(0xFFD32F2F); // Red
  static const Color accentColor = Color(0xFFFFFFFF); // White

  static ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    colorScheme: ColorScheme.light(
      primary: primaryColor,
      secondary: secondaryColor,
    ),
    fontFamily: 'Jonesy',
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontFamily: 'JonesyCapitals', fontSize: 32, fontWeight: FontWeight.bold),
      displayMedium: TextStyle(fontFamily: 'JonesyCapitals', fontSize: 28, fontWeight: FontWeight.bold),
      displaySmall: TextStyle(fontFamily: 'JonesyCapitals', fontSize: 24, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(fontFamily: 'Jonesy', fontSize: 16),
      bodyMedium: TextStyle(fontFamily: 'Jonesy', fontSize: 14),
      labelLarge: TextStyle(fontFamily: 'JonesyCapitals', fontSize: 18, fontWeight: FontWeight.bold),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      titleTextStyle: TextStyle(fontFamily: 'JonesyCapitals', fontSize: 20, fontWeight: FontWeight.bold),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: secondaryColor,
      foregroundColor: Colors.white,
    ),
  );
}
