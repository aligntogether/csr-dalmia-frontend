import 'package:dalmia/pages/vdf/Reports/Home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget _buildDrawer1() {
  return Positioned.fill(
    child: GestureDetector(
      onTap: () {
        // _closeDrawer();
        // Close the drawer when tapping outside
      },
      child: Container(
        color: Colors.black.withOpacity(0.3),
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            padding: EdgeInsets.only(left: 20, right: 20),
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
                      // _closeDrawer();
                      // Handle item 1 click
                      // Close the drawer
                    },
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                      'images/report.svg',

                      // width: 24, // Adjust the width as needed
                      // height: 24, // Adjust the height as needed
                    ),
                    title: const Text('Reports'),
                    // onTap: () {
                    //   Navigator.of(context).push(
                    //     MaterialPageRoute(
                    //       builder: (context) => HomeReport(),
                    //     ),
                    //   );
                    //   // Handle item 1 click
                    //   // Close the drawer
                    // },
                  ),
                  Divider(
                    color: Colors.grey, // Add your desired color for the line
                    thickness: 1, // Add the desired thickness for the line
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                      'images/logout.svg',

                      // width: 24, // Adjust the width as needed
                      // height: 24, // Adjust the height as needed
                    ),
                    title: const Text('Logout'),
                    onTap: () {
                      // _showConfirmationDialog(context);
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
