import 'package:flutter/material.dart';

class ThemeConstants {

  static const Color mainColor = Color(0xFF284C1C);
  static const Color mainColorInActive = Color(0xFF385D34);
  static const Color white = Color(0xFFFFFFFF);
  static const Color greyInActive = Color(0xFFDEE2D1);
  static const Color primaryColor = Color(0xFF2A7DE1);
  static const Color accentColor = Color(0xFF1E5BB6);
  static const Color backgroundColor = Color(0xFFE8EDDE);
  static const Color secondaryColor = Color(0xFF10B981);
  static const Color dangerColor = Color(0xFFEF4444);

  static const double borderRadius = 12.0;
  static const double padding = 16.0;

  static InputDecoration textFieldDecoration(String label, IconData? icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: icon != null ? Icon(icon, color: primaryColor) : null,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: const BorderSide(color: primaryColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(color: primaryColor.withOpacity(0.5)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: const BorderSide(color: primaryColor, width: 2),
      ),
      filled: true,
      fillColor: Colors.white,
    );
  }

  static ButtonStyle elevatedButtonStyle({Color? backgroundColor}) {
    return ElevatedButton.styleFrom(
      backgroundColor: backgroundColor ?? primaryColor,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }

  static ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    colorScheme: ColorScheme.light(
      primary: primaryColor,
      secondary: secondaryColor,
      error: dangerColor,
      background: backgroundColor,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: elevatedButtonStyle(),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        color: primaryColor,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
        color: primaryColor,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(color: Colors.black87),
      bodyMedium: TextStyle(color: Colors.black87),
    ),
  );
} 