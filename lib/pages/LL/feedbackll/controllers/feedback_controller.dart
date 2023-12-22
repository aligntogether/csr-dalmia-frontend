import 'package:get/get.dart';

class FeedbackControllerLL extends GetxController {
  String? selectRegion;
  String? selectLocation;
  RxBool sendMsg = false.obs;
  RxBool accept = false.obs;
}
