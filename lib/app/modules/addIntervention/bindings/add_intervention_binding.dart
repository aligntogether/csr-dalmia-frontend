import 'package:get/get.dart';

import '../controllers/add_intervention_controller.dart';

class AddInterventionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddInterventionController>(
      () => AddInterventionController(),
    );
  }
}
