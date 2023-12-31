import 'package:dalmia/pages/CDO/action.dart';
import 'package:dalmia/pages/CDO/vdffund.dart';
import 'package:dalmia/pages/CDO/vdfreports.dart';
import 'package:dalmia/pages/login.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CDOHome extends StatefulWidget {
  const CDOHome({Key? key}) : super(key: key);

  @override
  _CDOHomeState createState() => _CDOHomeState();
}

class _CDOHomeState extends State<CDOHome> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: PreferredSize(
        preferredSize:
            //  isMenuOpen ? Size.fromHeight(150) :
            Size.fromHeight(100),
        child: Stack(
          children: [
            AppBar(
              titleSpacing: 20,
              backgroundColor: Colors.white,
              title: Image(image: AssetImage('images/icon.jpg')),
              centerTitle: false,
              automaticallyImplyLeading: false,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(50),
                child: Container(
                  padding: const EdgeInsets.only(left: 30, bottom: 10),
                  alignment: Alignment.topLeft,
                  color: Colors.white,
                  child: Text(
                    'Welcome Suresh!',
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              right: 20,
              child: Column(
                children: [
                  TextButton(
                    onPressed: () {
                      _showConfirmationDialog(context);
                    },
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: CustomColorTheme.primaryColor,
                          foregroundColor: Colors.white,
                          child: Icon(Icons.logout),
                        ),
                        Text(
                          'Logout',
                          style: TextStyle(
                              color: CustomColorTheme.labelColor,
                              fontSize: CustomFontTheme.textSize,
                              fontWeight: CustomFontTheme.labelwt),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'View Data',
                style: TextStyle(
                    fontSize: CustomFontTheme.textSize,
                    fontWeight: CustomFontTheme.headingwt),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const VdfReport(),
                    ),
                  );
                },
                child: cards(
                  title: 'VDF Reports',
                  imageUrl: 'images/vdfreports.svg',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              cards(
                title: 'Weekly progress report',
                imageUrl: 'images/weeklyreports.svg',
              ),
              SizedBox(
                height: 20,
              ),
              cards(
                title: 'Expected and actual income reports',
                imageUrl: 'images/expectedreports.svg',
              ),
              SizedBox(
                height: 20,
              ),
              cards(
                title: 'Source of funds',
                imageUrl: 'images/sourceoffunds.svg',
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const VDFFunds(),
                    ),
                  );
                },
                child: cards(
                  title: 'Funds utilized by VDFs',
                  imageUrl: 'images/fundsutilized.svg',
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                'Take Action',
                style: TextStyle(
                    fontSize: CustomFontTheme.textSize,
                    fontWeight: CustomFontTheme.headingwt),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ActionAgainstHH(),
                    ),
                  );
                },
                child: Container(
                  // width: 284,
                  // height: 55,
                  padding: const EdgeInsets.all(12),
                  decoration: ShapeDecoration(
                    color: Color(0xFFC2DEEC),
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
                      ''
                      'images/takeaction.svg',
                      width: 34,
                      height: 31,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      child: Text(
                        'Drop or Select HH for Int.',
                        style: TextStyle(
                            fontSize: CustomFontTheme.textSize,
                            color: const Color(0xFF0374AD),
                            fontWeight: CustomFontTheme.labelwt),
                      ),
                    )
                  ]),
                ),
              )
            ],
          ),
        ),
      ),
    ));
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
          width: 34,
          height: 31,
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
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const Login(),
                    ),
                  );
                  // Perform actions when 'Yes' is clicked
                },
                child: const Text('Yes'),
              ),
            ),
          ],
        ),
      );
    },
  );
}
