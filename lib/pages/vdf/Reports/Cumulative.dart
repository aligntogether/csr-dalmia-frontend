import 'dart:math';

import 'package:dalmia/pages/vdf/Reports/Business.dart';
import 'package:dalmia/pages/vdf/Reports/Form1.dart';
import 'package:dalmia/pages/vdf/Reports/Livehood.dart';
import 'package:dalmia/pages/vdf/Reports/Top20.dart';
import 'package:dalmia/pages/vdf/Reports/hhidform.dart';
import 'package:dalmia/pages/vdf/household/addhouse.dart';
import 'package:dalmia/pages/vdf/street/Addstreet.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';

class Cumulative extends StatefulWidget {
  const Cumulative({Key? key}) : super(key: key);

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
          child: Reportappbar(),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
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
                          _reportpopup(context);
                        },
                        icon: Icon(Icons.folder_outlined),
                        label: Text(
                          'view other reports',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    Text(
                      'Cumulative Household Details',
                    ),
                    SizedBox(
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
          Text('<Location name>'),
          SizedBox(
            height: 10,
          ),
          Text('Panchayats wise report'),
          SizedBox(
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
                            style: TextStyle(
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
          Text('Village wise report'),
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
                            style: TextStyle(
                              color: Colors.orange,
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
          Text('Street wise report'),
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
                                builder: (context) => HhidForm(),
                              ),
                            );
                          },
                          child: Text(
                            'Street ${index + 1}',
                            style: TextStyle(
                              color: Colors.orange,
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

  void _reportpopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return AlertDialog(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('View other Reports'),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(Icons.close),
                      ),
                    ],
                  ),
                  RadioListTile<int>(
                    title: const Text(
                      'Form 1 Gram Parivartan',
                    ),
                    value: 1,
                    groupValue: selectedRadio,
                    onChanged: (value) {
                      setState(() {
                        selectedRadio = value;
                      });
                    },
                  ),
                  RadioListTile<int>(
                    title: const Text(
                      'Cumulative Household data',
                    ),
                    value: 2,
                    groupValue: selectedRadio,
                    onChanged: (value) {
                      setState(() {
                        selectedRadio = value;
                      });
                    },
                  ),
                  RadioListTile<int>(
                    title: const Text(
                      'Leverwise number of interventions',
                    ),
                    value: 3,
                    groupValue: selectedRadio,
                    onChanged: (value) {
                      setState(() {
                        selectedRadio = value;
                      });
                    },
                  ),
                  RadioListTile<int>(
                    title: const Text('Top 20 additional income HH'),
                    value: 4,
                    groupValue: selectedRadio,
                    onChanged: (value) {
                      setState(() {
                        selectedRadio = value;
                      });
                    },
                  ),
                  RadioListTile<int>(
                    title: const Text('List of Business Plans engaged'),
                    value: 5,
                    groupValue: selectedRadio,
                    onChanged: (value) {
                      setState(() {
                        selectedRadio = value;
                      });
                    },
                  ),
                  RadioListTile<int>(
                    title: const Text('Livelihood Funds Utilization'),
                    value: 6,
                    groupValue: selectedRadio,
                    onChanged: (value) {
                      setState(() {
                        selectedRadio = value;
                      });
                    },
                  ),
                ],
              ),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[900]),
                    onPressed: () {
                      if (selectedRadio == 1) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Form1(),
                          ),
                        );
                      } else if (selectedRadio == 2) {
                        _onTabTapped(1); // Navigate to the corresponding tab
                      } else if (selectedRadio == 3) {
                        _onTabTapped(2); // Navigate to the corresponding tab
                      } else if (selectedRadio == 4) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Top20(),
                          ),
                        );
                        // Navigate to the corresponding tab
                      } else if (selectedRadio == 5) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => BusinessPlan(),
                          ),
                        );
                        // Navigate to the corresponding tab
                      } else if (selectedRadio == 6) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => LivehoodPlan(),
                          ),
                        ); // Navigate to the corresponding tab
                      }
                    },
                    child: const Text('View Reports'),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class Reportappbar extends StatelessWidget {
  const Reportappbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 20,
      backgroundColor: Colors.white,
      title: const Image(image: AssetImage('images/icon.jpg')),
      automaticallyImplyLeading: false,
      actions: <Widget>[
        CircleAvatar(
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_none_outlined,
              // color: Colors.blue,
            ),
          ),
        ),
        const SizedBox(width: 20),
        IconButton(
          iconSize: 30,
          onPressed: () {
            // _openDrawer();
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
          alignment: Alignment.topCenter,
          color: Colors.white,
          child: const Text(
            'Reports',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
