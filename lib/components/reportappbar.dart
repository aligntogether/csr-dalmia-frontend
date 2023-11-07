import 'package:dalmia/Constants/constants.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';

class ReportAppBar extends StatefulWidget {
  final String heading;

  ReportAppBar({required this.heading, Key? key}) : super(key: key);

  @override
  _ReportAppBarState createState() => _ReportAppBarState();
}

bool toggle = false;

class _ReportAppBarState extends State<ReportAppBar> {
  void _openDrawer() {
    setState(() {
      toggle = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 20,
      backgroundColor: Colors.white,
      title: Image(image: AssetImage('images/icon.jpg')),
      automaticallyImplyLeading: false,
      actions: <Widget>[
        CircleAvatar(
          backgroundColor: CustomColorTheme.primaryColor,
          child: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications_none_outlined,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        IconButton(
          iconSize: 30,
          onPressed: () {
            _openDrawer();
          },
          icon: Icon(
            Icons.menu,
            color: CustomColorTheme.primaryColor,
          ),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: Container(
          padding: const EdgeInsets.only(left: 30, bottom: 10),
          alignment: Alignment.topCenter,
          color: Colors.white,
          child: Text(
            widget.heading,
            style: TextStyle(
              fontSize: CustomFontTheme.textSize,
              fontWeight: CustomFontTheme.headingwt,
            ),
          ),
        ),
      ),
    );
  }
}
