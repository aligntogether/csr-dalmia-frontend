import 'dart:convert';
import 'package:dalmia/pages/vdf/street/Addstreet.dart';
import 'package:http/http.dart' as http;
import 'package:dalmia/pages/CDO/cdoappbar.dart';
import 'package:dalmia/pages/CDO/cdohome.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';

class SourceOfFunds extends StatefulWidget {
  const SourceOfFunds({Key? key}) : super(key: key);

  @override
  State<SourceOfFunds> createState() => _SourceOfFundsState();
}

class _SourceOfFundsState extends State<SourceOfFunds> {
  List<Map<String, dynamic>> sourceOfFundsData = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(
      Uri.parse(
        '$base/source-of-funds?locationId=10001',
      ),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      final Map<String, dynamic> respBody = responseData['resp_body'];

      // Handle the case where 'resp_body' is a Map
      sourceOfFundsData = [respBody];
    } else {
      // Handle error
      print('Error fetching data: ${response.statusCode}');
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // Assuming sourceOfFundsData is a List<Map<String, dynamic>>

    int totalhh = sourceOfFundsData.fold<int>(
      0,
      (prev, curr) => prev + curr.values.first['noOfHouseholds'] as int,
    );

    double totalbeneficiary = sourceOfFundsData.fold<double>(
      0,
      (prev, curr) => prev + curr.values.first['beneficiary'] as double,
    );

    double totalsubsidy = sourceOfFundsData.fold<double>(
      0,
      (prev, curr) => prev + curr.values.first['subsidy'] as double,
    );

    double totalcredit = sourceOfFundsData.fold<double>(
      0,
      (prev, curr) => prev + curr.values.first['credits'] as double,
    );

    double totaldbf = sourceOfFundsData.fold<double>(
      0,
      (prev, curr) => prev + curr.values.first['dbf'] as double,
    );

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: CdoAppBar(
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
                            sourceOfFundsData.length,
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
                                    sourceOfFundsData[0].keys.elementAt(index),
                                    style: TextStyle(
                                      fontSize: CustomFontTheme.textSize,
                                      fontWeight: CustomFontTheme.headingwt,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    sourceOfFundsData[0][sourceOfFundsData[0]
                                            .keys
                                            .elementAt(index)]['noOfHouseholds']
                                        .toString(),
                                    style: TextStyle(
                                        color: CustomColorTheme.textColor,
                                        fontSize: CustomFontTheme.textSize),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    sourceOfFundsData[0][sourceOfFundsData[0]
                                            .keys
                                            .elementAt(index)]['beneficiary']
                                        .toString(),
                                    style: TextStyle(
                                        color: CustomColorTheme.textColor,
                                        fontSize: CustomFontTheme.textSize),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    sourceOfFundsData[0][sourceOfFundsData[0]
                                            .keys
                                            .elementAt(index)]['subsidy']
                                        .toString(),
                                    style: TextStyle(
                                        color: CustomColorTheme.textColor,
                                        fontSize: CustomFontTheme.textSize),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    sourceOfFundsData[0][sourceOfFundsData[0]
                                            .keys
                                            .elementAt(index)]['credits']
                                        .toString(),
                                    style: TextStyle(
                                        color: CustomColorTheme.textColor,
                                        fontSize: CustomFontTheme.textSize),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    sourceOfFundsData[0][sourceOfFundsData[0]
                                            .keys
                                            .elementAt(index)]['dbf']
                                        .toString(),
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
