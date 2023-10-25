import 'package:dalmia/pages/login.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_config/flutter_config.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // await FlutterConfig.loadEnvVariables();
  runApp(const MyWidget());
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        home: Login());
  }
}
