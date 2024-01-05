import 'package:dalmia/pages/LL/ll_home_screen.dart';
import 'package:dalmia/pages/LL/llappbar.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';

class weeklyprogressLL {
  static List<String> detail = [
    'HH Mapped',
    'HH selected',
    'Int. Planned',
    'Int. Completed'
  ];

  static List<int> firstweek = [13, 45, 32, 12];
  static List<int> secondweek = [56, 34, 21, 44];
  static List<int> thirdweek = [12, 45, 66, 33];
  static List<int> forthweek = [34, 25, 83, 91];
  static List<int> fifthweek = [53, 43, 36, 13];
  static List<int> sixthweek = [92, 71, 76, 34];
  static List<int> seventhweek = [12, 45, 66, 33];
  static List<int> cumulative = [455, 788, 543, 123];
}

class WeeklyProgress extends StatefulWidget {
  const WeeklyProgress({Key? key}) : super(key: key);

  @override
  State<WeeklyProgress> createState() => _WeeklyProgressState();
}

class _WeeklyProgressState extends State<WeeklyProgress> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: LLAppBar(
            heading: 'Weekly Progress Report',
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
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
                    'Performance of VDF over past 8 weeks',
                    style: TextStyle(
                        fontSize: CustomFontTheme.textSize,
                        fontWeight: CustomFontTheme.headingwt),
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
                              '6-May',
                              style: TextStyle(
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                  color: Colors.white),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              '13-May',
                              style: TextStyle(
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                  color: Colors.white),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              '20-May',
                              style: TextStyle(
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                  color: Colors.white),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              '3-Jun',
                              style: TextStyle(
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                  color: Colors.white),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              '10-Jun',
                              style: TextStyle(
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                  color: Colors.white),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              '17-Jun',
                              style: TextStyle(
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                  color: Colors.white),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              '24-Jun',
                              style: TextStyle(
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                  color: Colors.white),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Cumulative*',
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
                          weeklyprogressLL.detail.length,
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
                                  weeklyprogressLL.detail[index],
                                  style: TextStyle(
                                    fontSize: CustomFontTheme.textSize,
                                    fontWeight: CustomFontTheme.headingwt,
                                  ),
                                ),
                              ),
                              DataCell(
                                Text(
                                  weeklyprogressLL.firstweek[index].toString(),
                                  style: TextStyle(
                                      color: CustomColorTheme.textColor,
                                      fontWeight: CustomFontTheme.labelwt,
                                      fontSize: CustomFontTheme.textSize),
                                ),
                              ),
                              DataCell(
                                Text(
                                  weeklyprogressLL.secondweek[index].toString(),
                                  style: TextStyle(
                                      color: CustomColorTheme.textColor,
                                      fontWeight: CustomFontTheme.labelwt,
                                      fontSize: CustomFontTheme.textSize),
                                ),
                              ),
                              DataCell(
                                Text(
                                  weeklyprogressLL.thirdweek[index].toString(),
                                  style: TextStyle(
                                      color: CustomColorTheme.textColor,
                                      fontWeight: CustomFontTheme.labelwt,
                                      fontSize: CustomFontTheme.textSize),
                                ),
                              ),
                              DataCell(
                                Text(
                                  weeklyprogressLL.forthweek[index].toString(),
                                  style: TextStyle(
                                      color: CustomColorTheme.textColor,
                                      fontWeight: CustomFontTheme.labelwt,
                                      fontSize: CustomFontTheme.textSize),
                                ),
                              ),
                              DataCell(
                                Text(
                                  weeklyprogressLL.fifthweek[index].toString(),
                                  style: TextStyle(
                                      color: CustomColorTheme.textColor,
                                      fontWeight: CustomFontTheme.labelwt,
                                      fontSize: CustomFontTheme.textSize),
                                ),
                              ),
                              DataCell(
                                Text(
                                  weeklyprogressLL.sixthweek[index].toString(),
                                  style: TextStyle(
                                      color: CustomColorTheme.textColor,
                                      fontWeight: CustomFontTheme.labelwt,
                                      fontSize: CustomFontTheme.textSize),
                                ),
                              ),
                              DataCell(
                                Text(
                                  weeklyprogressLL.seventhweek[index]
                                      .toString(),
                                  style: TextStyle(
                                      color: CustomColorTheme.textColor,
                                      fontWeight: CustomFontTheme.labelwt,
                                      fontSize: CustomFontTheme.textSize),
                                ),
                              ),
                              DataCell(
                                Text(
                                  weeklyprogressLL.cumulative[index].toString(),
                                  style: TextStyle(
                                      color: CustomColorTheme.textColor,
                                      fontWeight: CustomFontTheme.headingwt,
                                      fontSize: CustomFontTheme.textSize),
                                ),
                              )
                            ],
                          ),
                        ))),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Text(
                    '*Note: Cumulative figures are from the beginning of the project, NOT the total of figures displayed on this screen',
                    style: TextStyle(fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                )
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
