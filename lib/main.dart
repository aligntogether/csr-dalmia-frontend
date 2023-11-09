import 'dart:io';

import 'package:dalmia/pages/login.dart';
import 'package:dalmia/theme.dart';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:flutter_config/flutter_config.dart';

Future<void> main() async {
  await dotenv.load(fileName: "lib/.env");

  runApp(const MyWidget());
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF181818).withOpacity(0.5)),
              borderRadius: BorderRadius.circular(5),
            ),
            floatingLabelStyle: TextStyle(color: CustomColorTheme.labelColor),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF008CD3), width: 1.0),
            ),
          ),
          dropdownMenuTheme: DropdownMenuThemeData(
              inputDecorationTheme: InputDecorationTheme(
                  border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFF181818).withOpacity(0.5)),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFF008CD3), width: 1.0),
                  ))),
        ),
        debugShowCheckedModeBanner: false,
        home: const Login());
  }
}
