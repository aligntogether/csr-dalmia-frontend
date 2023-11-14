import 'package:flutter/material.dart';

class CustomColorTheme {
  static const Color primaryColor = Color(0xFF27528F);
  static const Color secondaryColor = Color(0xFF008CD3);
  // static const Color inactiveColor = Color(0xFF27528F);

  static const Color backgroundColor = Colors.white;
  static const Color textColor = Color(0xFF181818);
  static Color labelColor = Color(0xFF181818).withOpacity(0.7);

  static const Color iconColor = Color(0xFFF15A22);
}

class CustomFontTheme {
  static const FontWeight headingwt = FontWeight.w700;
  static const FontWeight labelwt = FontWeight.w500;
  static const FontWeight textwt = FontWeight.w400;

  static const double headingSize = 16.0;
  static const double textSize = 16.5;
}

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(color: CustomColorTheme.labelColor),
    ),

// Create a custom theme data based on your color theme
  );
}
