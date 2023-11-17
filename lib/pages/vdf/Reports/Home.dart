import 'dart:convert';

import 'package:dalmia/common/bottombar.dart';
import 'package:dalmia/common/navmenu.dart';
import 'package:dalmia/components/reportappbar.dart';
import 'package:dalmia/components/reportpop.dart';
import 'package:dalmia/pages/vdf/Draft/draft.dart';

import 'package:dalmia/pages/vdf/household/addhouse.dart';
import 'package:dalmia/pages/vdf/street/Addstreet.dart';
import 'package:dalmia/pages/vdf/vdfhome.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class HomeReport extends StatefulWidget {
  const HomeReport({super.key});

  @override
  State<HomeReport> createState() => _HomeReportState();
}

class _HomeReportState extends State<HomeReport> {
  bool isreportMenuOpen = false;
  void _toggleMenu() {
    setState(() {
      isreportMenuOpen = !isreportMenuOpen;
    });
  }

  int? selectedRadio;
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

  Map<String, dynamic>? reportData;

  Future<void> fetchReportData(
      // DateTime startDate, DateTime endDate
      ) async {
    // final formattedStartDate = DateFormat('dd-MM-yyyy').format(startDate);
    // final formattedEndDate = DateFormat('dd-MM-yyyy').format(endDate);

    final apiUrl =
        // 'http://192.168.1.28:8080/vdf-report?vdfId=10001&fromDate=$formattedStartDate&toDate=$formattedEndDate';
        '$base/vdf-report?vdfId=10001&fromDate=23-09-2023&toDate=24-12-2023';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final respBody = jsonResponse['resp_body'];

      setState(() {
        reportData = respBody;
      });
    }
  }

  @override
  void initState() {
    fetchReportData(
        // _startDate!, _endDate!
        );
    super.initState();
  }

  DateTime? _startDate;
  DateTime? _endDate;

  Future<void> _selectDateRange(BuildContext context) async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
      initialDateRange: _startDate != null && _endDate != null
          ? DateTimeRange(start: _startDate!, end: _endDate!)
          : null,
    );

    if (picked != null && picked.start != null && picked.end != null) {
      setState(() {
        _startDate = picked.start;
        _endDate = picked.end;
      });
    }
  }

  String _formatDate(DateTime date) {
    return DateFormat('dd-MM-yyyy').format(date);
  }

  int selectedIndex = 0;
  // bool isReportMenuOpen = false;

  // void toggleReportMenu() {
  //   setState(() {
  //     isReportMenuOpen = !isReportMenuOpen;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(isreportMenuOpen ? 150 : 100),
          child: Stack(
            children: [
              AppBar(
                titleSpacing: 20,
                backgroundColor: Colors.white,
                title: const Image(image: AssetImage('images/icon.jpg')),
                automaticallyImplyLeading: false,
                actions: <Widget>[
                  CircleAvatar(
                    backgroundColor: CustomColorTheme.primaryColor,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.notifications_none_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  IconButton(
                    iconSize: 30,
                    onPressed: () {
                      _toggleMenu();
                    },
                    icon: const Icon(Icons.menu,
                        color: CustomColorTheme
                            .primaryColor // Update with your color
                        ),
                  ),
                ],
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(50),
                  child: Container(
                    padding: const EdgeInsets.only(left: 30, bottom: 10),
                    alignment: Alignment.topCenter,
                    color: Colors.white,
                    child: Text(
                      'Reports',
                      style: const TextStyle(
                        fontSize: CustomFontTheme.headingSize,

                        // Adjust the font size
                        fontWeight:
                            CustomFontTheme.headingwt, // Adjust the font weight
                      ),
                    ),
                  ),
                ),
              ),
              if (isreportMenuOpen) navmenu(context, _toggleMenu),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                viewotherbtn(context),
                const SizedBox(height: 00),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      width: screenWidth,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x19000000),
                            blurRadius: 20,
                            offset: Offset(0, 10),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              'Report of Balamurugan',
                              style: TextStyle(
                                  fontSize: CustomFontTheme.textSize,
                                  fontWeight: CustomFontTheme.headingwt),
                            ),
                          ),
                          TextButton.icon(
                            onPressed: () => _selectDateRange(context),
                            icon: const Icon(
                              Icons.calendar_month_outlined,
                              color: CustomColorTheme.iconColor,
                            ),
                            label: Text(
                              _startDate != null && _endDate != null
                                  ? '${_formatDate(_startDate!)} - ${_formatDate(_endDate!)}'
                                  : 'Select Date Range',
                              style: const TextStyle(
                                  color: CustomColorTheme.primaryColor),
                            ),
                          ),
                          const Divider(
                            color: Colors
                                .grey, // Add your desired color for the line
                            thickness:
                                1, // Add the desired thickness for the line
                          ),
                          DataTable(
                            // horizontalMargin: 50.0,
                            dividerThickness: 0.0,
                            columns: const <DataColumn>[
                              DataColumn(
                                label: Text(
                                  '',
                                  // style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  '',
                                  // style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                            rows: <DataRow>[
                              celldata(
                                  'Total Households in working area',
                                  reportData == null
                                      ? '000'
                                      : reportData![
                                          'totalHouseholdsInWorkArea'],
                                  Colors.white),
                              celldata(
                                  'Total Households mapped',
                                  reportData == null
                                      ? '000'
                                      : reportData!['totalHouseholdsMapped'],
                                  Colors.white),
                              celldata(
                                  'Total Households selected for Intervention',
                                  reportData == null
                                      ? '000'
                                      : reportData![
                                          'totalHouseholdsSelectedForIntervention'],
                                  Colors.white),
                              celldata(
                                  'Total Interventions planned',
                                  reportData == null
                                      ? '000'
                                      : reportData![
                                          'totalInterventionsPlanned'],
                                  Colors.white),
                              celldata(
                                  'Total Interventions completed',
                                  reportData == null
                                      ? '000'
                                      : reportData![
                                          'totalInterventionsCompleted'],
                                  Colors.white),
                              celldata(
                                  'Households earning additional income',
                                  reportData == null
                                      ? '000'
                                      : reportData![
                                          'householdsEarningAdditionalIncome'],
                                  Colors.white),
                              celldata(
                                  'Zero addl. income',
                                  reportData == null
                                      ? '000'
                                      : reportData!['zeroAdditionalIncome'],
                                  Color(0xFF008CD3).withOpacity(0.1)),
                              celldata(
                                  'Less than Rs.25K addl. income',
                                  reportData == null
                                      ? '000'
                                      : reportData!['zeroAdditionalIncome'],
                                  Color(0xFF008CD3).withOpacity(0.1)),
                              celldata(
                                  'Rs.25K - Rs.50K addl. income',
                                  reportData == null
                                      ? '000'
                                      : reportData!['between25KTO50KIncome'],
                                  Color(0xFF008CD3).withOpacity(0.1)),
                              celldata(
                                  'Rs.50K - Rs.75K addl. income',
                                  reportData == null
                                      ? '000'
                                      : reportData!['between50KTO75KIncome'],
                                  Color(0xFF008CD3).withOpacity(0.1)),
                              celldata(
                                  'Rs.75K - Rs.1L addl. income',
                                  reportData == null
                                      ? '000'
                                      : reportData!['between75KTO1LIncome'],
                                  Color(0xFF008CD3).withOpacity(0.1)),
                              celldata(
                                  'More than Rs.1L addl. income',
                                  reportData == null
                                      ? '000'
                                      : reportData!['moreThan1LIncome'],
                                  Color(0xFF008CD3).withOpacity(0.1)),
                              celldata(
                                  'Aggregated additional income',
                                  reportData == null
                                      ? '000'
                                      : reportData![
                                              'aggregatedAdditionalIncome']
                                          .toString(),
                                  Colors.white),

                              // Add more rows as needed
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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

DataRow celldata(String left, Object? right, Color color) {
  return DataRow(
    color: MaterialStateColor.resolveWith((states) => color),
    cells: <DataCell>[
      DataCell(
        Text(
          left,
          style: const TextStyle(
              fontSize: CustomFontTheme.textSize,
              fontWeight: CustomFontTheme.textwt),
        ),
      ),
      DataCell(
        Text(
          right != null ? right.toString() : "0000",
          style: const TextStyle(
              fontSize: CustomFontTheme.textSize,
              fontWeight: CustomFontTheme.headingwt),
        ),
      ),
    ],
  );
}

Container viewotherbtn(BuildContext context) {
  return Container(
    decoration: ShapeDecoration(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      shadows: [
        const BoxShadow(
          color: Color(0x19000000),
          blurRadius: 10,
          offset: Offset(0, 5),
          spreadRadius: 0,
        )
      ],
    ),
    child: TextButton.icon(
        style: TextButton.styleFrom(
            backgroundColor: const Color(0xFF008CD3),
            foregroundColor: Colors.white),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return ReportPopupWidget(context);
            },
          );
        },
        icon: const Icon(Icons.folder_outlined),
        label: const Text(
          'View other Reports',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        )),
  );
}
