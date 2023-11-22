import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_panchayat_controller.dart';

class AddPanchayatView extends GetView<AddPanchayatController> {
  const AddPanchayatView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddPanchayatView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AddPanchayatView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
