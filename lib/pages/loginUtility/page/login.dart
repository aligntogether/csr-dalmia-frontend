import 'package:dalmia/Constants/constants.dart';
import 'package:dalmia/helper/sharedpref.dart';
import 'package:dalmia/pages/LL/ll_home_screen.dart';


import 'package:dalmia/pages/SwitchRole/switchRole.dart';

import 'package:dalmia/pages/loginUtility/controller/loginController.dart';

import 'package:dalmia/pages/loginUtility/service/loginApiService.dart';
import 'package:dalmia/pages/loginUtility/page/otp.dart';
import 'package:dalmia/pages/vdf/vdfhome.dart';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../common/common.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FocusNode textFieldFocusNode = FocusNode();
  bool isContainerVisible = true;
  String? validationResult;
  LoginController loginController = new LoginController();
  LoginApiService loginApiService = new LoginApiService();

  @override
  void initState() {
    super.initState();
    // get usertype from shared pref
    SharedPrefHelper.getSharedPref(USER_TYPES_SHAREDPREF_KEY, context, false)
        .then((userType) => {
              if (userType != "")
                {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SwitchRole(),
                    ),
                  )
                }
              // if not null redirect to switchRole
            })
        .catchError((e) => {
              //do nothing
            });

    textFieldFocusNode.addListener(() {
      setState(() {
        isContainerVisible = !textFieldFocusNode.hasFocus;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(canPop: false, child: login(context));
  }

  SafeArea login(context) {
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
                    const SizedBox(
                      height: 20,
                    ),
                    if (isContainerVisible)
                      const Image(
                        image: AssetImage('images/icon.jpg'),
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
                        'Mobile Number',
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
                      child: TextField(
                        controller:
                            loginController.selectMobileController.value,
                        onChanged: (value) {
                          print(
                              "loginController.selectMobileController.value : ${loginController.selectMobileController.value}");
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          LengthLimitingTextInputFormatter(10),
                        ],
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: textFieldFocusNode.hasFocus
                              ? ''
                              : 'Please enter your mobile number',
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                        ),
                        focusNode: textFieldFocusNode,
                      ),
                    ),
                    const SizedBox(height: 5.0),
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
                      onPressed: ()
                          //                    {
                          //     Navigator.of(context).push(
                          // MaterialPageRoute(builder: (context) => VdfHome()),
                          //     );
                          //   }
                          async {
                        try {
                          Map<String, String> respBody = await loginApiService
                              .loginViaOtp(int.tryParse(loginController
                                  .selectMobileController.value.text));

                          if (respBody != null) {
                            setState(() {
                              loginController.selectMobileController.value =
                                  loginController.selectMobileController.value;
                              loginController.otpTokenId =
                                  respBody['otpTokenId'];
                              loginController.referenceId =
                                  respBody['referenceId'];
                            });

                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => Otp(
                                    mobileNumber: loginController
                                        .selectMobileController.value.text,
                                    otpTokenId: loginController.otpTokenId,
                                    referenceId: loginController.referenceId),
                              ),
                            );
                          }
                        } catch (e) {
                          setState(() {
                            validationResult =
                                e.toString().split('Exception:').last.trim();
                          });
                          }
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
}
