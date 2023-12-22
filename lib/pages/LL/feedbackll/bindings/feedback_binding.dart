import 'package:get/get.dart';

import '../controllers/feedback_controller.dart';

class FeedbackBindingLL extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FeedbackControllerLL>(
      () => FeedbackControllerLL(),
    );
  }
}
