import 'package:get/get.dart';

import '../controllers/location_wise_controller.dart';

class LocationWiseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocationWiseController>(
      () => LocationWiseController(),
    );
  }
}
