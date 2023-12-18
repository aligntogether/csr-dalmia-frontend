import 'package:dalmia/pages/LL/ll_home_screen.dart';
import 'package:dalmia/pages/LL/llappbar.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';

class sourceoffunds {
  static List<String> names = [
    'VDF Name 1',
    'VDF Name 2',
    'VDF Name 3',
    'VDF Name 4'
  ];
  static List<int> noofhh = [195, 54, 234, 23];
  static List<double> beneficiary = [
    6.4,
    5.9,
    3.2,
    4.5,
  ];
  static List<double> subsidy = [
    6.4,
    2.9,
    4.7,
    4.5,
  ];
  static List<double> credits = [
    6.4,
    4.9,
    9.2,
    7.5,
  ];
  static List<double> dbf = [
    6.4,
    5.9,
    3.2,
    4.5,
  ];
}

class SourceOfFundsOfLL extends StatefulWidget {
  const SourceOfFundsOfLL({Key? key}) : super(key: key);

  @override
  State<SourceOfFundsOfLL> createState() => _SourceOfFundsOfLLState();
}

class _SourceOfFundsOfLLState extends State<SourceOfFundsOfLL> {
  @override
  Widget build(BuildContext context) {
    int totalhh = sourceoffunds.noofhh.fold(0, (prev, curr) => prev + curr);
    double totalbeneficiary =
        sourceoffunds.beneficiary.fold(0, (prev, curr) => prev + curr);
    double totalsubsidy =
        sourceoffunds.subsidy.fold(0, (prev, curr) => prev + curr);
    double totalcredit =
        sourceoffunds.credits.fold(0, (prev, curr) => prev + curr);
    double totaldbf = sourceoffunds.dbf.fold(0, (prev, curr) => prev + curr);
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: LLAppBar(
            heading: 'Source of Funds',
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  height: 20,
                ),
                Center(
                  child: Text(
                    'Ariyalur',
                    style: TextStyle(
                        fontSize: CustomFontTheme.textSize,
                        fontWeight: CustomFontTheme.headingwt),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    'Source of Funds (Rs.)',
                    style: TextStyle(
                        fontSize: CustomFontTheme.textSize,
                        fontWeight: CustomFontTheme.labelwt),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      dividerThickness: 0.0,
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
                            'No. of HH',
                            style: TextStyle(
                                fontWeight: CustomFontTheme.headingwt,
                                fontSize: CustomFontTheme.textSize,
                                color: Colors.white),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Beneficiary',
                            style: TextStyle(
                                fontWeight: CustomFontTheme.headingwt,
                                fontSize: CustomFontTheme.textSize,
                                color: Colors.white),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Subsidy',
                            style: TextStyle(
                                fontWeight: CustomFontTheme.headingwt,
                                fontSize: CustomFontTheme.textSize,
                                color: Colors.white),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Credits',
                            style: TextStyle(
                                fontWeight: CustomFontTheme.headingwt,
                                fontSize: CustomFontTheme.textSize,
                                color: Colors.white),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'DBF',
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
                            sourceoffunds.names.length,
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
                                    sourceoffunds.names[index],
                                    style: TextStyle(
                                      fontSize: CustomFontTheme.textSize,
                                      fontWeight: CustomFontTheme.headingwt,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    (sourceoffunds.noofhh[index].toString()),
                                    style: TextStyle(
                                        color: CustomColorTheme.textColor,
                                        fontSize: CustomFontTheme.textSize),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    sourceoffunds.beneficiary[index].toString(),
                                    style: TextStyle(
                                        color: CustomColorTheme.textColor,
                                        fontSize: CustomFontTheme.textSize),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    sourceoffunds.subsidy[index].toString(),
                                    style: TextStyle(
                                        color: CustomColorTheme.textColor,
                                        fontSize: CustomFontTheme.textSize),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    sourceoffunds.credits[index].toString(),
                                    style: TextStyle(
                                        color: CustomColorTheme.textColor,
                                        fontSize: CustomFontTheme.textSize),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    sourceoffunds.dbf[index].toString(),
                                    style: TextStyle(
                                        color: CustomColorTheme.textColor,
                                        fontSize: CustomFontTheme.textSize),
                                  ),
                                )
                              ],
                            ),
                          ) +
                          [
                            DataRow(
                              color: MaterialStateColor.resolveWith(
                                  (states) => Colors.blue.shade50),
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
                                    totalhh.toString(),
                                    style: TextStyle(
                                      color: CustomColorTheme.textColor,
                                      fontWeight: CustomFontTheme.headingwt,
                                      fontSize: CustomFontTheme.textSize,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    totalbeneficiary.toString(),
                                    style: TextStyle(
                                      color: CustomColorTheme.textColor,
                                      fontWeight: CustomFontTheme.headingwt,
                                      fontSize: CustomFontTheme.textSize,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    totalsubsidy.toString(),
                                    style: TextStyle(
                                      color: CustomColorTheme.textColor,
                                      fontWeight: CustomFontTheme.headingwt,
                                      fontSize: CustomFontTheme.textSize,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    totalcredit.toString(),
                                    style: TextStyle(
                                      color: CustomColorTheme.textColor,
                                      fontWeight: CustomFontTheme.headingwt,
                                      fontSize: CustomFontTheme.textSize,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    totaldbf.toString(),
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
      ),
    );
  }

  // Function to generate a random number
  // int _generateRandomNumber() {
  //   return 50 + (DateTime.now().millisecondsSinceEpoch % 50);
  // }
}
