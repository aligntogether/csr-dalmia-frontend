import 'package:get/get.dart';

import '../controllers/source_funds_controller.dart';

class SourceFundsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SourceFundsController>(
      () => SourceFundsController(),
    );
  }
}
