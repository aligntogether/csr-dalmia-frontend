import 'package:get/get.dart';

import '../controllers/performance_vdf_controller.dart';

class PerformanceVdfBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PerformanceVdfController>(
      () => PerformanceVdfController(),
    );
  }
}
