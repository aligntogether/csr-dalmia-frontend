import 'package:dalmia/Constants/constants.dart';
import 'package:dalmia/pages/login.dart';
import 'package:dalmia/pages/vdf/Reports/Home.dart';
import 'package:dalmia/pages/vdf/vdfhome.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  DrawerWidgetState createState() => DrawerWidgetState();
}

bool toggle = false;

class DrawerWidgetState extends State<DrawerWidget> {
  void _closeDrawer() {
    setState(() {
      toggle = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _buildDrawer1();
  }

  Widget _buildDrawer1() {
    return Positioned.fill(
      child: GestureDetector(
        onTap: () {
          // Close the drawer when tapping outside
        },
        child: Container(
          color: Colors.black.withOpacity(0.3),
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              // height: MediaQuery.of(context).size.height / 3,
              color: Colors.white,
              child: SingleChildScrollView(
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(Icons.close),
                      onTap: () {
                        _closeDrawer();
                        // Navigator.of(context).pop();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const VdfHome(),
                          ),
                        );
                        // Handle item 1 click
                        // Close the drawer
                      },
                    ),
                    ListTile(
                      leading: SvgPicture.asset(
                        'images/report.svg',
                      ),
                      title: const Text('Reports'),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const HomeReport(),
                          ),
                        );
                        // Handle item 1 click
                        // Close the drawer
                      },
                    ),
                    const Divider(
                      color: Colors.grey, // Add your desired color for the line
                      thickness: 1, // Add the desired thickness for the line
                    ),
                    ListTile(
                      leading: SvgPicture.asset(
                        'images/logout.svg',
                      ),
                      title: const Text('Logout'),
                      onTap: () {
                        _showConfirmationDialog(context);
                        // Handle item 2 click
                        // Close the drawer
                      },
                    ),

                    // Add more items as needed
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
}
