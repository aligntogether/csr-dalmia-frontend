import 'package:dalmia/pages/AddStreet.dart';
import 'package:dalmia/pages/vdf/household/addhouse.dart';
import 'package:dalmia/pages/vdf/dash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
              IconButton(
                iconSize: 30,
                onPressed: () {
                  _openDrawer();
                },
                icon: const Icon(
                  Icons.menu,
                  color: Colors.black,
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
                    fontSize: 20,
                  ),
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
              buildTabItem(Icons.dashboard_customize_outlined, "Dashboard", 0),
              buildTabItem(Icons.home_sharp, "Add Household", 1),
              buildTabItem(Icons.streetview_outlined, "Add Street", 2),
              buildTabItem(Icons.drafts_outlined, "Drafts", 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTabItem(IconData icon, String label, int index) {
    final isSelected = index == _selectedIndex;
    final color = isSelected ? Colors.blue : Colors.black;

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
          Icon(
            icon,
            color: color,
          ),
          Text(
            label,
            style: TextStyle(
              color: color,
            ),
          ),
        ],
      ),
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
              // height: MediaQuery.of(context).size.height / 3,
              color: Colors.white,
              child: SingleChildScrollView(
                child: Column(
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
                      leading: const Icon(Icons.add_circle_outline),
                      title: const Text('Reports'),
                      onTap: () {
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: (context) => MyForm(),
                        //   ),
                        // );
                        // Handle item 1 click
                        // Close the drawer
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.timer_sharp),
                      title: const Text('Logout'),
                      onTap: () {
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

class IntervantionTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Interventions Tab Content'),
    );
  }
}
