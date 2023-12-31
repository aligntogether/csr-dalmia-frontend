import 'dart:convert';

import 'package:dalmia/common/bottombar.dart';
import 'package:dalmia/common/navmenu.dart';
import 'package:dalmia/components/reportappbar.dart';
import 'package:dalmia/components/reportpop.dart';
import 'package:dalmia/pages/vdf/Draft/draft.dart';
import 'package:dalmia/pages/vdf/Reports/home.dart';
import 'package:http/http.dart' as http;

import 'package:dalmia/pages/vdf/household/addhouse.dart';
import 'package:dalmia/pages/vdf/street/Addstreet.dart';
import 'package:dalmia/pages/vdf/vdfhome.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class LivehoodPlan extends StatefulWidget {
  const LivehoodPlan({Key? key}) : super(key: key);

  @override
  State<LivehoodPlan> createState() => _LivehoodPlanState();
}

class _LivehoodPlanState extends State<LivehoodPlan> {
  bool isreportMenuOpen = false;
  void _toggleMenu() {
    setState(() {
      isreportMenuOpen = !isreportMenuOpen;
    });
  }

  List<Map<String, dynamic>> livehoodData = []; // List to store API data

  @override
  void initState() {
    super.initState();
    fetchLivehoodData(); // Call the method to fetch API data when the page initializes
  }

  Future<void> fetchLivehoodData() async {
    try {
      final response = await http.get(
        Uri.parse('$base/get-livelihood-funds-utilization?vdfId=10001'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);

        setState(() {
          livehoodData = [
            {
              'allocated': jsonData['resp_body']['allocated'] ?? 0,
              'spent': jsonData['resp_body']['spent'] ?? 0,
              'balance': jsonData['resp_body']['balance'] ?? 0,
            },
          ];
        });
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  int? selectedRadio;
  int selectedIndex = 0; // Track the currently selected tab index

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
          builder: (context) => Draft(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // ;
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(isreportMenuOpen ? 150 : 100),
          child: Stack(
            children: [
              AppBar(
                titleSpacing: 20,
                backgroundColor: Colors.white,
                title: const Image(image: AssetImage('images/icon.jpg')),
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
                  const SizedBox(width: 20),
                  IconButton(
                    iconSize: 30,
                    onPressed: () {
                      _toggleMenu();
                    },
                    icon: const Icon(Icons.menu,
                        color: CustomColorTheme
                            .primaryColor // Update with your color
                        ),
                  ),
                ],
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(50),
                  child: Container(
                    padding: const EdgeInsets.only(left: 30, bottom: 10),
                    alignment: Alignment.topCenter,
                    color: Colors.white,
                    child: Text(
                      'Reports',
                      style: const TextStyle(
                        fontSize: CustomFontTheme.headingSize,

                        // Adjust the font size
                        fontWeight:
                            CustomFontTheme.headingwt, // Adjust the font weight
                      ),
                    ),
                  ),
                ),
              ),
              if (isreportMenuOpen) navmenu(context, _toggleMenu),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Row(
                        children: [
                          Icon(
                            Icons.keyboard_arrow_left_outlined,
                            color: Colors.black,
                          ),
                          Text(
                            'Back',
                            style: TextStyle(color: Colors.black),
                          )
                        ],
                      ),
                    ),
                    viewotherbtn(context),
                  ],
                ),
                const SizedBox(height: 20),
                Center(
                  child: Column(
                    children: [
                      const Text(
                        ' Livelihood Funds Utilization',
                        style: TextStyle(
                            fontSize: CustomFontTheme.textSize,
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: DataTable(
                            dividerThickness: 00,
                            headingRowHeight: 0.0,
                            columns: const <DataColumn>[
                              DataColumn(label: Text('Details')),
                              DataColumn(label: Text('Values')),
                            ],
                            rows: livehoodData.map<DataRow>((data) {
                                  return DataRow(
                                    color: MaterialStateColor.resolveWith(
                                      (states) {
                                        return livehoodData.indexOf(data).isOdd
                                            ? Colors.lightBlue[50] as Color
                                            : Colors.white;
                                      },
                                    ),
                                    cells: <DataCell>[
                                      DataCell(Text('Allocated (Rs.)')),
                                      DataCell(Text(
                                          data['allocated']?.toString() ?? '')),
                                    ],
                                  );
                                }).toList() +
                                livehoodData.map<DataRow>((data) {
                                  return DataRow(
                                    color: MaterialStateColor.resolveWith(
                                      (states) {
                                        return Colors.lightBlue[50] as Color;
                                      },
                                    ),
                                    cells: <DataCell>[
                                      DataCell(Text('Spent (Rs.)')),
                                      DataCell(Text(
                                          data['spent']?.toString() ?? '')),
                                    ],
                                  );
                                }).toList() +
                                livehoodData.map<DataRow>((data) {
                                  return DataRow(
                                    color: MaterialStateColor.resolveWith(
                                      (states) {
                                        return Colors.white as Color;
                                      },
                                    ),
                                    cells: <DataCell>[
                                      DataCell(Text('Balance (Rs.)')),
                                      DataCell(Text(
                                          data['balance']?.toString() ?? '')),
                                    ],
                                  );
                                }).toList(),
                          ),
                        ),
                      ),
                      // const Text('Last updated on:12/07/23')
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 10,
          child: SizedBox(
            height: 67,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomTabItem(
                  imagePath: 'images/Dashboard_Outline.svg',
                  label: "Dashboard",
                  index: 0,
                  selectedIndex: 5,
                  onTabTapped: _onTabTapped,
                ),
                CustomTabItem(
                  imagePath: 'images/Household_Outline.svg',
                  label: "Add Household",
                  index: 1,
                  selectedIndex: 5,
                  onTabTapped: _onTabTapped,
                ),
                CustomTabItem(
                  imagePath: 'images/Street_Outline.svg',
                  label: "Add Street",
                  index: 2,
                  selectedIndex: 5,
                  onTabTapped: _onTabTapped,
                ),
                CustomTabItem(
                  imagePath: 'images/Drafts_Outline.svg',
                  label: "Drafts",
                  index: 3,
                  selectedIndex: 5,
                  onTabTapped: _onTabTapped,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
