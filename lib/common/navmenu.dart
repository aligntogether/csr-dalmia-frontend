import 'package:dalmia/pages/loginUtility/page/login.dart';
import 'package:dalmia/pages/vdf/Reports/home.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Positioned navmenu(BuildContext context, final Function() toggleMenu) {
  return Positioned(
    top: 0,
    left: 0,
    width: MediaQuery.of(context).size.width,
    height: 150,
    child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          // borderRadius: BorderRadius.circular(8),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey,
          //     blurRadius: 4,
          //     offset: const Offset(0, 2),
          //   ),
          // ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            GestureDetector(
                onTap: () {
                  toggleMenu();
                },
                child: Icon(Icons.close)),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const HomeReport(),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('images/report.svg'),
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    'Reports',
                    style: TextStyle(
                        fontSize: CustomFontTheme.textSize,
                        fontWeight: CustomFontTheme.labelwt),
                  )
                ],
              ),
            ),
            Divider(
              color: CustomColorTheme.textColor
                  .withOpacity(0.3), // Add your desired color for the line
              thickness: 1, // Add the desired thickness for the line
            ),
            GestureDetector(
              onTap: () {
                _showConfirmationDialog(context);
                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (context) => const Login(),
                //   ),
                // );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'images/logout.svg',
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    'Logout',
                    style: TextStyle(
                        fontSize: CustomFontTheme.textSize,
                        fontWeight: CustomFontTheme.labelwt),
                  )
                ],
              ),
            )
          ],
        )),
  );
}

void _showConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        alignment: Alignment.topCenter,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        titlePadding: EdgeInsets.all(0),
        title: Padding(
          padding: const EdgeInsets.only(top: 10, left: 20, right: 10),
          child: SizedBox(
            width: 283,
            height: 90,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(Icons.close),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 20, right: 10),
                  child: const Text(
                    'Are you sure you want to logout of the application?',
                    style: TextStyle(
                      fontSize: 16,
                      // fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
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
                child: const Text(
                  'Yes',
                  style: TextStyle(
                    fontSize: CustomFontTheme.textSize,
                    fontWeight: CustomFontTheme.labelwt,
                    letterSpacing: 0.84,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
