import 'package:get/get.dart';

import '../controllers/replace_vdf_controller.dart';

class ReplaceVdfBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReplaceVdfController>(
      () => ReplaceVdfController(),
    );
  }
}
