import 'package:dalmia/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:dalmia/pages/vdf/vdfhome.dart';
import 'package:dalmia/pages/vdf/addhouse.dart';

void main() {
  runApp(const MyWidget());
}

class MyWidget extends StatelessWidget {
  const MyWidget({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Login());
  }
}
