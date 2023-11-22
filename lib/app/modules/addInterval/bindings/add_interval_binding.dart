import 'package:get/get.dart';

import '../controllers/add_interval_controller.dart';

class AddIntervalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddIntervalController>(
      () => AddIntervalController(),
    );
  }
}
