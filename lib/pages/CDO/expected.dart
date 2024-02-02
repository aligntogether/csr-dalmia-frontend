import 'dart:convert';

import 'package:dalmia/common/app_style.dart';
import 'package:dalmia/common/size_constant.dart';
import 'package:dalmia/pages/CDO/cdoappbar.dart';
import 'package:dalmia/pages/CDO/cdohome.dart';
import 'package:dalmia/theme.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_svg/svg.dart';

List locationcdo = [
  "Target",
  "No. of HHs with EAAI",
  "50k to 1L",
  " No. of HHs with EAAI\n1L and above",
  "No. of HHs with AAAI\nwith 50K to 1L",
  "No. of HHs with AAAI\nwith 1L and above",
  "Aggregate income (EAAI)",
  "Aggregate income (AAAI)",
];

class Expectedincome extends StatefulWidget {
  const Expectedincome({Key? key}) : super(key: key);

  @override
  State<Expectedincome> createState() => _ExpectedincomeState();
}

class _ExpectedincomeState extends State<Expectedincome> {
  List<Map<String, dynamic>> ExpectedData = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(
      Uri.parse(
        'https://mobileqacloud.dalmiabharat.com:443/csr/expected-actual-additional-income?locationId=10001',
      ),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      final Map<String, dynamic> respBody = responseData['resp_body'];

      // Handle the case where 'resp_body' is a Map
      // final String clusterKey = responseData['resp_body'].keys.first;

      ExpectedData = [respBody];
      // print(ExpectedData);
    } else {
      // Handle error
      print('Error fetching data: ${response.statusCode}');
    }

    setState(() {});
  }

  List<int> CDO = [
    2434,
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
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: CdoAppBar(
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
                        builder: (context) => const CDOHome(),
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
                            locationcdo.length,
                            (index) => DataRow(
                              color: MaterialStateColor.resolveWith(
                                (states) {
                                  return index.isEven
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
                                          locationcdo[index],
                                          style: AppStyle.textStyleInterMed(
                                              fontSize: 14),
                                        ),
                                        Spacer(),
                                        VerticalDivider(
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
                                        (CDO[index].toString()),
                                        style: AppStyle.textStyleInterMed(
                                            fontSize: 14),
                                      ),
                                      Spacer(),
                                      VerticalDivider(
                                        width: 1,
                                        color:
                                            Color(0xff181818).withOpacity(0.3),
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
