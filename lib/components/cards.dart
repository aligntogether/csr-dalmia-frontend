import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;
  final Color bg;
  final Color textcolor;

  CustomCard({
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.bg,
    required this.textcolor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 160,
      child: Card(
        color: bg,
        // elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 10),
                height: 30.0,
                width: 30.0, // Adjust the image height as needed

                decoration: BoxDecoration(
                  image: DecorationImage(
                    image:
                        AssetImage(imageUrl), // or AssetImage for local image
                    fit: BoxFit.contain, // You can adjust the BoxFit as needed
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    color: textcolor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: TextStyle(
                    color: textcolor,
                    fontSize: 20.0,
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
