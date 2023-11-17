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

class Leverwise extends StatefulWidget {
  const Leverwise({super.key});

  @override
  State<Leverwise> createState() => _LeverwiseState();
}

class _LeverwiseState extends State<Leverwise> {
  bool isreportMenuOpen = false;
  void _toggleMenu() {
    setState(() {
      isreportMenuOpen = !isreportMenuOpen;
    });
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
          builder: (context) => const Draft(),
        ),
      );
    }
  }

  List<Map<String, dynamic>> leverData = []; // List to store API data

  @override
  void initState() {
    super.initState();
    fetchleverData(); // Call the method to fetch API data when the page initializes
  }

  Future<void> fetchleverData() async {
    try {
      final response = await http.get(
        Uri.parse('$base/get-lever-wise-interventions?vdfId=10001'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);

        setState(() {
          leverData = [
            for (var entry in jsonData['resp_body'].entries)
              {
                'leverName': entry.key,
                'noOfHouseholds': entry.value['noOfHouseholds'],
                'noOfInterventions': entry.value['noOfInterventions'],
                'annualIncomeReported': entry.value['annualIncomeReported'],
                'averageIncomePerIntervention':
                    entry.value['averageIncomePerIntervention'],
              }
          ];
        });
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    child: const Text(
                      'Reports',
                      style: TextStyle(
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
                        ' Lever wise Interventions (income in Lakhs)',
                        style: TextStyle(
                            fontSize: CustomFontTheme.textSize,
                            fontWeight: CustomFontTheme.headingwt),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            dividerThickness: 00,
                            // border: TableBorder(
                            //     borderRadius:
                            //         BorderRadius.all(Radius.circular(10))),
                            decoration: const BoxDecoration(
                              color: Color(0xFF008CD3),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                            ),
                            columns: const [
                              DataColumn(
                                label: Text(
                                  'Levers',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'NO. of HH',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'NO. of int.',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Annual Income Reported',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Avg. income/int.',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                            rows: leverData.map<DataRow>((lever) {
                              return DataRow(
                                color: MaterialStateColor.resolveWith((states) {
                                  // Alternating row colors
                                  return leverData.indexOf(lever) % 2 == 0
                                      ? Colors.lightBlue[50]!
                                      : Colors.white;
                                }),
                                cells: <DataCell>[
                                  DataCell(
                                    Text('${lever['leverName'] ?? 0}'),
                                  ),
                                  DataCell(
                                    Text('${lever['noOfHouseholds'] ?? 0}'),
                                  ),
                                  DataCell(
                                    Text('${lever['noOfInterventions'] ?? 0}'),
                                  ),
                                  DataCell(
                                    Text(
                                        '${lever['annualIncomeReported'] ?? 0}'),
                                  ),
                                  DataCell(
                                    Text(
                                        '${lever['averageIncomePerIntervention'] ?? 0}'),
                                  ),
                                ],
                              );
                            }).toList(),
                          ))
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

  // Widget buildTabItem(IconData icon, String label, int index) {
  //   final isSelected = index == 0;
  //   final color = isSelected ? Colors.blue : Colors.black;

  //   return InkWell(
  //     onTap: () {
  //       _onTabTapped(index);
  //       if (index == 1) {
  //         Navigator.of(context).push(
  //           MaterialPageRoute(
  //             builder: (context) => MyForm(),
  //           ),
  //         );
  //       }
  //       if (index == 2) {
  //         Navigator.of(context).push(
  //           MaterialPageRoute(
  //             builder: (context) => AddStreet(),
  //           ),
  //         );
  //       }
  //     },
  //     child: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         Icon(
  //           icon,
  //           color: color,
  //         ),
  //         Text(
  //           label,
  //           style: TextStyle(
  //             color: color,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
