import 'package:dalmia/pages/LL/actiondetails.dart';
import 'package:dalmia/pages/LL/ll_home_screen.dart';
import 'package:dalmia/pages/LL/llappbar.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';

class information {
  static List<String> householdIds = [
    'AROKSKTS001',
    'AROKSKTS002',
    'AROKSKTS003',
    'AROKSKTS004'
  ];
  static List<String> familyHeadNames = [
    "Krishnan",
    "Krishnan",
    "Krishnan",
    "Krishnan"
  ];
  static List<String> vdfNames = [
    "Balamurugan",
    "Balamurugan",
    "Balamurugan",
    "Balamurugan"
  ];
}

class ActionAgainstHHLL extends StatefulWidget {
  const ActionAgainstHHLL({super.key});

  @override
  State<ActionAgainstHHLL> createState() => _ActionAgainstHHLLState();
}

class _ActionAgainstHHLLState extends State<ActionAgainstHHLL> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            //  isMenuOpen ? Size.fromHeight(150) :
            Size.fromHeight(100),
        child: LLAppBar(
          heading: 'Drop or Select HH for Int.',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 20, top: 20, bottom: 20),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const LLHome(),
                    ),
                  );
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.keyboard_arrow_left_sharp,
                    ),
                    Text(
                      'Main Menu',
                      style: TextStyle(
                          fontSize: CustomFontTheme.textSize,
                          fontWeight: CustomFontTheme.headingwt),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Center(
                child: Text(
                  'Select HHID to view details',
                  style: TextStyle(
                    fontSize: CustomFontTheme.textSize,
                    fontWeight: CustomFontTheme.headingwt,
                    color: CustomColorTheme.textColor,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    dividerThickness: 00,
                    columns: const <DataColumn>[
                      DataColumn(
                        label: Text(
                          'HHID',
                          style: TextStyle(
                              fontWeight: CustomFontTheme.headingwt,
                              fontSize: CustomFontTheme.textSize,
                              color: Colors.white),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Family Head',
                          style: TextStyle(
                              fontWeight: CustomFontTheme.headingwt,
                              fontSize: CustomFontTheme.textSize,
                              color: Colors.white),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'VDF Name',
                          style: TextStyle(
                              fontWeight: CustomFontTheme.headingwt,
                              fontSize: CustomFontTheme.textSize,
                              color: Colors.white),
                        ),
                      ),
                    ],
                    headingRowColor: MaterialStateColor.resolveWith(
                        (states) => Color(0xFF008CD3)),
                    rows: List<DataRow>.generate(
                      information.householdIds.length,
                      (index) => DataRow(
                        color: MaterialStateColor.resolveWith(
                          (states) {
                            return index.isOdd
                                ? Colors.blue.shade50
                                : Colors.white;
                          },
                        ),
                        cells: [
                          DataCell(
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => LLActionDetail(
                                        hhid: information.householdIds[index]),
                                  ),
                                );
                              },
                              child: Text(
                                information.householdIds[index],
                                style: TextStyle(
                                  color: CustomColorTheme.iconColor,
                                  decoration: TextDecoration.underline,
                                  fontSize: CustomFontTheme.textSize,
                                  fontWeight: CustomFontTheme.headingwt,
                                ),
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              information.familyHeadNames[index],
                              style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize),
                            ),
                          ),
                          DataCell(
                            Text(
                              information.vdfNames[index],
                              style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
