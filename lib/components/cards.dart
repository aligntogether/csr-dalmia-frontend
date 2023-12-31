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
      width: 110,
      height: 150,
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
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SvgPicture.asset(
                imageUrl,
                width: 35,
                height: 28,
              ),
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w500,
                    color: textcolor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Text(
                  title,
                  style: TextStyle(
                    color: textcolor,
                    fontSize: 24.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
