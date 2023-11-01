import 'package:dalmia/pages/vdf/Reports/Business.dart';
import 'package:dalmia/pages/vdf/Reports/Cumulative.dart';
import 'package:dalmia/pages/vdf/Reports/Form1.dart';
import 'package:dalmia/pages/vdf/Reports/Home.dart';
import 'package:dalmia/pages/vdf/Reports/Leverwise.dart';
import 'package:dalmia/pages/vdf/Reports/Livehood.dart';
import 'package:dalmia/pages/vdf/Reports/Top20.dart';
import 'package:dalmia/pages/vdf/household/addhead.dart';
import 'package:dalmia/pages/vdf/household/addhouse.dart';
import 'package:dalmia/pages/vdf/intervention/Addinter.dart';
import 'package:dalmia/pages/vdf/street/Addstreet.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:excel/excel.dart';

import 'dart:math';

class HhidForm extends StatefulWidget {
  const HhidForm({Key? key}) : super(key: key);

  @override
  State<HhidForm> createState() => _HhidFormState();
}

class _HhidFormState extends State<HhidForm> {
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
            preferredSize: const Size.fromHeight(100), child: reportappbar()),
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
                      const Text(
                        'Cumulative Household Details',
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
                          columns: <DataColumn>[
                            DataColumn(
                              label: Text(
                                'HHID',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Selected',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Names',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Intervention planned',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Intervention completed',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Expected additional income p/a',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Actual annual income',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            DataColumn(
                              label: Row(
                                children: [
                                  Text(
                                    'Follow ups for income update',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  Row(
                                    children: [
                                      Text('int.1',
                                          style:
                                              TextStyle(color: Colors.white)),
                                      Text('int.2',
                                          style:
                                              TextStyle(color: Colors.white)),
                                      Text('int.3',
                                          style:
                                              TextStyle(color: Colors.white)),
                                      Text('int.4',
                                          style:
                                              TextStyle(color: Colors.white)),
                                      Text('int.5',
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                          headingRowColor: MaterialStateColor.resolveWith(
                              (states) => CustomColorTheme.secondaryColor),
                          rows: <DataRow>[
                            DataRow(
                              cells: <DataCell>[
                                DataCell(
                                  InkWell(
                                    onTap: () {
                                      _takeaction(context);
                                    },
                                    child: Text(
                                      'AROKSKTS001',
                                      style: const TextStyle(
                                        color: CustomColorTheme.iconColor,
                                        decoration: TextDecoration.underline,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                DataCell(Text('Yes')),
                                DataCell(Text('John Doe')),
                                DataCell(Text('Intervention 1')),
                                DataCell(Text('Yes')),
                                DataCell(Text('\$500')),
                                DataCell(Text('\$600')),
                                DataCell(Text('')),
                              ],
                            ),
                            DataRow(
                              cells: <DataCell>[
                                DataCell(
                                  InkWell(
                                    onTap: () {},
                                    child: Text(
                                      'AROKSKTS002',
                                      style: TextStyle(
                                        color: CustomColorTheme.iconColor,
                                        decoration: TextDecoration.underline,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                DataCell(Text('No')),
                                DataCell(Text('Jane Smith')),
                                DataCell(Text('Intervention 2')),
                                DataCell(Text('No')),
                                DataCell(Text('\$300')),
                                DataCell(Text('\$400')),
                                DataCell(Text('')),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              CustomColorTheme.backgroundColor),
                        ),
                        onPressed: () {},
                        child: Row(
                          children: [
                            Icon(
                              Icons.picture_as_pdf_rounded,
                              color: CustomColorTheme.primaryColor,
                            ),
                            Text(
                              'Download  Excel',
                              style: TextStyle(
                                  color: CustomColorTheme.primaryColor),
                            ),
                          ],
                        )),
                    ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              CustomColorTheme.backgroundColor),
                        ),
                        onPressed: () {},
                        child: Row(
                          children: [
                            Icon(
                              Icons.picture_as_pdf,
                              color: CustomColorTheme.primaryColor,
                            ),
                            Text(
                              'Download PDF',
                              style: TextStyle(
                                  color: CustomColorTheme.primaryColor),
                            ),
                          ],
                        )),
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
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
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
                    activeColor: CustomColorTheme.iconColor,
                    selectedTileColor: CustomColorTheme.iconColor,
                    title: Text(
                      'Form 1 Gram Parivartan',
                      style: TextStyle(
                          fontSize: CustomFontTheme.textSize,
                          fontWeight: CustomFontTheme.headingwt,
                          color: selectedRadio == 1
                              ? CustomColorTheme.iconColor
                              : CustomColorTheme.textColor),
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
                    activeColor: CustomColorTheme.iconColor,
                    selectedTileColor: CustomColorTheme.iconColor,
                    title: Text(
                      'Cumulative Household data',
                      style: TextStyle(
                          fontSize: CustomFontTheme.textSize,
                          fontWeight: CustomFontTheme.headingwt,
                          color: selectedRadio == 2
                              ? CustomColorTheme.iconColor
                              : CustomColorTheme.textColor),
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
                    activeColor: CustomColorTheme.iconColor,
                    selectedTileColor: CustomColorTheme.iconColor,
                    title: Text(
                      'Leverwise number of interventions',
                      style: TextStyle(
                          fontSize: CustomFontTheme.textSize,
                          fontWeight: CustomFontTheme.headingwt,
                          color: selectedRadio == 3
                              ? CustomColorTheme.iconColor
                              : CustomColorTheme.textColor),
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
                    activeColor: CustomColorTheme.iconColor,
                    selectedTileColor: CustomColorTheme.iconColor,
                    title: Text(
                      'Top 20 additional income HH',
                      style: TextStyle(
                          fontSize: CustomFontTheme.textSize,
                          fontWeight: CustomFontTheme.headingwt,
                          color: selectedRadio == 4
                              ? CustomColorTheme.iconColor
                              : CustomColorTheme.textColor),
                    ),
                    value: 4,
                    groupValue: selectedRadio,
                    onChanged: (value) {
                      setState(() {
                        selectedRadio = value;
                      });
                    },
                  ),
                  RadioListTile<int>(
                    activeColor: CustomColorTheme.iconColor,
                    selectedTileColor: CustomColorTheme.iconColor,
                    title: Text(
                      'List of Business Plans engaged',
                      style: TextStyle(
                          fontSize: CustomFontTheme.textSize,
                          fontWeight: CustomFontTheme.headingwt,
                          color: selectedRadio == 5
                              ? CustomColorTheme.iconColor
                              : CustomColorTheme.textColor),
                    ),
                    value: 5,
                    groupValue: selectedRadio,
                    onChanged: (value) {
                      setState(() {
                        selectedRadio = value;
                      });
                    },
                  ),
                  RadioListTile<int>(
                    activeColor: CustomColorTheme.iconColor,
                    selectedTileColor: CustomColorTheme.iconColor,
                    title: Text(
                      'Livelihood Funds Utilization',
                      style: TextStyle(
                          fontSize: CustomFontTheme.textSize,
                          fontWeight: CustomFontTheme.headingwt,
                          color: selectedRadio == 6
                              ? CustomColorTheme.iconColor
                              : CustomColorTheme.textColor),
                    ),
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
                        backgroundColor: CustomColorTheme.primaryColor),
                    onPressed: () {
                      if (selectedRadio == 1) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Form1(),
                          ),
                        );
                      } else if (selectedRadio == 2) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Cumulative(),
                          ),
                        ); // Navigate to the corresponding tab
                      } else if (selectedRadio == 3) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Leverwise(),
                          ),
                        ); // Navigate to the corresponding tab
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

  void _takeaction(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('AROKSKTS001'),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(Icons.close),
                      ),
                    ],
                  ),
                  Text('Update Completion Date '),
                  RadioListTile<int>(
                    activeColor: CustomColorTheme.iconColor,
                    selectedTileColor: CustomColorTheme.iconColor,
                    title: Text(
                      'Add Intervention',
                      style: TextStyle(
                          fontSize: CustomFontTheme.textSize,
                          fontWeight: CustomFontTheme.headingwt,
                          color: CustomColorTheme.textColor),
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
                    activeColor: CustomColorTheme.iconColor,
                    selectedTileColor: CustomColorTheme.iconColor,
                    title: Text(
                      'Update Completion Date',
                      style: TextStyle(
                          fontSize: CustomFontTheme.textSize,
                          fontWeight: CustomFontTheme.headingwt,
                          color: CustomColorTheme.textColor),
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
                    activeColor: CustomColorTheme.iconColor,
                    selectedTileColor: CustomColorTheme.iconColor,
                    title: Text(
                      'Add Additional Income',
                      style: TextStyle(
                          fontSize: CustomFontTheme.textSize,
                          fontWeight: CustomFontTheme.headingwt,
                          color: CustomColorTheme.textColor),
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
                    activeColor: CustomColorTheme.iconColor,
                    selectedTileColor: CustomColorTheme.iconColor,
                    title: Text(
                      'Update Household Details',
                      style: TextStyle(
                          fontSize: CustomFontTheme.textSize,
                          fontWeight: CustomFontTheme.headingwt,
                          color: CustomColorTheme.textColor),
                    ),
                    value: 4,
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
                        backgroundColor: CustomColorTheme.primaryColor),
                    onPressed: () {
                      if (selectedRadio == 1) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Addinter(),
                          ),
                        );
                      } else if (selectedRadio == 2) {
                        Navigator.of(context).pop();
                        _updatecompletion(context);
                      } else if (selectedRadio == 3) {
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: (context) => Leverwise(),
                        //   ),
                        // ); // Navigate to the corresponding tab
                      } else if (selectedRadio == 4) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => AddHead(),
                          ),
                        );
                        // Navigate to the corresponding tab
                      }
                    },
                    child: const Text('Continue'),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _updatecompletion(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('AROKSKTS001'),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(Icons.close),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Update Completion Date',
                    style: TextStyle(fontSize: CustomFontTheme.textSize),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  RadioListTile<int>(
                    activeColor: CustomColorTheme.iconColor,
                    selectedTileColor: CustomColorTheme.iconColor,
                    title: Text(
                      'int.1    Mushroom Cultivation',
                      style: TextStyle(
                          fontSize: CustomFontTheme.textSize,
                          // fontWeight: CustomFontTheme.headingwt,
                          color: CustomColorTheme.textColor),
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
                    activeColor: CustomColorTheme.iconColor,
                    selectedTileColor: CustomColorTheme.iconColor,
                    title: Text(
                      'Update Completion Date',
                      style: TextStyle(
                          fontSize: CustomFontTheme.textSize,
                          fontWeight: CustomFontTheme.headingwt,
                          color: CustomColorTheme.textColor),
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
                    activeColor: CustomColorTheme.iconColor,
                    selectedTileColor: CustomColorTheme.iconColor,
                    title: Text(
                      'Add Additional Income',
                      style: TextStyle(
                          fontSize: CustomFontTheme.textSize,
                          fontWeight: CustomFontTheme.headingwt,
                          color: CustomColorTheme.textColor),
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
                    activeColor: CustomColorTheme.iconColor,
                    selectedTileColor: CustomColorTheme.iconColor,
                    title: Text(
                      'Update Household Details',
                      style: TextStyle(
                          fontSize: CustomFontTheme.textSize,
                          fontWeight: CustomFontTheme.headingwt,
                          color: CustomColorTheme.textColor),
                    ),
                    value: 4,
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
                        backgroundColor: CustomColorTheme.primaryColor),
                    onPressed: () {
                      if (selectedRadio == 1) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Form1(),
                          ),
                        );
                      } else if (selectedRadio == 2) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Cumulative(),
                          ),
                        ); // Navigate to the corresponding tab
                      } else if (selectedRadio == 3) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Leverwise(),
                          ),
                        ); // Navigate to the corresponding tab
                      } else if (selectedRadio == 4) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Top20(),
                          ),
                        );
                        // Navigate to the corresponding tab
                      }
                    },
                    child: const Text('Continue'),
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
