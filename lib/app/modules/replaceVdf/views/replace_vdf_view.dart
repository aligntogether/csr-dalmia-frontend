import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/replace_vdf_controller.dart';

class ReplaceVdfView extends GetView<ReplaceVdfController> {
  const ReplaceVdfView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ReplaceVdfView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ReplaceVdfView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
