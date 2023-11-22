import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_cluster_controller.dart';

class AddClusterView extends GetView<AddClusterController> {
  const AddClusterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddClusterView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AddClusterView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
