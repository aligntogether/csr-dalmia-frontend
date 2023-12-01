import 'package:get/get.dart';

import '../controllers/general_info_controller.dart';

class GeneralInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GeneralInfoController>(
      () => GeneralInfoController(),
    );
  }
}
