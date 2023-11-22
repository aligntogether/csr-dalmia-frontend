import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_interval_controller.dart';

class AddIntervalView extends GetView<AddIntervalController> {
  const AddIntervalView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddIntervalView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AddIntervalView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
