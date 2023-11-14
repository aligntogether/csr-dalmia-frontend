import 'dart:convert';

import 'package:dalmia/common/bottombar.dart';
import 'package:dalmia/components/reportappbar.dart';
import 'package:dalmia/components/reportpop.dart';
import 'package:dalmia/pages/vdf/Draft/draft.dart';
import 'package:dalmia/pages/vdf/Reports/home.dart';
import 'package:dalmia/pages/vdf/household/addhouse.dart';
import 'package:dalmia/pages/vdf/street/Addstreet.dart';
import 'package:dalmia/pages/vdf/vdfhome.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:http/http.dart' as http;

class BusinessPlan extends StatefulWidget {
  const BusinessPlan({Key? key}) : super(key: key);

  @override
  State<BusinessPlan> createState() => _BusinessPlanState();
}

class _BusinessPlanState extends State<BusinessPlan> {
  int? selectedRadio;
  int selectedIndex = 0; // Track the currently selected tab index

  void _onTabTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
    if (selectedIndex == 0) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const VdfHome(),
        ),
      );
    } else if (selectedIndex == 1) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => MyForm(),
        ),
      );
    } else if (selectedIndex == 2) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => AddStreet(),
        ),
      );
    } else if (selectedIndex == 3) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const Draft(),
        ),
      );
    }
  }

  List<Map<String, dynamic>> businessData = []; // List to store API data

  @override
  void initState() {
    super.initState();
    fetchbusinessData(); // Call the method to fetch API data when the page initializes
  }

  Future<void> fetchbusinessData() async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://192.168.1.24:8080/get-business-plans-engaged?vdfId=10001'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);

        setState(() {
          businessData = List<Map<String, dynamic>>.from(jsonData['resp_body']);
        });
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(100),
            child: ReportAppBar(
              heading: 'Reports',
            )),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Row(
                        children: [
                          Icon(
                            Icons.keyboard_arrow_left_outlined,
                            color: Colors.black,
                          ),
                          Text(
                            'Back',
                            style: TextStyle(color: Colors.black),
                          )
                        ],
                      ),
                    ),
                    viewotherbtn(context),
                  ],
                ),
                const SizedBox(height: 20),
                Center(
                  child: Column(
                    children: [
                      const Text(
                        ' Business Plans Engaged',
                        style: TextStyle(
                            fontSize: CustomFontTheme.textSize,
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 5,
                          child: DataTable(
                            decoration: const BoxDecoration(
                              color: Color(0xFF008CD3),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                            ),
                            columns: const [
                              DataColumn(
                                label: Text(
                                  'Sno.',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Business Plan Titles',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Total HHs',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                            rows: businessData.map<DataRow>((data) {
                              return DataRow(
                                color: MaterialStateColor.resolveWith(
                                  (states) {
                                    // Alternating row colors
                                    return businessData.indexOf(data).isOdd
                                        ? Colors.lightBlue[50] as Color
                                        : Colors.white as Color;
                                  },
                                ),
                                cells: <DataCell>[
                                  DataCell(Text((businessData.indexOf(data) + 1)
                                      .toString())),
                                  DataCell(
                                      Text(data['interventionName'] ?? '')),
                                  DataCell(Text(
                                      data['householdCount']?.toString() ??
                                          '')),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 10,
          child: SizedBox(
            height: 67,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomTabItem(
                  imagePath: 'images/Dashboard_Outline.svg',
                  label: "Dashboard",
                  index: 0,
                  selectedIndex: 5,
                  onTabTapped: _onTabTapped,
                ),
                CustomTabItem(
                  imagePath: 'images/Household_Outline.svg',
                  label: "Add Household",
                  index: 1,
                  selectedIndex: 5,
                  onTabTapped: _onTabTapped,
                ),
                CustomTabItem(
                  imagePath: 'images/Street_Outline.svg',
                  label: "Add Street",
                  index: 2,
                  selectedIndex: 5,
                  onTabTapped: _onTabTapped,
                ),
                CustomTabItem(
                  imagePath: 'images/Drafts_Outline.svg',
                  label: "Drafts",
                  index: 3,
                  selectedIndex: 5,
                  onTabTapped: _onTabTapped,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
