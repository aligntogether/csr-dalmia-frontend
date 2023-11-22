import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/general_info_controller.dart';

class GeneralInfoView extends GetView<GeneralInfoController> {
  const GeneralInfoView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GeneralInfoView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'GeneralInfoView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
