import 'dart:convert';

import 'package:dalmia/common/app_style.dart';
import 'package:dalmia/common/size_constant.dart';
import 'package:dalmia/pages/CDO/cdoappbar.dart';
import 'package:dalmia/pages/CDO/cdohome.dart';
import 'package:dalmia/pages/vdf/street/Addstreet.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class VDFFunds extends StatefulWidget {
  const VDFFunds({Key? key}) : super(key: key);

  @override
  State<VDFFunds> createState() => _VDFFundsState();
}

class _VDFFundsState extends State<VDFFunds> {
  List<Map<String, dynamic>> fundData = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(
      Uri.parse(
        '$base/funds-utilized-by-vdf?locationId=10001',
      ),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<dynamic> respBody = responseData['resp_body'];
      print("ds$respBody");

      setState(() {
        fundData = List<Map<String, dynamic>>.from(respBody);
        // print(fundData);
      });
    } else {
      // Handle error
      print('Error fetching data: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    int totalBudget =
        fundData.fold(
        0,
        (prev, curr) =>
            prev + ((curr['budget'] != null ? curr['budget'] : 0) as int));
    int totalUtilized =
        fundData.fold(
        0,
        (prev, curr) =>
            prev + ((curr['utilized'] != null ? curr['utilized'] : 0) as int));

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: CdoAppBar(
            heading: 'Funds utilized by VDFs (Rs)',
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all( 20),
            child: Column(
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
                          fontWeight: CustomFontTheme.headingwt,
                        ),
                      ),
                    ],
                  ),
                ),
                 SizedBox(
                  height: MySize.screenHeight*(40/MySize.screenHeight),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    dividerThickness: 0,
                    columns: const <DataColumn>[
                      DataColumn(
                        label: Text(
                          'Details',
                          style: TextStyle(
                            fontWeight: CustomFontTheme.headingwt,
                            fontSize: CustomFontTheme.textSize,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Budget',
                          style: TextStyle(
                            fontWeight: CustomFontTheme.headingwt,
                            fontSize: CustomFontTheme.textSize,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Utilized',
                          style: TextStyle(
                            fontWeight: CustomFontTheme.headingwt,
                            fontSize: CustomFontTheme.textSize,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                    headingRowColor: MaterialStateColor.resolveWith(
                      (states) => const Color(0xFF008CD3),
                    ),
                    rows: List<DataRow>.generate(
                          fundData.length,
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
                                  fundData[index]['details']==""?"VDF(test)":fundData[index]['details'] as String,
                                  style: const TextStyle(
                                    fontSize: CustomFontTheme.textSize,
                                    fontWeight: CustomFontTheme.headingwt,
                                  ),
                                ),
                              ),
                              DataCell(
                                Text(
                                  (fundData[index]['budget']==null?"0":fundData[index]['budget'] as int).toString(),
                                  style: const TextStyle(
                                    color: CustomColorTheme.textColor,
                                    fontWeight: CustomFontTheme.headingwt,
                                    fontSize: CustomFontTheme.textSize,
                                  ),
                                ),
                              ),
                              DataCell(
                                Text(
                                  (fundData[index]['utilized']==null?"0":fundData[index]['utilized'] as int).toString(),
                                  style: const TextStyle(
                                    color: CustomColorTheme.textColor,
                                    fontWeight: CustomFontTheme.headingwt,
                                    fontSize: CustomFontTheme.textSize,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ) +
                        [
                          DataRow(
                            color: MaterialStateColor.resolveWith(
                              (states) => Colors.white,
                            ),
                            cells: [
                              DataCell(
                                const Text(
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
                                  style: const TextStyle(
                                    color: CustomColorTheme.textColor,
                                    fontWeight: CustomFontTheme.headingwt,
                                    fontSize: CustomFontTheme.textSize,
                                  ),
                                ),
                              ),
                              DataCell(
                                Text(
                                  totalUtilized.toString(),
                                  style: const TextStyle(
                                    color: CustomColorTheme.textColor,
                                    fontWeight: CustomFontTheme.headingwt,
                                    fontSize: CustomFontTheme.textSize,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
