import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';

class reportappbar extends StatelessWidget {
  final String heading;
  const reportappbar({
    required this.heading,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 20,
      backgroundColor: Colors.white,
      title: const Image(image: AssetImage('images/icon.jpg')),
      automaticallyImplyLeading: false,
      actions: <Widget>[
        CircleAvatar(
          backgroundColor: CustomColorTheme.primaryColor,
          child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_none_outlined,
                color: Colors.white,

                // color: Colors.blue,
              )),
        ),
        const SizedBox(
          width: 20,
        ),
        IconButton(
          iconSize: 30,
          onPressed: () {
            // _openDrawer();
          },
          icon: const Icon(
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
            heading,
            style: TextStyle(
                fontSize: CustomFontTheme.textSize,
                fontWeight: CustomFontTheme.headingwt),
          ),
        ),
      ),
    );
  }
}
