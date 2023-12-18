import 'package:dalmia/common/app_style.dart';
import 'package:dalmia/common/size_constant.dart';
import 'package:dalmia/pages/LL/ll_home_screen.dart';
import 'package:dalmia/pages/LL/llappbar.dart';

import 'package:dalmia/theme.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

List location = [
  "Cluster 1",
  "Target",
  "No. of HHs with EAAI",
  "50k to 1L",
  " No. of HHs with EAAI\n1L and above",
  "No. of HHs with AAAI\nwith 50K to 1L",
  "No. of HHs with AAAI\nwith 1L and above",
  "Aggregate income (EAAI)",
  "Aggregate income (AAAI)",
  "Cluster 2",
  "Target",
  "No. of HHs with EAAI",
  "50k to 1L",
  "No. of HHs with EAAI\n1L and above",
  "No. of HHs with AAAI\nwith 50K to 1L",
  "No. of HHs with AAAI\nwith 1L and above",
  "Aggregate income (EAAI)",
  "Aggregate income (AAAI)",
];
List<int> LL = [
  128036,
  37765,
  387004,
  1687825,
  128036,
  37765,
  387004,
  1687825,
  128036,
  37765,
  387004,
  1687825,
  128036,
  37765,
  387004,
  1687825,
  128036,
  37765,
];

class ExpectedincomeLL extends StatefulWidget {
  const ExpectedincomeLL({Key? key}) : super(key: key);

  @override
  State<ExpectedincomeLL> createState() => _ExpectedincomeLLState();
}

class _ExpectedincomeLLState extends State<ExpectedincomeLL> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: LLAppBar(
            heading: 'Reports',
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
                    'Expected and actual additional incomes',
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: DataTable(
                          dividerThickness: 00,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 0,
                                blurRadius: 4,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          columnSpacing: 0,
                          horizontalMargin: 0,
                          columns: <DataColumn>[
                            DataColumn(
                              label: Expanded(
                                child: Container(
                                  height: 60,
                                  decoration: BoxDecoration(
                                      color: Color(0xff008CD3),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10.0))),
                                  padding: EdgeInsets.only(left: 10),
                                  child: Center(
                                    child: Text(
                                      'Locations',
                                      style: TextStyle(
                                          fontWeight: CustomFontTheme.headingwt,
                                          fontSize: CustomFontTheme.textSize,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Container(
                                height: 60,
                                width: 80,
                                color: Color(0xff008CD3),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Center(
                                  child: Text(
                                    'DPM',
                                    style: TextStyle(
                                        fontWeight: CustomFontTheme.headingwt,
                                        fontSize: CustomFontTheme.textSize,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),

                            //PANIND
                          ],
                          rows: List<DataRow>.generate(
                            location.length,
                            (index) => DataRow(
                              color: MaterialStateColor.resolveWith(
                                (states) {
                                  return location[index] == "Cluster 1" ||
                                          location[index] == "Cluster 2"
                                      ? Color(0xff008CD3).withOpacity(0.3)
                                      : index.isEven
                                          ? Colors.blue.shade50
                                          : Colors.white;
                                },
                              ),
                              cells: [
                                DataCell(
                                  Container(
                                    width: 200,
                                    padding: EdgeInsets.only(left: 10),
                                    child: Row(
                                      children: [
                                        Text(
                                          location[index],
                                          style: location[index] ==
                                                      "Cluster 1" ||
                                                  location[index] == "Cluster 2"
                                              ? TextStyle(
                                                  color: CustomColorTheme
                                                      .textColor,
                                                  fontWeight:
                                                      CustomFontTheme.headingwt,
                                                  fontSize:
                                                      CustomFontTheme.textSize)
                                              : AppStyle.textStyleInterMed(
                                                  fontSize: 14),
                                        ),
                                        Spacer(),
                                        location[index] == "Cluster 1" ||
                                                location[index] == "Cluster 2"
                                            ? SizedBox()
                                            : VerticalDivider(
                                                width: 1,
                                                color: Color(0xff181818)
                                                    .withOpacity(0.3),
                                                thickness: 1,
                                              )
                                      ],
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Row(
                                    children: [
                                      Spacer(),
                                      Text(
                                        (location[index] == "Cluster 1" ||
                                                location[index] == "Cluster 2"
                                            ? ""
                                            : LL[index].toString()),
                                        style: AppStyle.textStyleInterMed(
                                            fontSize: 14),
                                      ),
                                      Spacer(),
                                      location[index] == "Cluster 1" ||
                                              location[index] == "Cluster 2"
                                          ? SizedBox()
                                          : VerticalDivider(
                                              width: 1,
                                              color: Color(0xff181818)
                                                  .withOpacity(0.3),
                                              thickness: 1,
                                            )
                                    ],
                                  ),
                                ),
                                // Additional row for total
                              ],
                            ),
                          )),
                    )),
                Space.height(30),
                Space.height(30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
