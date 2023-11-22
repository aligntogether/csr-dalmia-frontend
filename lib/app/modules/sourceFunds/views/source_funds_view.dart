import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/source_funds_controller.dart';

class SourceFundsView extends GetView<SourceFundsController> {
  const SourceFundsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SourceFundsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SourceFundsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
