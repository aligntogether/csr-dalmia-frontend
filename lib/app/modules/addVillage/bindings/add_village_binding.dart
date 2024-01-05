import 'package:get/get.dart';

import '../controllers/add_village_controller.dart';

class AddVillageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddVillageController>(
      () => AddVillageController(),
    );
  }
}
