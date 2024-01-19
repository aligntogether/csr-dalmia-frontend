import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {

  Rx<TextEditingController> selectMobileController = TextEditingController().obs;
  String? otpTokenId;
  String? referenceId;
  Rx<TextEditingController> pinEditingController = TextEditingController().obs;
  String? userIdWithTimeStamp;
  String? otpCode;
  String? userRole = "GPL";
  String? userName;


}
