import 'dart:math';

import 'package:dalmia/components/reportappbar.dart';
import 'package:dalmia/components/reportpop.dart';

import 'package:dalmia/pages/vdf/Reports/hhidform.dart';
import 'package:dalmia/pages/vdf/household/addhouse.dart';
import 'package:dalmia/pages/vdf/street/Addstreet.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';

class Cumulative extends StatefulWidget {
  const Cumulative({super.key});

  @override
  State<Cumulative> createState() => _CumulativeState();
}

class _CumulativeState extends State<Cumulative> {
  String? selectedPanchayat;
  String? selectedVillage;
  int _selectedpanchayatindex = 0;
  int _selectedvillagetindex = 0;
  int? selectedRadio;
  int _selectedIndex = 0; // Track the currently selected tab index

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Random random = Random();
    return SafeArea(
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: reportappbar(
            heading: 'Report',
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                    TextButton.icon(
                        style: TextButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 85, 164, 228),
                            foregroundColor: Colors.white),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return ReportPopupWidget(context);
                            },
                          );
                        },
                        icon: const Icon(Icons.folder_outlined),
                        label: const Text(
                          'View other Reports',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        )),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    const Text(
                      'Cumulative Household Details',
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Container(
                      child: () {
                        if (selectedPanchayat ==
                            'Panchayat ${_selectedpanchayatindex + 1}') {
                          return villagetab(random);
                        } else if (selectedVillage ==
                                'Village ${_selectedvillagetindex + 1}' &&
                            selectedPanchayat == '0') {
                          return streettab(random);
                        } else {
                          return panchayattab(random);
                        }
                      }(),
                    )
                  ],
                )
              ],
            ),
          ),
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

  Center panchayattab(Random random) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('<Location name>'),
          const SizedBox(
            height: 10,
          ),
          const Text('Panchayats wise report'),
          const SizedBox(
            height: 10,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowColor:
                  MaterialStateColor.resolveWith((states) => Colors.blue),
              dividerThickness: 2,
              columnSpacing: 15,
              columns: const <DataColumn>[
                DataColumn(
                  label: Text(
                    'Panchayat Name',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Income follow up Overdue',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Number of selected HHs without intervention',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'No. of Interventions started but not completed',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
              rows: List<DataRow>.generate(
                10,
                (index) {
                  return DataRow(
                    color: MaterialStateColor.resolveWith((states) {
                      // Alternating row colors
                      return index.isOdd ? Colors.lightBlue[50]! : Colors.white;
                    }),
                    cells: <DataCell>[
                      DataCell(
                        InkWell(
                          onTap: () {
                            setState(() {
                              selectedPanchayat = 'Panchayat ${index + 1}';
                              _selectedpanchayatindex = index;
                              // _selectedVillageindex = index;

                              // selectedVillage =
                              //     'Village ${_selectedVillageindex + 1}';
                            });
                          },
                          child: Text(
                            'Panchayat ${index + 1}',
                            style: const TextStyle(
                                color: CustomColorTheme.iconColor,
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      DataCell(Text(
                        '${random.nextInt(100)}',
                      )),
                      DataCell(Text('${random.nextInt(100)}')),
                      DataCell(Text('${random.nextInt(100)}')),
                    ],
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget villagetab(Random random) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(selectedPanchayat!),
          const Text('Village wise report'),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowColor:
                  MaterialStateColor.resolveWith((states) => Colors.blue),
              dividerThickness: 2,
              columnSpacing: 15,
              columns: const <DataColumn>[
                DataColumn(
                  label: Text(
                    'Village Name',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Income follow up Overdue',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Number of selected HHs without intervention',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'No. of Interventions started but not completed',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
              rows: List<DataRow>.generate(
                10,
                (index) {
                  return DataRow(
                    color: MaterialStateColor.resolveWith((states) {
                      // Alternating row colors
                      return index.isOdd ? Colors.lightBlue[50]! : Colors.white;
                    }),
                    cells: <DataCell>[
                      DataCell(
                        InkWell(
                          onTap: () {
                            setState(() {
                              selectedVillage = 'Village ${index + 1}';
                              _selectedvillagetindex = index;
                              selectedPanchayat = '0';
                              // _selectedVillageindex = index;

                              // selectedVillage =
                              //     'Village ${_selectedVillageindex + 1}';
                            });
                          },
                          child: Text(
                            'Village ${index + 1}',
                            style: const TextStyle(
                              color: CustomColorTheme.iconColor,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      DataCell(Text(
                        '${random.nextInt(100)}',
                      )),
                      DataCell(Text('${random.nextInt(100)}')),
                      DataCell(Text('${random.nextInt(100)}')),
                    ],
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget streettab(Random random) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(selectedVillage!),
          const Text('Street wise report'),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowColor:
                  MaterialStateColor.resolveWith((states) => Colors.blue),
              dividerThickness: 2,
              columnSpacing: 15,
              columns: const <DataColumn>[
                DataColumn(
                  label: Text(
                    'Street Name',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Income follow up Overdue',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Number of selected HHs without intervention',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'No. of Interventions started but not completed',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
              rows: List<DataRow>.generate(
                10,
                (index) {
                  return DataRow(
                    color: MaterialStateColor.resolveWith((states) {
                      // Alternating row colors
                      return index.isOdd ? Colors.lightBlue[50]! : Colors.white;
                    }),
                    cells: <DataCell>[
                      DataCell(
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const HhidForm(),
                              ),
                            );
                          },
                          child: Text(
                            'Street ${index + 1}',
                            style: const TextStyle(
                              color: CustomColorTheme.iconColor,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      DataCell(Text(
                        '${random.nextInt(100)}',
                      )),
                      DataCell(Text('${random.nextInt(100)}')),
                      DataCell(Text('${random.nextInt(100)}')),
                    ],
                  );
                },
              ),
            ),
          )
        ],
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
