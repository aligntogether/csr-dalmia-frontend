import 'package:flutter/material.dart';

class CustomColorTheme {
  static const Color primaryColor = Colors.blue;
  static const Color accentColor = Colors.red;
  static const Color backgroundColor = Colors.white;
  static const Color textColor = Colors.black;
  static const Color labelColor = Colors.grey;
  static const Color iconColor = Color(0xFFF15A22);
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
