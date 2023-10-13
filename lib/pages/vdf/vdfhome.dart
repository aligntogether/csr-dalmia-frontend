import 'package:dalmia/pages/vdf/addhouse.dart';
import 'package:dalmia/pages/vdf/dash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: AppBar(
            titleSpacing: 20,
            backgroundColor: Colors.white,
            title: Image(image: AssetImage('images/icon.jpg')),
            automaticallyImplyLeading: false,
            actions: <Widget>[
              IconButton(
                iconSize: 30,
                onPressed: () {
                  // Toggle the drawer
                },
                icon: Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
              ),
            ],
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(50),
              child: Container(
                padding: EdgeInsets.only(left: 30, bottom: 10),
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
            if (_selectedIndex == 1) _buildDrawer1(),

            if (_selectedIndex == 2) _buildDrawer2()
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildTabItem(Icons.dashboard_customize_outlined, "Dashboard", 0),
              buildTabItem(Icons.home_sharp, "Home", 1),
              buildTabItem(Icons.streetview_outlined, "Streets", 2),
              buildTabItem(Icons.drafts_outlined, "Interventions", 3),
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

  // Widget _buildTabContent(int index) {
  //   switch (index) {
  //     case 0:
  //       return DashTab();
  //     case 1:
  //       return HomeTab();
  //     case 2:
  //       return StreetTab();
  //     case 3:
  //       return IntervantionTab();
  //     default:
  //       return Container();
  //   }
  // }

  Widget _buildDrawer1() {
    return Positioned.fill(
      child: GestureDetector(
        onTap: () {
          // Close the drawer when tapping outside
        },
        child: Container(
          color: Colors.black.withOpacity(0.3),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height / 3,
              color: Colors.white,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.add_circle_outline),
                      title: Text('Add a Household'),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => MyForm(),
                          ),
                        );
                        // Handle item 1 click
                        // Close the drawer
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.timer_sharp),
                      title: Text('Update Household Details'),
                      onTap: () {
                        // Handle item 2 click
                        // Close the drawer
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.note_alt_rounded),
                      title: Text('View Drafts'),
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

  Widget _buildDrawer2() {
    return Positioned.fill(
      child: GestureDetector(
        onTap: () {
          // Close the drawer when tapping outside
        },
        child: Container(
          color: Colors.black.withOpacity(0.3),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height / 3,
              color: Colors.white,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.add),
                      title: Text('All Streets'),
                      onTap: () {
                        // Handle item 1 click
                        // Close the drawer
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.edit),
                      title: Text('Add a Streets'),
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

// class DashTab extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text("Dashboard Tab Content"),
//     );
//   }
// }

class IntervantionTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Interventions Tab Content'),
    );
  }
}
