import 'package:dalmia/pages/LL/ll_home_screen.dart';
import 'package:dalmia/pages/LL/llappbar.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';

class vdffundreport {
  static List<String> names = [
    'VDF Name 1',
    'VDF Name 2',
    'VDF Name 3',
    'VDF Name 4'
  ];
  static List<int> budget = [500000, 500000, 500000, 500000];
  static List<int> utilized = [
    128036,
    37765,
    387004,
    1687825,
  ];
}

class LLVDFFunds extends StatefulWidget {
  const LLVDFFunds({super.key});

  @override
  State<LLVDFFunds> createState() => _LLVDFFundsState();
}

class _LLVDFFundsState extends State<LLVDFFunds> {
  @override
  Widget build(BuildContext context) {
    int totalBudget = vdffundreport.budget.fold(0, (prev, curr) => prev + curr);
    int totalUtilized =
        vdffundreport.utilized.fold(0, (prev, curr) => prev + curr);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            //  isMenuOpen ? Size.fromHeight(150) :
            Size.fromHeight(100),
        child: LLAppBar(
          heading: 'Funds utilized by VDFs (Rs)',
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
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    dividerThickness: 00,
                    columns: const <DataColumn>[
                      DataColumn(
                        label: Text(
                          'Details',
                          style: TextStyle(
                              fontWeight: CustomFontTheme.headingwt,
                              fontSize: CustomFontTheme.textSize,
                              color: Colors.white),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Budget',
                          style: TextStyle(
                              fontWeight: CustomFontTheme.headingwt,
                              fontSize: CustomFontTheme.textSize,
                              color: Colors.white),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Utilized',
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
                          vdffundreport.names.length,
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
                                Text(
                                  vdffundreport.names[index],
                                  style: TextStyle(
                                    fontSize: CustomFontTheme.textSize,
                                    fontWeight: CustomFontTheme.headingwt,
                                  ),
                                ),
                              ),
                              DataCell(
                                Text(
                                  (vdffundreport.budget[index].toString()),
                                  style: TextStyle(
                                      color: CustomColorTheme.textColor,
                                      fontWeight: CustomFontTheme.headingwt,
                                      fontSize: CustomFontTheme.textSize),
                                ),
                              ),
                              DataCell(
                                Text(
                                  vdffundreport.utilized[index].toString(),
                                  style: TextStyle(
                                      color: CustomColorTheme.textColor,
                                      fontWeight: CustomFontTheme.headingwt,
                                      fontSize: CustomFontTheme.textSize),
                                ),
                              )
                              // Additional row for total
                            ],
                          ),
                        ) +
                        [
                          DataRow(
                            color: MaterialStateColor.resolveWith(
                                (states) => Colors.white),
                            cells: [
                              DataCell(
                                Text(
                                  'Total',
                                  style: TextStyle(
                                    fontSize: CustomFontTheme.textSize,
                                    fontWeight: CustomFontTheme.headingwt,
                                  ),
                                ),
                              ),
                              DataCell(
                                Text(
                                  totalBudget.toString(),
                                  style: TextStyle(
                                    color: CustomColorTheme.textColor,
                                    fontWeight: CustomFontTheme.headingwt,
                                    fontSize: CustomFontTheme.textSize,
                                  ),
                                ),
                              ),
                              DataCell(
                                Text(
                                  totalUtilized.toString(),
                                  style: TextStyle(
                                    color: CustomColorTheme.textColor,
                                    fontWeight: CustomFontTheme.headingwt,
                                    fontSize: CustomFontTheme.textSize,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
