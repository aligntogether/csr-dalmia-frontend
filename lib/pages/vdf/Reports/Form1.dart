import 'package:dalmia/pages/vdf/Reports/Leverwise.dart';
import 'package:dalmia/pages/vdf/household/addhouse.dart';
import 'package:dalmia/pages/vdf/street/Addstreet.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class Form1 extends StatefulWidget {
  const Form1({Key? key}) : super(key: key);

  @override
  State<Form1> createState() => _Form1State();
}

class _Form1State extends State<Form1> {
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
    final List<int> householdList =
        List.generate(10, (index) => random.nextInt(100));
    final List<int> populationList =
        List.generate(10, (index) => random.nextInt(100));

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
                Center(
                  child: Column(
                    children: [
                      const Text('Form 1 Gram Parivartan'),
                      const SizedBox(
                        height: 20,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          headingRowColor: MaterialStateColor.resolveWith(
                              (states) => Colors.blue),
                          columns: const <DataColumn>[
                            DataColumn(
                              label: Text(
                                'Panchayat',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Village',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Household',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Population',
                                style: TextStyle(color: Colors.white),
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
                                          ? Colors.lightBlue[50] as Color
                                          : Colors.white as Color;
                                    },
                                  ),
                                  cells: <DataCell>[
                                    DataCell(Text('Panchayat $index')),
                                    DataCell(Text('Village $index')),
                                    DataCell(Text('${householdList[index]}')),
                                    DataCell(Text('${populationList[index]}')),
                                  ],
                                );
                              } else {
                                final totalHouseholds =
                                    householdList.reduce((a, b) => a + b);
                                final totalPopulation =
                                    populationList.reduce((a, b) => a + b);
                                return DataRow(
                                  cells: <DataCell>[
                                    const DataCell(Text('')),
                                    const DataCell(Text(
                                      'Total',
                                      style: const TextStyle(
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
                      )
                    ],
                  ),
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
                      const Text('View other Reports'),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const Icon(Icons.close),
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
                        _onTabTapped(0); // Navigate to the corresponding tab
                      } else if (selectedRadio == 2) {
                        // Navigate to the corresponding tab
                      } else if (selectedRadio == 3) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Leverwise(),
                          ),
                        ); // Navigate to the corresponding tab
                      } else if (selectedRadio == 4) {
                        _onTabTapped(3); // Navigate to the corresponding tab
                      } else if (selectedRadio == 5) {
                        _onTabTapped(4); // Navigate to the corresponding tab
                      } else if (selectedRadio == 6) {
                        _onTabTapped(5); // Navigate to the corresponding tab
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
