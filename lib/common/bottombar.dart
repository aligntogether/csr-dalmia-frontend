import 'package:dalmia/common/size_constant.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomTabItem extends StatefulWidget {
  final String imagePath;
  final String label;
  final int index;
  final int selectedIndex;
  final Function(int) onTabTapped;

  const CustomTabItem({
    super.key,
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
            width:  MySize.screenWidth*(32/MySize.screenWidth),
            height: MySize.screenHeight*(32/MySize.screenHeight),
          ),
          Text(
            widget.label,
            style: TextStyle(
              color: isSelected ? Color(0xFF0054A6) : Colors.black,
              fontSize: MySize.screenWidth*(12/MySize.screenWidth),
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
