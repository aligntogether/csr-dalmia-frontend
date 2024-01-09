import 'package:dalmia/Constants/constants.dart';
import 'package:dalmia/common/common.dart';
import 'package:dalmia/helper/sharedpref.dart';
import 'package:dalmia/pages/vdf/Draft/draft.dart';
import 'package:dalmia/pages/vdf/Reports/updateinter.dart';
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
  bool isMenuOpen = false;

  void _toggleMenu() {
    setState(() {
      isMenuOpen = !isMenuOpen;
    });
  }

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
@override
  void initState() {
    super.initState();

    SharedPrefHelper.getSharedPref(USER_NAME_SHAREDPREF_KEY, context, false)
        .then((value) => setState(() {
              value == '' ? name = 'user' : name = value;
            }));
    ;
  }

  String name = "";
  int selectedIndex = 0;
  bool toggle = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: PreferredSize(
        preferredSize: isMenuOpen ? Size.fromHeight(150) : Size.fromHeight(100),
        child: Stack(
          children: [
            AppBar(
              elevation: 0,
              scrolledUnderElevation: 0,
              titleSpacing: 20,
              backgroundColor: Colors.white,
              title: Image(image: AssetImage('images/icon.jpg')),
              centerTitle: false,
              automaticallyImplyLeading: false,
              actions: <Widget>[
                CircleAvatar(
                  backgroundColor: CustomColorTheme.primaryColor,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.notifications_none_outlined,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                IconButton(
                  iconSize: 30,
                  onPressed: () {
                    _toggleMenu();
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
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 0,
                        blurRadius: 4,
                        offset: Offset(0, 4), // changes position of shadow
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.only(left: 30, bottom: 10),
                  alignment: Alignment.topLeft,
                  // color: Colors.white,
                  child: Text(
                    'Welcome $name!',
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            if (isMenuOpen) navmenu(context, _toggleMenu),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: DashTab(),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          // color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0,
              blurRadius: 10,
              offset: Offset(4, 0), // changes position of shadow
            ),
          ],
        ),
        child: BottomAppBar(
          color: Colors.white,
          // elevation: 10,
          child: SizedBox(
            height: 67,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomTabItem(
                  imagePath: 'images/fill_dash.svg',
                  label: "Dashboard",
                  index: 0,
                  selectedIndex: 0,
                  onTabTapped: _onTabTapped,
                ),
                CustomTabItem(
                  imagePath: 'images/Household_Outline.svg',
                  label: "Add Household",
                  index: 1,
                  selectedIndex: 0,
                  onTabTapped: _onTabTapped,
                ),
                CustomTabItem(
                  imagePath: 'images/Street_Outline.svg',
                  label: "Add Street",
                  index: 2,
                  selectedIndex: 0,
                  onTabTapped: _onTabTapped,
                ),
                CustomTabItem(
                  imagePath: 'images/Drafts_Outline.svg',
                  label: "Drafts",
                  index: 3,
                  selectedIndex: 0,
                  onTabTapped: _onTabTapped,
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
