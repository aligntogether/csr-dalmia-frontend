import 'package:dalmia/Constants/constant_export.dart';
import 'package:dalmia/helper/sharedpref.dart';
import 'package:dalmia/models/AuthResponse.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter/services.dart';
import 'package:dalmia/pages/SwitchRole/switchRole.dart';
import '../Constants/constants.dart';
import '../common/common.dart';

class Otp extends StatefulWidget {
  const Otp({Key? key}) : super(key: key);

  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  final FocusNode textFieldFocusNode = FocusNode();
  bool isContainerVisible = true;
  @override
  void dispose() {
    textFieldFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    textFieldFocusNode.addListener(() {
      setState(() {
        isContainerVisible = !textFieldFocusNode.hasFocus;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return otp(context);
  }

  SafeArea otp(BuildContext context) {
    final TextEditingController pinEditingController = TextEditingController();

    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            FractionallySizedBox(
              widthFactor: 1.0,
              child: Image(
                image: AssetImage('images/home.png'),
                fit: BoxFit.fill,
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
                      ),
                    // if (isContainerVisible)
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
                        onChanged: (value) {},
                        controller: pinEditingController,
                        pinTheme: PinTheme(
                            shape: PinCodeFieldShape.underline,
                            borderRadius: BorderRadius.circular(5),
                            fieldHeight: 50,
                            fieldWidth: 40,
                            inactiveColor: Colors.grey,
                            activeColor: Colors.black),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        obscureText: true,
                        obscuringCharacter: '*',
                        focusNode: textFieldFocusNode,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    SubmitButton(
                      onPressed: () {
                        handleOtpVerification();
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
      SharedPrefHelper.storeSharedPref(USER_ID_SHAREDPREF_KEY, authResponse.referenceId);
      SharedPrefHelper.storeSharedPref(USER_TYPES_SHAREDPREF_KEY, authResponse.userType);
      SharedPrefHelper.storeSharedPref(ACCESS_TOKEN_SHAREDPREF_KEY, authResponse.accessToken);
      SharedPrefHelper.storeSharedPref(APP_NAME_SHAREDPREF_KEY, authResponse.appName);
      SharedPrefHelper.storeSharedPref( REFRESH_TOKEN_SHAREDPREF_KEY, authResponse.refreshToken);
      SharedPrefHelper.storeSharedPref(PLATFORM_SHAREDPREF_KEY, authResponse.platform);
      SharedPrefHelper.storeSharedPref(EMPLOYEE_SHAREDPREF_KEY, authResponse.employeeName);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (BuildContext ctx) => SwitchRole()),
      );
    }
    catch (e) {
      // show error on screen
    }
  }

  Future<AuthResponse> verifyOtp() async {
    return AuthResponse(
        "10001",
        "GPL",
        "CSR",
        "",
        "",
        "",
        "TestName");
  }
}

