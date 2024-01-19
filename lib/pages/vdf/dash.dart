import 'dart:convert';

import 'package:dalmia/components/cards.dart';
import 'package:dalmia/pages/vdf/street/Addstreet.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../common/size_constant.dart';

class DashTab extends StatefulWidget {
  @override
  State<DashTab> createState() => _DashTabState();
}

class _DashTabState extends State<DashTab> {
  Map<String, dynamic> apiData = {
    "totalHouseholds": 0,
    "mappedHouseholds": 0,
    "selectedHouseholds": 0,
    "householdsCovered": 0,
    "interventionPlanned": 0,
    "interventionCompleted": 0,
    "overdue": 0,
    "equalToZero": 0,
    "lessThan25K": 0,
    "between25KTo50K": 0,
    "between50KTo75K": 0,
    "between75KTo1L": 0,
    "moreThan1L": 0,
  };

  @override
  void initState() {
    super.initState();
    fetchApiData();
  }

  Future<void> fetchApiData() async {
    final apiUrl = '$base/get-home-page-data?vdfId=10001';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final responseData =
            json.decode(response.body)['resp_body'] as Map<String, dynamic>;

        setState(() {
          apiData = responseData;
        });
      } else {
        throw Exception('Failed to load API data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 10, bottom: 10),
                  child: const Text(
                    'Households Summary',
                    style: TextStyle(
                      fontSize: CustomFontTheme.headingSize,
                      fontWeight: CustomFontTheme.headingwt,
                    ),
                  ),
                ),
                FractionallySizedBox(
                    widthFactor: 1.0,
                    child: Wrap(
                      alignment: WrapAlignment.spaceAround,
                      // spacing: 50,
                      children: [
                        CustomCard(
                          imageUrl: 'images/t_house.svg',
                          subtitle: 'Total Household',
                          title: apiData['totalHouseholds'].toString(),
                          bordercolor:
                              Colors.black.withOpacity(0.10000000149011612),
                          bg: Color(0xFFF2D4C9),

                          // bg: Colors.white,
                          textcolor: const Color(0xFFB94216),
                        ),
                        CustomCard(
                          imageUrl: 'images/m_house.svg',
                          title: apiData['mappedHouseholds'].toString(),
                          subtitle: 'Mapped Household',
                          bordercolor:
                              Colors.black.withOpacity(0.10000000149011612),
                          bg: Color(0xFFF2D4C9),
                          textcolor: const Color(0xFFB94216),
                        ),
                        CustomCard(
                          imageUrl: 'images/s_house.svg',
                          title: apiData['selectedHouseholds'].toString(),
                          subtitle: 'Selected for Intervention',
                          bordercolor:
                              Colors.black.withOpacity(0.10000000149011612),
                          bg: Color(0xFFF2D4C9),
                          textcolor: const Color(0xFFB94216),
                        ),
                      ],
                    ))
              ],
            ),
             SizedBox(
              height: MySize.screenHeight*(40/MySize.screenHeight),
            ),
            Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 10, bottom: 10),
                  child: const Text(
                    'Interventions',
                    style: TextStyle(
                      fontSize: CustomFontTheme.headingSize,
                      fontWeight: CustomFontTheme.headingwt,
                    ),
                  ),
                ),
                FractionallySizedBox(
                    widthFactor: 1.0,
                    child: Wrap(
                      alignment: WrapAlignment.spaceAround,
                      children: [
                        CustomCard(
                          imageUrl: 'images/i_house.svg',
                          subtitle: 'Household covered',
                          bordercolor:
                              Colors.black.withOpacity(0.10000000149011612),
                          title: apiData['householdsCovered'].toString(),
                          bg: Color(0xFFC2D7CD),
                          textcolor: const Color(0xFF0C7243),
                        ),
                        CustomCard(
                          imageUrl: 'images/i_planned.svg',
                          title: apiData['interventionPlanned'].toString(),
                          bordercolor:
                              Colors.black.withOpacity(0.10000000149011612),
                          subtitle: 'Intervention planned',
                          bg: Color(0xFFC2D7CD),
                          textcolor: const Color(0xFF0C7243),
                        ),
                        CustomCard(
                          imageUrl: 'images/icompleted.svg',
                          title: apiData['interventionCompleted'].toString(),
                          bordercolor:
                              Colors.black.withOpacity(0.10000000149011612),
                          bg: Color(0xFFC2D7CD),
                          subtitle: 'Interventions completed',
                          textcolor: const Color(0xFF0C7243),
                        ),
                      ],
                    ))
              ],
            ),
             SizedBox(
              height: MySize.screenHeight*(40/MySize.screenHeight),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 10, bottom: 10),
                  child: const Text(
                    'Follow up',
                    style: TextStyle(
                      fontSize: CustomFontTheme.headingSize,
                      fontWeight: CustomFontTheme.headingwt,
                    ),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: 1.0,
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    children: [
                      Container(
                        child: CustomCard(
                          imageUrl: 'images/overdue.svg',
                          subtitle: 'Overdue',
                          bordercolor:
                              Colors.black.withOpacity(0.10000000149011612),
                          title: apiData['overdue'].toString(),
                          bg: Color(0xFFC2D3E3),
                          textcolor: const Color(0xFF064F96),
                        ),
                      ),
                      const SizedBox(
                        width: 120,
                      ),
                      const SizedBox(
                        width: 120,
                      ),
                    ],
                  ),
                )
              ],
            ),
             SizedBox(
              height: MySize.screenHeight*(40/MySize.screenHeight),
            ),
            Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 10, bottom: 0, top: 0),
                  child: RichText(
                    text: const TextSpan(
                      style: TextStyle(fontSize: 16, color: Colors.black),
                      children: [
                        TextSpan(
                          text: 'Household with additional\n income',
                          style: TextStyle(
                            fontSize: CustomFontTheme.headingSize,
                            fontWeight: CustomFontTheme.headingwt,
                          ),
                        ),
                        TextSpan(text: ' (per annum)\n'),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 00),
                  child: FractionallySizedBox(
                    widthFactor: 1.0,
                    child: Wrap(
                      alignment: WrapAlignment.spaceAround,
                      // spacing: 10,
                      // runSpacing: 20, // Adjust this value as needed
                      children: [
                        CustomCard(
                          imageUrl: 'images/income.svg',
                          subtitle: 'Less than 25k',
                          title: apiData['lessThan25K'].toString()=="null"?"0":apiData['lessThan25K'].toString(),
                          bordercolor:
                              Colors.black.withOpacity(0.10000000149011612),
                          bg: const Color(0xFFC2DEEC),
                          textcolor: const Color(0xFF0374AD),
                        ),
                        CustomCard(
                          imageUrl: 'images/income.svg',
                          title: apiData['between25KTo50K'].toString()=="null"?"0":apiData['between25KTo50K'].toString(),
                          bordercolor:
                              Colors.black.withOpacity(0.10000000149011612),
                          subtitle: '25k to 50k',
                          bg: const Color(0xFFC2DEEC),
                          textcolor: const Color(0xFF0374AD),
                        ),
                        CustomCard(
                          imageUrl: 'images/income.svg',
                          title: apiData['between50KTo75K'].toString()=="null"?"0":apiData['between50KTo75K'].toString(),
                          subtitle: '50k to 75k',
                          bg: const Color(0xFFC2DEEC),
                          bordercolor:
                              Colors.black.withOpacity(0.10000000149011612),
                          textcolor: const Color(0xFF0374AD),
                        ),
                        CustomCard(
                          imageUrl: 'images/income.svg',
                          title: apiData['between75KTo1L'].toString()=="null"?"0":apiData['between75KTo1L'].toString(),
                          subtitle: '75k to 1L',
                          bordercolor:
                              Colors.black.withOpacity(0.10000000149011612),
                          bg: const Color(0xFFC2DEEC),
                          textcolor: const Color(0xFF0374AD),
                        ),
                        CustomCard(
                          imageUrl: 'images/income.svg',
                          title: apiData['moreThan1L'].toString(),
                          subtitle: 'More than 1L',
                          bordercolor:
                              Colors.black.withOpacity(0.10000000149011612),
                          bg: const Color(0xFFC2DEEC),
                          textcolor: const Color(0xFF0374AD),
                        ),
                        CustomCard(
                          imageUrl: 'images/income.svg',
                          title: apiData['equalToZero'].toString(),
                          subtitle: 'Zero Income',
                          bordercolor:
                              Colors.black.withOpacity(0.10000000149011612),
                          bg: const Color(0xFFC2DEEC),
                          textcolor: const Color(0xFF0374AD),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
