import 'dart:convert';

import 'package:dalmia/pages/CDO/cdoappbar.dart';
import 'package:dalmia/pages/CDO/cdohome.dart';
import 'package:dalmia/pages/vdf/street/Addstreet.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class VdfReport extends StatefulWidget {
  const VdfReport({Key? key}) : super(key: key);

  @override
  State<VdfReport> createState() => _VdfReportState();
}

class _VdfReportState extends State<VdfReport> {
  List<Map<String, dynamic>> VdfReportData = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(
      Uri.parse(
        '$base/vdf-wise-report?locationId=10001',
      ),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      final Map<String, dynamic> respBody = responseData['resp_body'];

      // Handle the case where 'resp_body' is a Map
      VdfReportData = [respBody];
      print(VdfReportData);
      vdfDetails =
          List.generate(VdfReportData.length, (index) => 'VDF ${index + 1}');
    } else {
      // Handle error
      print('Error fetching data: ${response.statusCode}');
    }

    setState(() {});
  }

  List<String> vdfDetails = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: CdoAppBar(
            heading: 'VDF Reports',
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
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 10,
                    child: DataTable(
                      // border:
                      //     TableBorder(borderRadius: BorderRadius.circular(10)),
                      dividerThickness: 0,
                      columns: <DataColumn>[
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
                        for (var vdf in vdfDetails)
                          DataColumn(
                            label: Text(
                              vdf,
                              style: TextStyle(
                                fontWeight: CustomFontTheme.headingwt,
                                fontSize: CustomFontTheme.textSize,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        DataColumn(
                          label: Text(
                            'Total',
                            style: TextStyle(
                              fontWeight: CustomFontTheme.headingwt,
                              fontSize: CustomFontTheme.textSize,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],

                      headingRowColor: MaterialStateColor.resolveWith(
                        (states) => Color(0xFF008CD3),
                      ),
                      rows: [
                        DataRow(
                          color: MaterialStateColor.resolveWith(
                            (states) {
                              return Colors.blue.shade100;
                            },
                          ),
                          cells: [
                            DataCell(
                              Text(
                                'Household',
                                style: TextStyle(
                                  fontSize: CustomFontTheme.textSize,
                                  fontWeight: CustomFontTheme.headingwt,
                                ),
                              ),
                            ),
                            for (var vdf in vdfDetails) DataCell(Text("")),
                            DataCell(
                              Text(
                                ' ',
                                style: TextStyle(
                                  fontSize: CustomFontTheme.textSize,
                                  fontWeight: CustomFontTheme.headingwt,
                                ),
                              ),
                            ),
                          ],
                        ),
                        DataRow(
                          color: MaterialStateColor.resolveWith(
                            (states) {
                              return Colors.white;
                            },
                          ),
                          cells: [
                            DataCell(
                              Text(
                                'Alloted',
                                style: TextStyle(
                                  fontSize: CustomFontTheme.textSize,
                                  fontWeight: CustomFontTheme.headingwt,
                                ),
                              ),
                            ),
                            for (var vdf in vdfDetails)
                              DataCell(
                                Text(
                                  (VdfReportData[0]['10001']['allotted'] ?? '')
                                      .toString(),
                                  style: TextStyle(
                                    color: CustomColorTheme.textColor,
                                    fontWeight: CustomFontTheme.headingwt,
                                    fontSize: CustomFontTheme.textSize,
                                  ),
                                ),
                              ),
                            DataCell(
                              Text(
                                _generateRandomNumber().toString(),
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                          ],
                        ),
                        DataRow(
                          color: MaterialStateColor.resolveWith(
                            (states) {
                              return Colors.blue.shade50;
                            },
                          ),
                          cells: [
                            DataCell(
                              Text(
                                'Mapped',
                                style: TextStyle(
                                  fontSize: CustomFontTheme.textSize,
                                  fontWeight: CustomFontTheme.headingwt,
                                ),
                              ),
                            ),
                            for (var vdf in vdfDetails)
                              DataCell(
                                Text(
                                  (VdfReportData[0]['10001']['mapped'] ?? '')
                                      .toString(),
                                  style: TextStyle(
                                    color: CustomColorTheme.textColor,
                                    fontWeight: CustomFontTheme.headingwt,
                                    fontSize: CustomFontTheme.textSize,
                                  ),
                                ),
                              ),
                            DataCell(
                              Text(
                                _generateRandomNumber().toString(),
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                          ],
                        ),
                        DataRow(
                          color: MaterialStateColor.resolveWith(
                            (states) {
                              return Colors.white;
                            },
                          ),
                          cells: [
                            DataCell(
                              Text(
                                'Selected',
                                style: TextStyle(
                                  fontSize: CustomFontTheme.textSize,
                                  fontWeight: CustomFontTheme.headingwt,
                                ),
                              ),
                            ),
                            for (var vdf in vdfDetails)
                              DataCell(
                                Text(
                                  (VdfReportData[0]['10001']['selected'] ?? '')
                                      .toString(),
                                  style: TextStyle(
                                    color: CustomColorTheme.textColor,
                                    fontWeight: CustomFontTheme.headingwt,
                                    fontSize: CustomFontTheme.textSize,
                                  ),
                                ),
                              ),
                            DataCell(
                              Text(
                                _generateRandomNumber().toString(),
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                          ],
                        ),
                        DataRow(
                          color: MaterialStateColor.resolveWith(
                            (states) {
                              return Colors.blue.shade50;
                            },
                          ),
                          cells: [
                            DataCell(
                              Text(
                                'Selection %',
                                style: TextStyle(
                                  fontSize: CustomFontTheme.textSize,
                                  fontWeight: CustomFontTheme.headingwt,
                                ),
                              ),
                            ),
                            for (var vdf in vdfDetails)
                              DataCell(
                                Text(
                                  _generateRandomNumber().toString(),
                                  style: TextStyle(
                                    color: CustomColorTheme.textColor,
                                    fontWeight: CustomFontTheme.headingwt,
                                    fontSize: CustomFontTheme.textSize,
                                  ),
                                ),
                              ),
                            DataCell(
                              Text(
                                _generateRandomNumber().toString(),
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                          ],
                        ),
                        DataRow(
                          color: MaterialStateColor.resolveWith(
                            (states) {
                              return Colors.blue.shade100;
                            },
                          ),
                          cells: [
                            DataCell(
                              Text(
                                'Intervention',
                                style: TextStyle(
                                  fontSize: CustomFontTheme.textSize,
                                  fontWeight: CustomFontTheme.headingwt,
                                ),
                              ),
                            ),
                            for (var vdf in vdfDetails)
                              DataCell(
                                Text(
                                  ' ',
                                ),
                              ),
                            DataCell(
                              Text(
                                ' ',
                                style: TextStyle(
                                  fontSize: CustomFontTheme.textSize,
                                  fontWeight: CustomFontTheme.headingwt,
                                ),
                              ),
                            ),
                          ],
                        ),
                        DataRow(
                          color: MaterialStateColor.resolveWith(
                            (states) {
                              return Colors.white;
                            },
                          ),
                          cells: [
                            DataCell(
                              Text(
                                'HH covered',
                                style: TextStyle(
                                  fontSize: CustomFontTheme.textSize,
                                  fontWeight: CustomFontTheme.headingwt,
                                ),
                              ),
                            ),
                            for (var vdf in vdfDetails)
                              DataCell(
                                Text(
                                  (VdfReportData[0]['10001']['hhCovered'] ?? '')
                                      .toString(),
                                  style: TextStyle(
                                    color: CustomColorTheme.textColor,
                                    fontWeight: CustomFontTheme.headingwt,
                                    fontSize: CustomFontTheme.textSize,
                                  ),
                                ),
                              ),
                            DataCell(
                              Text(
                                _generateRandomNumber().toString(),
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                          ],
                        ),
                        DataRow(
                          color: MaterialStateColor.resolveWith(
                            (states) {
                              return Colors.blue.shade50;
                            },
                          ),
                          cells: [
                            DataCell(
                              Text(
                                'Planned',
                                style: TextStyle(
                                  fontSize: CustomFontTheme.textSize,
                                  fontWeight: CustomFontTheme.headingwt,
                                ),
                              ),
                            ),
                            for (var vdf in vdfDetails)
                              DataCell(
                                Text(
                                  (VdfReportData[0]['10001']['planned'] ?? '')
                                      .toString(),
                                  style: TextStyle(
                                    color: CustomColorTheme.textColor,
                                    fontWeight: CustomFontTheme.headingwt,
                                    fontSize: CustomFontTheme.textSize,
                                  ),
                                ),
                              ),
                            DataCell(
                              Text(
                                _generateRandomNumber().toString(),
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                          ],
                        ),
                        DataRow(
                          color: MaterialStateColor.resolveWith(
                            (states) {
                              return Colors.white;
                            },
                          ),
                          cells: [
                            DataCell(
                              Text(
                                'Completed',
                                style: TextStyle(
                                  fontSize: CustomFontTheme.textSize,
                                  fontWeight: CustomFontTheme.headingwt,
                                ),
                              ),
                            ),
                            for (var vdf in vdfDetails)
                              DataCell(
                                Text(
                                  (VdfReportData[0]['10001']['completed'] ?? '')
                                      .toString(),
                                  style: TextStyle(
                                    color: CustomColorTheme.textColor,
                                    fontWeight: CustomFontTheme.headingwt,
                                    fontSize: CustomFontTheme.textSize,
                                  ),
                                ),
                              ),
                            DataCell(
                              Text(
                                _generateRandomNumber().toString(),
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                          ],
                        ),
                        DataRow(
                          color: MaterialStateColor.resolveWith(
                            (states) {
                              return Colors.blue.shade50;
                            },
                          ),
                          cells: [
                            DataCell(
                              Text(
                                'F/u overdue',
                                style: TextStyle(
                                  fontSize: CustomFontTheme.textSize,
                                  fontWeight: CustomFontTheme.headingwt,
                                ),
                              ),
                            ),
                            for (var vdf in vdfDetails)
                              DataCell(
                                Text(
                                  _generateRandomNumber().toString(),
                                  style: TextStyle(
                                    color: CustomColorTheme.textColor,
                                    fontWeight: CustomFontTheme.headingwt,
                                    fontSize: CustomFontTheme.textSize,
                                  ),
                                ),
                              ),
                            DataCell(
                              Text(
                                _generateRandomNumber().toString(),
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                          ],
                        ),
                        DataRow(
                          color: MaterialStateColor.resolveWith(
                            (states) {
                              return Colors.blue.shade100;
                            },
                          ),
                          cells: [
                            DataCell(
                              Text(
                                'HH with Annual Addl. Income',
                                style: TextStyle(
                                  fontSize: CustomFontTheme.textSize,
                                  fontWeight: CustomFontTheme.headingwt,
                                ),
                              ),
                            ),
                            for (var vdf in vdfDetails)
                              DataCell(
                                Text(
                                  ' ',
                                ),
                              ),
                            DataCell(
                              Text(
                                ' ',
                                style: TextStyle(
                                  fontSize: CustomFontTheme.textSize,
                                  fontWeight: CustomFontTheme.headingwt,
                                ),
                              ),
                            ),
                          ],
                        ),
                        DataRow(
                          color: MaterialStateColor.resolveWith(
                            (states) {
                              return Colors.white;
                            },
                          ),
                          cells: [
                            DataCell(
                              Text(
                                'No. of HH',
                                style: TextStyle(
                                  fontSize: CustomFontTheme.textSize,
                                  fontWeight: CustomFontTheme.headingwt,
                                ),
                              ),
                            ),
                            for (var vdf in vdfDetails)
                              DataCell(
                                Text(
                                  _generateRandomNumber().toString(),
                                  style: TextStyle(
                                    color: CustomColorTheme.textColor,
                                    fontWeight: CustomFontTheme.headingwt,
                                    fontSize: CustomFontTheme.textSize,
                                  ),
                                ),
                              ),
                            DataCell(
                              Text(
                                _generateRandomNumber().toString(),
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                          ],
                        ),
                        DataRow(
                          color: MaterialStateColor.resolveWith(
                            (states) {
                              return Colors.blue.shade50;
                            },
                          ),
                          cells: [
                            DataCell(
                              Text(
                                '0',
                                style: TextStyle(
                                  fontSize: CustomFontTheme.textSize,
                                  fontWeight: CustomFontTheme.headingwt,
                                ),
                              ),
                            ),
                            for (var vdf in vdfDetails)
                              DataCell(
                                Text(
                                  (VdfReportData[0]['10001']
                                              ['zeroAdditionalIncome'] ??
                                          '')
                                      .toString(),
                                  style: TextStyle(
                                    color: CustomColorTheme.textColor,
                                    fontWeight: CustomFontTheme.headingwt,
                                    fontSize: CustomFontTheme.textSize,
                                  ),
                                ),
                              ),
                            DataCell(
                              Text(
                                _generateRandomNumber().toString(),
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                          ],
                        ),
                        DataRow(
                          color: MaterialStateColor.resolveWith(
                            (states) {
                              return Colors.white;
                            },
                          ),
                          cells: [
                            DataCell(
                              Text(
                                '>25k',
                                style: TextStyle(
                                  fontSize: CustomFontTheme.textSize,
                                  fontWeight: CustomFontTheme.headingwt,
                                ),
                              ),
                            ),
                            for (var vdf in vdfDetails)
                              DataCell(
                                Text(
                                  (VdfReportData[0]['10001']
                                              ['lessThan25KIncome'] ??
                                          '')
                                      .toString(),
                                  style: TextStyle(
                                    color: CustomColorTheme.textColor,
                                    fontWeight: CustomFontTheme.headingwt,
                                    fontSize: CustomFontTheme.textSize,
                                  ),
                                ),
                              ),
                            DataCell(
                              Text(
                                _generateRandomNumber().toString(),
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                          ],
                        ),
                        DataRow(
                          color: MaterialStateColor.resolveWith(
                            (states) {
                              return Colors.blue.shade50;
                            },
                          ),
                          cells: [
                            DataCell(
                              Text(
                                '25k-50k',
                                style: TextStyle(
                                  fontSize: CustomFontTheme.textSize,
                                  fontWeight: CustomFontTheme.headingwt,
                                ),
                              ),
                            ),
                            for (var vdf in vdfDetails)
                              DataCell(
                                Text(
                                  (VdfReportData[0]['10001']
                                              ['between25KTO50KIncome'] ??
                                          '')
                                      .toString(),
                                  style: TextStyle(
                                    color: CustomColorTheme.textColor,
                                    fontWeight: CustomFontTheme.headingwt,
                                    fontSize: CustomFontTheme.textSize,
                                  ),
                                ),
                              ),
                            DataCell(
                              Text(
                                _generateRandomNumber().toString(),
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                          ],
                        ),
                        DataRow(
                          color: MaterialStateColor.resolveWith(
                            (states) {
                              return Colors.white;
                            },
                          ),
                          cells: [
                            DataCell(
                              Text(
                                '50k-75L',
                                style: TextStyle(
                                  fontSize: CustomFontTheme.textSize,
                                  fontWeight: CustomFontTheme.headingwt,
                                ),
                              ),
                            ),
                            for (var vdf in vdfDetails)
                              DataCell(
                                Text(
                                  (VdfReportData[0]['10001']
                                              ['between50KTO75KIncome'] ??
                                          '')
                                      .toString(),
                                  style: TextStyle(
                                    color: CustomColorTheme.textColor,
                                    fontWeight: CustomFontTheme.headingwt,
                                    fontSize: CustomFontTheme.textSize,
                                  ),
                                ),
                              ),
                            DataCell(
                              Text(
                                _generateRandomNumber().toString(),
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                          ],
                        ),
                        DataRow(
                          color: MaterialStateColor.resolveWith(
                            (states) {
                              return Colors.blue.shade50;
                            },
                          ),
                          cells: [
                            DataCell(
                              Text(
                                '75L-1L',
                                style: TextStyle(
                                  fontSize: CustomFontTheme.textSize,
                                  fontWeight: CustomFontTheme.headingwt,
                                ),
                              ),
                            ),
                            for (var vdf in vdfDetails)
                              DataCell(
                                Text(
                                  (VdfReportData[0]['10001']
                                              ['between75KTO1LIncome'] ??
                                          '')
                                      .toString(),
                                  style: TextStyle(
                                    color: CustomColorTheme.textColor,
                                    fontWeight: CustomFontTheme.headingwt,
                                    fontSize: CustomFontTheme.textSize,
                                  ),
                                ),
                              ),
                            DataCell(
                              Text(
                                _generateRandomNumber().toString(),
                                style: TextStyle(
                                  color: CustomColorTheme.textColor,
                                  fontWeight: CustomFontTheme.headingwt,
                                  fontSize: CustomFontTheme.textSize,
                                ),
                              ),
                            ),
                          ],
                        ),
                        DataRow(
                          color: MaterialStateColor.resolveWith(
                            (states) {
                              return Colors.white;
                            },
                          ),
                          cells: [
                            DataCell(
                              Text(
                                '>1L',
                                style: TextStyle(
                                  fontSize: CustomFontTheme.textSize,
                                  fontWeight: CustomFontTheme.headingwt,
                                ),
                              ),
                            ),
                            for (var vdf in vdfDetails)
                              DataCell(
                                Text(
                                  (VdfReportData[0]['10001']
                                              ['moreThan1LIncome'] ??
                                          '')
                                      .toString(),
                                  style: TextStyle(
                                    color: CustomColorTheme.textColor,
                                    fontWeight: CustomFontTheme.headingwt,
                                    fontSize: CustomFontTheme.textSize,
                                  ),
                                ),
                              ),
                            DataCell(
                              Text(
                                _generateRandomNumber().toString(),
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
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Function to generate a random number
  int _generateRandomNumber() {
    return 50 + (DateTime.now().millisecondsSinceEpoch % 50);
  }
}
