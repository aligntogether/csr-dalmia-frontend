import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_village_controller.dart';

class AddVillageView extends GetView<AddVillageController> {
  const AddVillageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddVillageView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AddVillageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
