import 'package:dalmia/pages/CDO/cdoappbar.dart';
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
              child: CdoAppBar(
                heading: 'VDF Reports',
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
