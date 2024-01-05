import 'package:get/get.dart';

import '../controllers/add_panchayat_controller.dart';

class AddPanchayatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddPanchayatController>(
      () => AddPanchayatController(),
    );
  }
}
