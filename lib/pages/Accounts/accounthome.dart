import 'package:dalmia/Constants/constants.dart';
import 'package:dalmia/helper/sharedpref.dart';
import 'package:dalmia/pages/Accounts/updatebudget.dart';
import 'package:dalmia/pages/Accounts/updateexpenditure.dart';
import 'package:dalmia/pages/gpl/gpl_controller.dart';

import 'package:dalmia/pages/loginUtility/page/login.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../common/app_style.dart';
import '../../common/size_constant.dart';

class AccountsHome extends StatefulWidget {
  const AccountsHome({Key? key}) : super(key: key);

  @override
  _AccountsHomeState createState() => _AccountsHomeState();
}

class _AccountsHomeState extends State<AccountsHome> {
  String name = "";
  @override
  void initState() {
    super.initState();

    SharedPrefHelper.getSharedPref(EMPLOYEE_SHAREDPREF_KEY, context, false)
        .then((value) => setState(() {
              value == '' ? name = 'user' : name = value;
            }));
    ;
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:  appBarCommon(GplController(), context, name),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => UpdateBudget(),
                      ),
                    );
                  },
                  child: Container(
                    // width: 284,
                    // height: 55,
                    padding: const EdgeInsets.all(12),
                    decoration: ShapeDecoration(
                      color: Color(0xFFC2D7CD),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: Colors.black.withOpacity(0.10000000149011612),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      shadows: [
                        BoxShadow(
                          color: Color(0x11000000),
                          blurRadius: 20,
                          offset: Offset(0, 10),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    // color: Color(0xFFF2D4C9),
                    child: Row(children: [
                      SvgPicture.asset(
                        'images/sourceoffunds.svg',
                        width: MySize.screenWidth*(40/MySize.screenWidth),

                        colorFilter: ColorFilter.mode(Color(0xFF006838),
                            BlendMode.srcIn), // Change color to blue
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Flexible(
                        child: Text(
                          'Update Budget',
                          style: TextStyle(
                              fontSize: CustomFontTheme.textSize,
                              color: const Color(0xFF006838),
                              fontWeight: CustomFontTheme.labelwt),
                        ),
                      )
                    ]),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const UpdateExpenditure(),
                      ),
                    );
                  },
                  child: cards(
                    title: 'Update Expenditure',
                    imageUrl: 'images/sendmoney.svg',
                  ),
                ),
                SizedBox(
                  height: MySize.screenHeight*(40/MySize.screenHeight),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class cards extends StatelessWidget {
  final String imageUrl;
  final String title;

  const cards({
    super.key,
    required this.imageUrl,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 284,
      // height: 55,
      padding: const EdgeInsets.all(12),
      decoration: ShapeDecoration(
        color: Color(0x33F15A22),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            color: Colors.black.withOpacity(0.10000000149011612),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x11000000),
            blurRadius: 20,
            offset: Offset(0, 10),
            spreadRadius: 0,
          )
        ],
      ),
      // color: Color(0xFFF2D4C9),
      child: Row(children: [
        SvgPicture.asset(
          imageUrl,
          width: MySize.screenWidth*(40/MySize.screenWidth),

        ),
        SizedBox(
          width: 20,
        ),
        Flexible(
          child: Text(
            title,
            style: TextStyle(
                fontSize: CustomFontTheme.textSize,
                color: Color(0xFFB94216),
                fontWeight: CustomFontTheme.labelwt),
          ),
        )
      ]),
    );
  }
}

void _showConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        alignment: Alignment.topCenter,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: SizedBox(
          width: 283,
          height: 80,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Icon(Icons.close),
              ),
              const Text(
                'Are you sure you want to logout of the application?',
                style: TextStyle(
                  fontSize: 16,
                  // fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: 157,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(),
                  backgroundColor: CustomColorTheme.primaryColor,
                ),
                onPressed: () async {
                  await SharedPrefHelper.clearSharedPrefAccess();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const Login(),
                    ),
                  );
                  // Perform actions when 'Yes' is clicked
                },
                child: const Text(
                  'Yes',
                  style: TextStyle(color: Colors.white),
                ),
                   
              ),
            ),
          ],
        ),
      );
    },
  );
}
