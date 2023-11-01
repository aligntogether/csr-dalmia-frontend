import 'package:dalmia/pages/login.dart';
import 'package:dalmia/pages/vdf/Reports/Home.dart';
import 'package:dalmia/pages/vdf/household/addhouse.dart';
import 'package:dalmia/pages/vdf/dash.dart';
import 'package:dalmia/pages/vdf/street/Addstreet.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
  int _selectedIndex = 0; // Track the currently selected tab index

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  bool _toggle = false;

  void _openDrawer() {
    setState(() {
      _toggle = true;
    });
  }

  void _closeDrawer() {
    setState(() {
      _toggle = false;
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
              CircleAvatar(
                backgroundColor: CustomColorTheme.primaryColor,
                child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.notifications_none_outlined,
                      color: Colors.white,

                      // color: Colors.blue,
                    )),
              ),
              SizedBox(
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
            if (_toggle == true) _buildDrawer1()

            // if (_selectedIndex == 2) _buildDrawer2()
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildTabItem('images/Dashboard_Outline.svg', "Dashboard", 0),
              buildTabItem('images/Household_Outline.svg', "Add Household", 1),
              buildTabItem('images/Street_Outline.svg', "Add Street", 2),
              buildTabItem('images/Drafts_Outline.svg', "Drafts", 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTabItem(String imagePath, String label, int index) {
    final isSelected = index == 0;
    final color = isSelected ? CustomColorTheme.primaryColor : Colors.black;

    return InkWell(
      onTap: () {
        _onTabTapped(index);
        if (index == 1) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => MyForm(),
            ),
          );
        }
        if (index == 2) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddStreet(),
            ),
          );
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            imagePath,
            color: isSelected ? CustomColorTheme.primaryColor : Colors.black,
            // width: 24, // Adjust the width as needed
            // height: 24, // Adjust the height as needed
          ),
          Text(
            label,
            style: TextStyle(
                color: color, fontSize: 15, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: SizedBox(
            width: 283,
            height: 80,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(Icons.close),
                ),
                Text(
                  'Are you sure you want to logout of the application?',
                  style: TextStyle(
                    fontSize: 16,
                    // fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 157,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    side: const BorderSide(),
                    backgroundColor: CustomColorTheme.primaryColor,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const Login(),
                      ),
                    );
                    // Perform actions when 'Yes' is clicked
                  },
                  child: const Text('Yes'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDrawer1() {
    return Positioned.fill(
      child: GestureDetector(
        onTap: () {
          _closeDrawer();
          // Close the drawer when tapping outside
        },
        child: Container(
          color: Colors.black.withOpacity(0.3),
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              // height: MediaQuery.of(context).size.height / 3,
              color: Colors.white,
              child: SingleChildScrollView(
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(Icons.close),
                      onTap: () {
                        _closeDrawer();
                        // Handle item 1 click
                        // Close the drawer
                      },
                    ),
                    ListTile(
                      leading: SvgPicture.asset(
                        'images/report.svg',

                        // width: 24, // Adjust the width as needed
                        // height: 24, // Adjust the height as needed
                      ),
                      title: const Text('Reports'),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => HomeReport(),
                          ),
                        );
                        // Handle item 1 click
                        // Close the drawer
                      },
                    ),
                    Divider(
                      color: Colors.grey, // Add your desired color for the line
                      thickness: 1, // Add the desired thickness for the line
                    ),
                    ListTile(
                      leading: SvgPicture.asset(
                        'images/logout.svg',

                        // width: 24, // Adjust the width as needed
                        // height: 24, // Adjust the height as needed
                      ),
                      title: const Text('Logout'),
                      onTap: () {
                        _showConfirmationDialog(context);
                        // Handle item 2 click
                        // Close the drawer
                      },
                    ),

                    // Add more items as needed
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
