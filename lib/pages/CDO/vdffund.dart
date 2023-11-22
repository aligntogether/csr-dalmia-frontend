import 'package:dalmia/pages/CDO/actiondetails.dart';
import 'package:dalmia/pages/CDO/cdoappbar.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class vdfreport {
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

class VDFFunds extends StatefulWidget {
  const VDFFunds({super.key});

  @override
  State<VDFFunds> createState() => _VDFFundsState();
}

class _VDFFundsState extends State<VDFFunds> {
  @override
  Widget build(BuildContext context) {
    int totalBudget = vdfreport.budget.fold(0, (prev, curr) => prev + curr);
    int totalUtilized = vdfreport.utilized.fold(0, (prev, curr) => prev + curr);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            //  isMenuOpen ? Size.fromHeight(150) :
            Size.fromHeight(100),
        child: CdoAppBar(
          heading: 'Funds utilized by VDFs (Rs)',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 20),
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Center(
                child: Text(
                  'Select HHID to view details',
                  style: TextStyle(
                    fontSize: CustomFontTheme.textSize,
                    fontWeight: CustomFontTheme.labelwt,
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
                          vdfreport.names.length,
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
                                  vdfreport.names[index],
                                  style: TextStyle(
                                    fontSize: CustomFontTheme.textSize,
                                    fontWeight: CustomFontTheme.headingwt,
                                  ),
                                ),
                              ),
                              DataCell(
                                Text(
                                  (vdfreport.budget[index].toString()),
                                  style: TextStyle(
                                      color: CustomColorTheme.textColor,
                                      fontWeight: CustomFontTheme.headingwt,
                                      fontSize: CustomFontTheme.textSize),
                                ),
                              ),
                              DataCell(
                                Text(
                                  vdfreport.utilized[index].toString(),
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
