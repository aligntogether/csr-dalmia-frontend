import 'package:dalmia/pages/otp.dart';
import 'package:flutter/material.dart';
import 'package:dalmia/pages/vdf/vdfhome.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return login(context);
  }

  SafeArea login(context) {
    final FocusNode _textFieldFocusNode = FocusNode();

    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   title: const Text(
        //     'Appbar',
        //   ),
        //   centerTitle: true,
        //   backgroundColor: Colors.white,
        // ),
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
                      Container(
                        child: const Image(
                          image: AssetImage('images/icon.jpg'),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(20.0),
                        margin: const EdgeInsets.only(bottom: 20.0),
                        child: const Text(
                          'Gram Parivartan Project',
                          style: TextStyle(
                            color: Color(0xff0054a6),
                            fontSize: 30.0,
                            fontWeight: FontWeight.w700,
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
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            hintText: _textFieldFocusNode.hasFocus
                                ? ''
                                : 'Please enter your mobile number',
                            border: const OutlineInputBorder(),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                          ),
                          focusNode: _textFieldFocusNode,
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const Otp(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xcc0054a6),
                          elevation: 5.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        child: Container(
                          width: 293,
                          height: 60.0,
                          alignment: Alignment.center,
                          child: const Text(
                            'Submit',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              height: 1.2125,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ),
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
