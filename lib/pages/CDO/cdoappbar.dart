import 'package:dalmia/pages/login.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';

class CdoAppBar extends StatelessWidget {
  final String heading;
  const CdoAppBar({
    super.key,
    required this.heading,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                padding: const EdgeInsets.only(bottom: 10),
                color: Colors.white,
                child: Text(
                  heading,
                  style: TextStyle(
                      fontSize: CustomFontTheme.headingSize,
                      fontWeight: CustomFontTheme.headingwt),
                ),
              ),
            ),
          ),
          Positioned(
            right: 20,
            top: 10,
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
