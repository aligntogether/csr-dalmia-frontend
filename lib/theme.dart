import 'package:flutter/material.dart';

class CustomColorTheme {
  static const Color primaryColor = Colors.blue;
  static const Color accentColor = Colors.red;
  static const Color backgroundColor = Colors.white;
  static const Color textColor = Colors.black;
  static const Color labelColor = Colors.grey;
  static const Color iconColor = Color(0xFFF15A22);
  static const Color heading = Color(0xFFF15A22);
  static const Color text = Color(0xFFF15A22);
}

class CustomFontTheme {
  static const FontWeight headingwt = FontWeight.w600;
  static const FontWeight labelwt = FontWeight.w500;
  static const FontWeight textwt = FontWeight.w400;

  static const double headingSize = 16.0;
  static const double textSize = 14.0;
}

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    inputDecorationTheme: InputDecorationTheme(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
      ),
      labelStyle: TextStyle(color: CustomColorTheme.labelColor),
    ),

// Create a custom theme data based on your color theme
  );
}
