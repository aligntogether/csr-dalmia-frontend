import 'package:dalmia/common/size_constant.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;
  final Color bg;
  final Color textcolor;
  final Color bordercolor;

  CustomCard({
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.bg,
    required this.bordercolor,
    required this.textcolor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MySize.screenWidth*(110/MySize.screenWidth),
      height: MySize.screenHeight*(150/MySize.screenHeight),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(),
        shadows: [
          BoxShadow(
            color: Color(0x11000000),
            blurRadius: 20,
            offset: Offset(0, 10),
            spreadRadius: 0,
          )
        ],
      ),
      child: Card(
        color: bg,
        // elevation: 4.0,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            color: bordercolor,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
      padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SvgPicture.asset(
                imageUrl,
                width: MySize.screenWidth*(28/MySize.screenWidth),
                height: MySize.screenHeight*(28/MySize.screenHeight),
              ),
               Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: MySize.screenHeight*(13/MySize.screenHeight),
                    fontWeight: FontWeight.w500,
                    color: textcolor,
                  ),

              ),
             Text(
                  title,
                  style: TextStyle(
                    color: textcolor,
                    fontSize: MySize.screenHeight*(16/MySize.screenHeight),
                    fontWeight: FontWeight.w600,
                  ),
                ),

            ],
          ),
        ),
      ),
    );
  }
}
