import 'package:get/get.dart';

import '../controllers/amount_utilized_controller.dart';

class AmountUtilizedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AmountUtilizedController>(
      () => AmountUtilizedController(),
    );
  }
}
