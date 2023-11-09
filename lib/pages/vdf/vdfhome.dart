import 'package:dalmia/common/common.dart';

import 'package:dalmia/pages/vdf/Draft/draft.dart';

import 'package:dalmia/pages/vdf/household/addhouse.dart';
import 'package:dalmia/pages/vdf/dash.dart';
import 'package:dalmia/pages/vdf/street/Addstreet.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: VdfHome(),
    );
  }
}

class VdfHome extends StatefulWidget {
  const VdfHome({Key? key}) : super(key: key);

  @override
  _VdfHomeState createState() => _VdfHomeState();
}

class _VdfHomeState extends State<VdfHome> {
  void _onTabTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
    if (selectedIndex == 0) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const VdfHome(),
        ),
      );
    } else if (selectedIndex == 1) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => MyForm(),
        ),
      );
    } else if (selectedIndex == 2) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => AddStreet(),
        ),
      );
    } else if (selectedIndex == 3) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const Draft(),
        ),
      );
    }
  }

  int selectedIndex = 0;
  bool toggle = false;

  // void _openDrawer() {
  //   setState(() {
  //     _toggle = true;
  //   });
  // }

  // void _closeDrawer() {
  //   setState(() {
  //     _toggle = false;
  //   });
  // }
  void _openDrawer() {
    setState(() {
      toggle = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBar(
          titleSpacing: 20,
          backgroundColor: Colors.white,
          title: const Image(image: AssetImage('images/icon.jpg')),
          automaticallyImplyLeading: false,
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 12.0,
              ),
            ),
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
                _openDrawer();
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
              alignment: Alignment.topLeft,
              color: Colors.white,
              child: Text(
                'Welcome Suresh!',
                style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Center(child: DashTab()),
          // Add the drawer as a positioned widget
          if (toggle == true) const DrawerWidget()

          // if (_selectedIndex == 2) _buildDrawer2()
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 10,
        child: SizedBox(
          height: 67,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomTabItem(
                imagePath: 'images/fill_dash.svg',
                label: "Dashboard",
                index: 0,
                selectedIndex: selectedIndex,
                onTabTapped: _onTabTapped,
              ),
              CustomTabItem(
                imagePath: 'images/Household_Outline.svg',
                label: "Add Household",
                index: 1,
                selectedIndex: selectedIndex,
                onTabTapped: _onTabTapped,
              ),
              CustomTabItem(
                imagePath: 'images/Street_Outline.svg',
                label: "Add Street",
                index: 2,
                selectedIndex: selectedIndex,
                onTabTapped: _onTabTapped,
              ),
              CustomTabItem(
                imagePath: 'images/Drafts_Outline.svg',
                label: "Drafts",
                index: 3,
                selectedIndex: selectedIndex,
                onTabTapped: _onTabTapped,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
