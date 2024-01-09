import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/monitor_progress_controller.dart';

class MonitorProgressView extends GetView<MonitorProgressController> {
  const MonitorProgressView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MonitorProgressView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'MonitorProgressView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
