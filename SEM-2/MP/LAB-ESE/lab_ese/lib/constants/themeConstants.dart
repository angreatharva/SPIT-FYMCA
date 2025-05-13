import 'package:flutter/material.dart';

class ThemeConstants {
  // Primary colors
  static const Color primaryColor = Color(0xFF1A6DB3);
  static const Color secondaryColor = Color(0xFF2E86C1);
  static const Color accentColor = Color(0xFF3498DB);
  
  // Background colors
  static const Color backgroundColor = Color(0xFFF5F8FA);
  static const Color cardColor = Colors.white;
  
  // Text colors
  static const Color textPrimaryColor = Color(0xFF2C3E50);
  static const Color textSecondaryColor = Color(0xFF566573);
  static const Color textLightColor = Color(0xFF7F8C8D);
  
  // Status colors
  static const Color successColor = Color(0xFF2ECC71);
  static const Color errorColor = Color(0xFFE74C3C);
  static const Color warningColor = Color(0xFFF39C12);
  
  // Button styles
  static final ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: primaryColor,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );
  
  static final ButtonStyle secondaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.white,
    foregroundColor: primaryColor,
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
      side: const BorderSide(color: primaryColor),
    ),
  );
  
  // Text styles
  static const TextStyle headingStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: textPrimaryColor,
  );
  
  static const TextStyle subheadingStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: textPrimaryColor,
  );
  
  static const TextStyle bodyTextStyle = TextStyle(
    fontSize: 16,
    color: textSecondaryColor,
  );
  
  static const TextStyle captionStyle = TextStyle(
    fontSize: 14,
    color: textLightColor,
  );
  
  // Input decoration
  static final InputDecoration inputDecoration = InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: textLightColor),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: textLightColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: primaryColor, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: errorColor),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    filled: true,
    fillColor: Colors.white,
  );
  
  // Card decoration
  static final BoxDecoration cardDecoration = BoxDecoration(
    color: cardColor,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        blurRadius: 10,
        offset: const Offset(0, 4),
      ),
    ],
  );
}