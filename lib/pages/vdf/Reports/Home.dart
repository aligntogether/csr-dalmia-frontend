import 'package:dalmia/Constants/constants.dart';
import 'package:dalmia/common/bottombar.dart';
import 'package:dalmia/common/build_drawer.dart';
import 'package:dalmia/components/reportappbar.dart';
import 'package:dalmia/components/reportpop.dart';
import 'package:dalmia/pages/vdf/Draft/draft.dart';

import 'package:dalmia/pages/vdf/household/addhouse.dart';
import 'package:dalmia/pages/vdf/street/Addstreet.dart';
import 'package:dalmia/pages/vdf/vdfhome.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeReport extends StatefulWidget {
  const HomeReport({super.key});

  @override
  State<HomeReport> createState() => _HomeReportState();
}

class _HomeReportState extends State<HomeReport> {
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

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: ReportAppBar(
            heading: 'Reports',
          ),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextButton.icon(
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
                    const SizedBox(height: 00),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          width: screenWidth,

                          // decoration: BoxDecoration(

                          //     borderRadius: BorderRadius.circular(20),
                          //     color: Colors.white60),
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
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.calendar_month_outlined,
                                    color: CustomColorTheme.iconColor,
                                  ),
                                  label: const Text(
                                    '01 Jan 2021 - 01 Jan 2023',
                                    style: TextStyle(
                                        color: CustomColorTheme.primaryColor),
                                  )),
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
                                  celldata('Total Households in working area',
                                      '2473'),
                                  celldata('Total Households mapped', '2473'),
                                  celldata(
                                      'Total Households selected for Intervention',
                                      '2473'),
                                  celldata(
                                      'Total Interventions planned', '2473'),
                                  celldata(
                                      'Total Interventions completed', '2473'),
                                  celldata(
                                      'Households earning additional income',
                                      '2473'),

                                  celldata(
                                      'Rs.25K - Rs.50K addl. income', '2473'),
                                  celldata(
                                      'Rs.50K - Rs.75K addl. income', '2473'),
                                  celldata(
                                      'Rs.75K - Rs.1L addl. income', '2473'),
                                  celldata(
                                      'More than Rs.1L addl. income', '2473'),
                                  celldata(
                                      'Aggregated additional income', '2473'),

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
            // if (toggle == true) DrawerWidget()
          ],
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

DataRow celldata(String left, String right) {
  return DataRow(
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
          right,
          style: const TextStyle(
              fontSize: CustomFontTheme.textSize,
              fontWeight: CustomFontTheme.headingwt),
        ),
      ),
    ],
  );
}
