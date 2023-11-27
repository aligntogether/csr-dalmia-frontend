import 'package:get/get.dart';

class FeedbackController extends GetxController {
  String? selectRegion;
  String? selectLocation;
  RxBool sendMsg = false.obs;
  RxBool accept = false.obs;
}
