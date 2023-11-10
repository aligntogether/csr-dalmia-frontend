import 'package:dalmia/common/bottombar.dart';
import 'package:dalmia/components/reportappbar.dart';
import 'package:dalmia/components/reportpop.dart';
import 'package:dalmia/pages/vdf/Draft/draft.dart';
import 'package:dalmia/pages/vdf/Reports/home.dart';

import 'package:dalmia/pages/vdf/household/addhouse.dart';
import 'package:dalmia/pages/vdf/street/Addstreet.dart';
import 'package:dalmia/pages/vdf/vdfhome.dart';
import 'package:dalmia/theme.dart';

import 'package:flutter/material.dart';
import 'dart:math';

class Form1 extends StatefulWidget {
  const Form1({super.key});

  @override
  State<Form1> createState() => _Form1State();
}

class _Form1State extends State<Form1> {
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

  @override
  Widget build(BuildContext context) {
    final Random random = Random();
    final List<int> householdList =
        List.generate(10, (index) => random.nextInt(100));
    final List<int> populationList =
        List.generate(10, (index) => random.nextInt(100));

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(100),
            child: ReportAppBar(
              heading: 'Reports',
            )),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                    Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: viewotherbtn(context)),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    const Text(
                      'Form 1 Gram Parivartan',
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
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 5,
                        child: DataTable(
                          decoration: const BoxDecoration(
                            color: Color(0xFF008CD3),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                          ),
                          // headingRowColor: MaterialStateColor.resolveWith(
                          //     (states) => Color(0xFF008CD3)),
                          columns: const <DataColumn>[
                            DataColumn(
                              label: Text(
                                'Panchayat',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: CustomFontTheme.headingwt),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Village',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: CustomFontTheme.headingwt),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Household',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: CustomFontTheme.headingwt),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Population',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: CustomFontTheme.headingwt),
                              ),
                            ),
                          ],
                          rows: List<DataRow>.generate(
                            11,
                            (index) {
                              if (index < 10) {
                                return DataRow(
                                  color: MaterialStateColor.resolveWith(
                                    (states) {
                                      // Alternating row colors
                                      return index.isOdd
                                          ? Colors.blue.shade50
                                          : Colors.white;
                                    },
                                  ),
                                  cells: <DataCell>[
                                    DataCell(Text(
                                      'Panchayat $index',
                                      style: TextStyle(fontSize: 14),
                                    )),
                                    DataCell(Text('Village $index',
                                        style: TextStyle(fontSize: 14))),
                                    DataCell(Text('${householdList[index]}',
                                        style: TextStyle(fontSize: 14))),
                                    DataCell(Text('${populationList[index]}',
                                        style: TextStyle(fontSize: 14))),
                                  ],
                                );
                              } else {
                                final totalHouseholds =
                                    householdList.reduce((a, b) => a + b);
                                final totalPopulation =
                                    populationList.reduce((a, b) => a + b);
                                return DataRow(
                                  color: MaterialStateColor.resolveWith(
                                      (states) => Colors.white),
                                  cells: <DataCell>[
                                    const DataCell(Text('')),
                                    const DataCell(Text(
                                      'Total',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                                    DataCell(
                                      Text(
                                        '$totalHouseholds',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        '$totalPopulation',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    )
                  ],
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

  Widget buildTabItem(IconData icon, String label, int index) {
    final isSelected = index == 0;
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
}
