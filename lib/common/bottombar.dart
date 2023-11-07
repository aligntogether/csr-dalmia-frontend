import 'package:dalmia/pages/vdf/Draft/draft.dart';
import 'package:dalmia/pages/vdf/household/addhouse.dart';
import 'package:dalmia/pages/vdf/street/Addstreet.dart';
import 'package:dalmia/pages/vdf/vdfhome.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomTabItem extends StatefulWidget {
  final String imagePath;
  final String label;
  final int index;
  final int selectedIndex;
  final Function(int) onTabTapped;

  CustomTabItem({
    required this.imagePath,
    required this.label,
    required this.index,
    required this.selectedIndex,
    required this.onTabTapped,
  });

  @override
  _CustomTabItemState createState() => _CustomTabItemState();
}

class _CustomTabItemState extends State<CustomTabItem> {
  @override
  Widget build(BuildContext context) {
    bool isSelected = widget.index == widget.selectedIndex;

    return InkWell(
      onTap: () {
        widget.onTabTapped(widget.index);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            widget.imagePath,
            // colorFilter: isSelected ? CustomColorTheme.primaryColor : Colors.black,
            width: 24,
            height: 24,
          ),
          Text(
            widget.label,
            style: TextStyle(
              // color: isSelected ? CustomColorTheme.primaryColor : Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
