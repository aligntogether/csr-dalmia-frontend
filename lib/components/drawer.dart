import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final List<DrawerItem> items;

  CustomDrawer({required this.items});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: GestureDetector(
        onTap: () {
          _toggleDrawer(); // Close the drawer when tapping outside
        },
        child: Container(
          color: Colors.black
              .withOpacity(0.3), // Semi-transparent black background
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height /
                  3, // 1/3 of the screen height
              color: Colors.white,
              child: SingleChildScrollView(
                child: Column(
                  children: items.map((item) {
                    return ListTile(
                      leading: Icon(item.icon), // Dynamic icon
                      title: Text(item.text), // Dynamic text
                      onTap: () {
                        // Handle item click
                        item.onTap();
                        _toggleDrawer(); // Close the drawer
                      },
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _toggleDrawer() {
    // Implement your drawer toggle logic here
  }
}

class DrawerItem {
  final IconData icon;
  final String text;
  final Function onTap;

  DrawerItem({required this.icon, required this.text, required this.onTap});
}
