import 'dart:async';

import 'package:dalmia/Constants/constant_export.dart';
import 'package:dalmia/app/modules/chooseRole/views/choose_role_view.dart';
import 'package:dalmia/app/routes/app_pages.dart';
import 'package:dalmia/helper/sharedpref.dart';
import 'package:dalmia/models/AuthResponse.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter/services.dart';
import 'package:dalmia/pages/SwitchRole/switchRole.dart';
import '../../../Constants/constants.dart';
import '../../../common/common.dart';
import '../../../common/size_constant.dart';
import '../controller/loginController.dart';
import '../service/loginApiService.dart';

class Otp extends StatefulWidget {
  String? mobileNumber, otpTokenId, referenceId;

  Otp({super.key, this.mobileNumber, this.otpTokenId, this.referenceId});

  // const Otp(String mobileNumber, String? otpTokenId, String? referenceId, {Key? key}) : super(key: key);

  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  final FocusNode textFieldFocusNode = FocusNode();
  bool isContainerVisible = true;
  final TextEditingController pinEditingController = TextEditingController();
  String? otpCode;
  String? validationResult;
  LoginController loginController = new LoginController();
  LoginApiService loginApiService = new LoginApiService();
  bool isResendEnabled = false;
  int resendTimer = 120; // 2 minutes in seconds
  Timer? timer;
  @override
  void dispose() {
    textFieldFocusNode.dispose();
    pinEditingController.dispose();
    timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Start the countdown timer
    startResendTimer();
    textFieldFocusNode.addListener(() {
      setState(() {
        isContainerVisible = !textFieldFocusNode.hasFocus;
      });
    });
  }

  void startResendTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        if (resendTimer > 0) {
          resendTimer--;
        } else {
          // Enable the resend button after 2 minutes
          isResendEnabled = true;
          timer!.cancel(); // Cancel the timer when it reaches 0
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return otp(context);
  }

  SafeArea otp(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            FractionallySizedBox(
              widthFactor: 1.0,
              child: Image(
                image: AssetImage('images/home.png'),
                fit:MySize.safeWidth! * 0.8 > MySize.safeHeight! * 0.4 ? BoxFit.fitHeight : BoxFit.fill,
                width: MySize.safeWidth! * 0.8,
                height: MySize.safeHeight! * 0.4,
              ),
            ),
            FractionallySizedBox(
              widthFactor: 1.0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  border: Border.all(color: Colors.white, width: 2.0),
                ),
                alignment: Alignment.topCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (isContainerVisible)
                      const Image(
                        image: AssetImage('images/icon.jpg'),
                        height: 80,
                      ),
                    if (isContainerVisible)
                      Container(
                        padding: const EdgeInsets.all(20.0),
                        margin: const EdgeInsets.only(bottom: 20.0),
                        child: const Text(
                          'Gram Parivartan Project',
                          style: TextStyle(
                            color: Color(0xff0054a6),
                            fontSize: 25.0,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20.0),
                      child: const Text(
                        'Please enter the OTP',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 40.0),
                      width: 300.0,
                      child: PinCodeTextField(
                        appContext: context,
                        length: 6,
                        controller: loginController.pinEditingController.value,
                        onChanged: (value) {
                          setState(() {
                            otpCode = value;
                          });
                          print(
                              "loginController.pinEditingController.value : ${loginController.pinEditingController}, otpcode : ${loginController.otpCode} : SDF : $otpCode");
                        },
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.underline,
                          borderRadius: BorderRadius.circular(5),
                          fieldHeight: 50,
                          fieldWidth: 40,
                          inactiveColor: Colors.grey,
                          activeColor: Colors.black,
                        ),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        obscureText: true,
                        obscuringCharacter: '*',
                        focusNode: textFieldFocusNode,
                      ),
                    ),
                    // const SizedBox(height: 5.0),
                    GestureDetector(
                      onTap: () {
                        if (isResendEnabled) {
                          // Handle resend OTP logic here
                          // You can call the API to resend OTP and then start the timer again
                          loginApiService
                              .loginViaOtp(int.tryParse(widget.mobileNumber!))
                              .then((value) => {
                                    print(value),
                                    setState(() {
                                      loginController
                                              .selectMobileController.value =
                                          loginController
                                              .selectMobileController.value;
                                      loginController.otpTokenId =
                                          value['otpTokenId'];
                                      loginController.referenceId =
                                          value['referenceId'];
                                      print(value['otpTokenId']);
                                    }),
                                    startResendTimer(),
                                    setState(() {
                                      isResendEnabled =
                                          false; // Disable the button during the timer
                                      resendTimer =
                                          120; // Reset the timer to 2 minutes
                                    })
                                  });
                        }
                      },
                      child: Text(
                        isResendEnabled
                            ? 'Resend OTP'
                            : 'Resend OTP in ${resendTimer ~/ 60}:${(resendTimer % 60).toString().padLeft(2, '0')} secs',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF0054A6),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          decoration: isResendEnabled
                              ? TextDecoration.underline
                              : TextDecoration.none,
                        ),
                      ),
                    ),

                    // Display the error message with red color if there's an error
                    if (validationResult != null)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          validationResult!,
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    const SizedBox(height: 20.0),
                    SubmitButton(
                      onPressed: () async {
                        // if (respBody != null) {
                        handleOtpVerification();
                        // }
                      },
                    ),
                    const SizedBox(height: 20.0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void handleOtpVerification() async {
    try {
      AuthResponse authResponse = await verifyOtp();
      SharedPrefHelper.storeSharedPref(
          USER_ID_SHAREDPREF_KEY, authResponse.referenceId);
      SharedPrefHelper.storeSharedPref(
          USER_TYPES_SHAREDPREF_KEY, authResponse.userType);
      SharedPrefHelper.storeSharedPref(
          ACCESS_TOKEN_SHAREDPREF_KEY, authResponse.accessToken);
      SharedPrefHelper.storeSharedPref(
          APP_NAME_SHAREDPREF_KEY, authResponse.appName);
      SharedPrefHelper.storeSharedPref(
          REFRESH_TOKEN_SHAREDPREF_KEY, authResponse.refreshToken);
      SharedPrefHelper.storeSharedPref(
          PLATFORM_SHAREDPREF_KEY, authResponse.platform);
      SharedPrefHelper.storeSharedPref(
          EMPLOYEE_SHAREDPREF_KEY, authResponse.employeeName);
      loginController.userName = authResponse.employeeName;

      Get.toNamed(Routes.CHOOSE_ROLE);
    } catch (e) {
      setState(() {
        validationResult = "Incorrect OTP. Please try again.";
      });
    }
  }

  Future<AuthResponse> verifyOtp() async {

    setState(() {
      loginController.selectMobileController.value.text = widget.mobileNumber!;
      if (loginController.otpTokenId == null)
        loginController.otpTokenId = widget.otpTokenId;
      loginController.referenceId = widget.referenceId;
      loginController.userIdWithTimeStamp =
          'SWP${DateTime.now().millisecondsSinceEpoch}';
    });

    Map<String, String> respBodyMap =
        await loginApiService.checkValidUserOtp(loginController, otpCode);
    if (respBodyMap == null) {
      setState(() {
        validationResult = "Something Went Wrong!";
      });
    }

    Map<String, String> userRoleMap = await loginApiService
        .getUserRoleByReferenceId(loginController.referenceId ?? '');

    if (userRoleMap == null) {
      setState(() {
        validationResult = "Something Went Wrong!";
      });
    }

    return AuthResponse(
        loginController.referenceId!,
        userRoleMap['userRole']!,
        respBodyMap['appName']!, // appName
        respBodyMap['accessToken']!, // accessToken
        respBodyMap['refreshToken']!, //refreshToken
        respBodyMap['platform']!, // platform
        userRoleMap['userName']! // employeeName
        );
  }
}
