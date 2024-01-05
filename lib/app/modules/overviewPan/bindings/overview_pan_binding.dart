import 'package:get/get.dart';

import '../controllers/overview_pan_controller.dart';

class OverviewPanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OverviewPanController>(
      () => OverviewPanController(),
    );
  }
}
