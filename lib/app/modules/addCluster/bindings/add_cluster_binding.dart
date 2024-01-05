import 'package:get/get.dart';

import '../controllers/add_cluster_controller.dart';

class AddClusterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddClusterController>(
      () => AddClusterController(),
    );
  }
}
