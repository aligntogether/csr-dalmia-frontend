import 'dart:convert';

import 'package:dalmia/pages/CDO/actiondetails.dart';
import 'package:dalmia/pages/CDO/cdoappbar.dart';
import 'package:dalmia/pages/CDO/cdohome.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../common/size_constant.dart';
class ActionAgainstHH extends StatefulWidget {
  String locationId;
   ActionAgainstHH({Key? key,required this.locationId}) : super(key: key);

  @override
  State<ActionAgainstHH> createState() => _ActionAgainstHHState();
}

class _ActionAgainstHHState extends State<ActionAgainstHH> {
  List<Map<String, String>> householdData = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(
      Uri.parse(
        'https://mobileqacloud.dalmiabharat.com:443/csr/action-dropped-household-details?locationId=${widget.locationId}',
      ),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<dynamic> respBody = responseData['resp_body'];

      setState(() {
        householdData = List<Map<String, String>>.from(
          respBody.map<Map<String, String>>(
            (dynamic item) => {
              'familyHead': item['familyHead'] as String,
              'vdfName': item['vdfName'] as String,
              'hhid': item['hhid'] as String,
            },
          ),
        );
      });
    } else {
      // Handle error
      print('Error fetching data: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: CdoAppBar(
          heading: 'Drop or Select HH for Int.',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
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
                    const Icon(
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
              const SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  dividerThickness: 0,
                  columns: const <DataColumn>[
                    DataColumn(
                      label: Text(
                        'HHID',
                        style: TextStyle(
                          fontWeight: CustomFontTheme.headingwt,
                          fontSize: CustomFontTheme.textSize,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Family Head',
                        style: TextStyle(
                          fontWeight: CustomFontTheme.headingwt,
                          fontSize: CustomFontTheme.textSize,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'VDF Name',
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
                    householdData.length,
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
                                  builder: (context) => ActionDetail(
                                    hhid: householdData[index]['hhid']!,
                                    locationId: widget.locationId,
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              householdData[index]['hhid']!,
                              style: const TextStyle(
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
                            householdData[index]['familyHead']!,
                            style: const TextStyle(
                              color: CustomColorTheme.textColor,
                              fontWeight: CustomFontTheme.headingwt,
                              fontSize: CustomFontTheme.textSize,
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            householdData[index]['vdfName']!,
                            style: const TextStyle(
                              color: CustomColorTheme.textColor,
                              fontWeight: CustomFontTheme.headingwt,
                              fontSize: CustomFontTheme.textSize,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
