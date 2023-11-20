import 'package:dalmia/pages/CDO/cdohome.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';

class VdfReport extends StatefulWidget {
  const VdfReport({super.key});

  @override
  State<VdfReport> createState() => _VdfReportState();
}

class _VdfReportState extends State<VdfReport> {
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
                        padding: const EdgeInsets.only(bottom: 10),
                        color: Colors.white,
                        child: Text(
                          'VDF Report',
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
                            // _showConfirmationDialog(context);
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
              child: Column(
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const CDOHome(),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.keyboard_arrow_left_sharp,
                            color: CustomColorTheme.textColor,
                          ),
                          Text(
                            'Main Menu',
                            style: TextStyle(
                                fontSize: CustomFontTheme.textSize,
                                color: CustomColorTheme.textColor),
                          )
                        ],
                      )),
                  SingleChildScrollView()
                ],
              ),
            )));
  }
}
