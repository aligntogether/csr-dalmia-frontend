import 'package:dalmia/pages/vdf/vdfhome.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter/services.dart';

class Otp extends StatelessWidget {
  const Otp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return otp(context);
  }

  SafeArea otp(BuildContext context) {
    final TextEditingController _pinEditingController = TextEditingController();

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
                          controller: _pinEditingController,
                          pinTheme: PinTheme(
                              shape: PinCodeFieldShape.underline,
                              borderRadius: BorderRadius.circular(5),
                              fieldHeight: 50,
                              fieldWidth: 40,
                              inactiveColor: Colors.grey,
                              activeColor: Colors.black
                              // activeFillColor: Colors.white,
                              ),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          obscureText: true,
                          obscuringCharacter: '*',
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const VdfHome(),
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
