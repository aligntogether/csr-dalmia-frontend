import 'package:get/get.dart';

import '../controllers/expected_actual_controller.dart';

class ExpectedActualBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExpectedActualController>(
      () => ExpectedActualController(),
    );
  }
}
