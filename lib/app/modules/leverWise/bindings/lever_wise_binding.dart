import 'package:get/get.dart';

import '../controllers/lever_wise_controller.dart';

class LeverWiseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LeverWiseController>(
      () => LeverWiseController(),
    );
  }
}
