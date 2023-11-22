import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_location_controller.dart';

class AddLocationView extends GetView<AddLocationController> {
  const AddLocationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddLocationView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AddLocationView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
