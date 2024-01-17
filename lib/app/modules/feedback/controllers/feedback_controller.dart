import 'package:get/get.dart';

class FeedbackController extends GetxController {
  String? selectRegion;
  int? selectRegionId;
  String? selectLocation;
  int? selectLocationLead;
  int? selectLocationId;
  String? selectUserType;
  String? userId;
  String? userType;
  RxBool sendMsg = false.obs;
  RxBool accept = false.obs;
  List<Map<String, dynamic>>? locations;
  String? feedbackId;
  String? senderId;
  String? recipientId;


  void updateLocations(List<Map<String, dynamic>> locations) {
    this.locations = locations;
    update(["add"]);
  }


}
