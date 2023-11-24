import 'package:get/get.dart';

import '../controllers/monitor_progress_controller.dart';

class MonitorProgressBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MonitorProgressController>(
      () => MonitorProgressController(),
    );
  }
}
