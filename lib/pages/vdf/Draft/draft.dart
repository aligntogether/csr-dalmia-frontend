import 'package:dalmia/Constants/constants.dart';
import 'package:dalmia/common/bottombar.dart';
import 'package:dalmia/components/reportappbar.dart';
import 'package:dalmia/pages/vdf/household/addhouse.dart';
import 'package:dalmia/pages/vdf/street/Addstreet.dart';
import 'package:dalmia/pages/vdf/vdfhome.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';

class Draft extends StatefulWidget {
  const Draft({Key? key});

  @override
  State<Draft> createState() => _DraftState();
}

class _DraftState extends State<Draft> {
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

  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(100),
            child: ReportAppBar(heading: 'Drafts')),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Center(
                  child: Text(
                'Select a row to edit or delete draft HH',
                style: TextStyle(
                    fontSize: CustomFontTheme.textSize,
                    fontWeight: CustomFontTheme.headingwt),
              )),
              const SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  headingRowColor:
                      MaterialStateColor.resolveWith((states) => Colors.blue),
                  columns: const <DataColumn>[
                    DataColumn(
                      label: Text(
                        ' ',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    DataColumn(
                      label:
                          Text('Date', style: TextStyle(color: Colors.white)),
                    ),
                    DataColumn(
                      label: Text('Head Name',
                          style: TextStyle(color: Colors.white)),
                    ),
                    DataColumn(
                      label:
                          Text('Street', style: TextStyle(color: Colors.white)),
                    ),
                    DataColumn(
                      label: Text('Village',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                  rows: <DataRow>[
                    DataRow(
                      cells: <DataCell>[
                        DataCell(
                          Checkbox(
                            value: false,
                            onChanged: (value) {},
                          ),
                        ),
                        const DataCell(Text(
                            '2023-10-31')), // Placeholder date, replace with actual data
                        const DataCell(Text(
                            'John Doe')), // Placeholder name, replace with actual data
                        const DataCell(Text(
                            'Main Street')), // Placeholder street, replace with actual data
                        const DataCell(Text('Rural Village')),
                      ],
                    ),
                    DataRow(
                      color: MaterialStateColor.resolveWith(
                          (states) => Colors.lightBlue[50]!),
                      cells: <DataCell>[
                        DataCell(
                          Checkbox(
                            value: false,
                            onChanged: (value) {},
                          ),
                        ),
                        const DataCell(Text(
                            '2023-10-31')), // Placeholder date, replace with actual data
                        const DataCell(Text(
                            'John Doe')), // Placeholder name, replace with actual data
                        const DataCell(Text(
                            'Main Street')), // Placeholder street, replace with actual data
                        const DataCell(Text('Rural Village')),
                      ],
                    ),
                    // Add more DataRows as needed
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0.0),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            CustomColorTheme.primaryColor),
                      ),
                      onPressed: () {},
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Edit Household',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      )),
                  ElevatedButton(
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0.0),
                        side: MaterialStateProperty.all<BorderSide>(
                            const BorderSide(
                                color: CustomColorTheme.primaryColor,
                                width: 1)),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            CustomColorTheme.backgroundColor),
                      ),
                      onPressed: () {},
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Delete Household',
                          style:
                              TextStyle(color: CustomColorTheme.primaryColor),
                        ),
                      )),
                ],
              )
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomTabItem(
                imagePath: 'images/Dashboard_Outline.svg',
                label: "Dashboard",
                index: 0,
                selectedIndex: selectedIndex,
                onTabTapped: _onTabTapped,
              ),
              CustomTabItem(
                imagePath: 'images/Household_Outline.svg',
                label: "Add Household",
                index: 1,
                selectedIndex: selectedIndex,
                onTabTapped: _onTabTapped,
              ),
              CustomTabItem(
                imagePath: 'images/Street_Outline.svg',
                label: "Add Street",
                index: 2,
                selectedIndex: selectedIndex,
                onTabTapped: _onTabTapped,
              ),
              CustomTabItem(
                imagePath: 'images/Drafts_Outline.svg',
                label: "Drafts",
                index: 3,
                selectedIndex: selectedIndex,
                onTabTapped: _onTabTapped,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
