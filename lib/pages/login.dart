import 'package:dalmia/pages/otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../common/common.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FocusNode textFieldFocusNode = FocusNode();
  bool isContainerVisible = true;

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
    return login(context);
  }

  SafeArea login(context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            const Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: FractionallySizedBox(
                widthFactor: 1.0,
                child: Image(
                  image: AssetImage('images/home.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Positioned(
              top: 250,
              left: 0,
              right: 0,
              child: FractionallySizedBox(
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
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                            LengthLimitingTextInputFormatter(10),
                          ],
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            hintText: textFieldFocusNode.hasFocus
                                ? ''
                                : 'Please enter your mobile number',
                            border: const OutlineInputBorder(),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black), // Change the color here
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                          ),
                          focusNode: textFieldFocusNode,
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      SubmitButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const Otp(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
