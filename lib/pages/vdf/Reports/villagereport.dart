import 'dart:convert';
import 'dart:math';

import 'package:dalmia/common/bottombar.dart';
import 'package:dalmia/common/navmenu.dart';

import 'package:dalmia/pages/vdf/Draft/draft.dart';
import 'package:dalmia/pages/vdf/Reports/street.dart';
import 'package:http/http.dart' as http;

import 'package:dalmia/pages/vdf/Reports/home.dart';
import 'package:dalmia/pages/vdf/household/addhouse.dart';
import 'package:dalmia/pages/vdf/street/Addstreet.dart';
import 'package:dalmia/pages/vdf/vdfhome.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';

class VillageReport extends StatefulWidget {
  final String? selectedPanchayat;
  final String? selectedPanchayatid;
  const VillageReport(
      {super.key, this.selectedPanchayat, this.selectedPanchayatid});

  @override
  State<VillageReport> createState() => _VillageReportState();
}

class _VillageReportState extends State<VillageReport> {
  bool isreportMenuOpen = false;
  void _toggleMenu() {
    setState(() {
      isreportMenuOpen = !isreportMenuOpen;
    });
  }

  String? Selectedvillage;
  String? Selectedvillageid;
  // int _selectedpanchayatindex = 0;
  // int _selectedvillagetindex = 0;
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

  @override
  void initState() {
    super.initState();
    fetchvillageData(); // Call the method to fetch API data when the page initializes
  }

  List<Map<String, dynamic>> villagetData = [];
  Future<void> fetchvillageData() async {
    try {
      final response = await http.get(
        Uri.parse(
            '$base/report-village-wise?vdfId=10001&panchayatId=${widget.selectedPanchayatid}'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);

        setState(() {
          villagetData = [
            for (var entry in jsonData['resp_body'].entries)
              {
                'villageName': entry.key,
                'incomeFollowUpDue': entry.value['incomeFollowUpDue'],
                'selectedHHWithoutIntervention':
                    entry.value['selectedHHWithoutIntervention'],
                'interventionStartedButNotCompleted':
                    entry.value['interventionStartedButNotCompleted'],
                'villageid': ['villageId']
              }
          ];
        });
      } else {
        print('${widget.selectedPanchayatid}');
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final Random random = Random();
    return SafeArea(
        child: Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(isreportMenuOpen ? 150 : 100),
        child: Stack(
          children: [
            AppBar(
              titleSpacing: 20,
              scrolledUnderElevation: 0,
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
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 0,
                        blurRadius: 4,
                        offset: Offset(0, 4), // changes position of shadow
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.only(left: 30, bottom: 10),
                  alignment: Alignment.topCenter,
                  // color: Colors.white,
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
            crossAxisAlignment: CrossAxisAlignment.center,
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
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
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
              Column(
                children: [
                  const Text(
                    'Cumulative Household Details',
                    style: TextStyle(
                        fontSize: CustomFontTheme.headingSize,
                        fontWeight: CustomFontTheme.labelwt),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    // child: () {
                    //   if (selectedPanchayat ==
                    //       _selectedpanchayatindex.toInt()) {
                    //     return villagetab(random);
                    //   } else if (selectedVillage ==
                    //           'Village ${_selectedvillagetindex + 1}' &&
                    //       selectedPanchayat == null) {
                    //     return streettab(random);
                    //   } else {
                    //     return
                    child: villagetab(random)
                    // }
                    // }()
                    ,
                  )
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0,
              blurRadius: 10,
              offset: Offset(4, 0), // changes position of shadow
            ),
          ],
        ),
        child: BottomAppBar(
          color: Colors.white,
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
    ));
  }

  Widget villagetab(Random random) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(widget.selectedPanchayat!,
              style: TextStyle(
                  fontSize: CustomFontTheme.textSize,
                  fontWeight: CustomFontTheme.labelwt)),
          const Text('Village wise report',
              style: TextStyle(
                  fontSize: CustomFontTheme.textSize,
                  fontWeight: CustomFontTheme.labelwt)),
          SizedBox(
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
                dividerThickness: 0,
                columnSpacing: 15,
                columns: const <DataColumn>[
                  DataColumn(
                    label: Text(
                      'Village Name',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Income follow up Overdue',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Number of selected HHs without intervention',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'No. of Interventions started but not completed',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
                rows: villagetData.map<DataRow>((village) {
                  return DataRow(
                    color: MaterialStateColor.resolveWith((states) {
                      // Alternating row colors
                      return villagetData.indexOf(village) % 2 == 0
                          ? Colors.lightBlue[50]!
                          : Colors.white;
                    }),
                    cells: <DataCell>[
                      DataCell(
                        InkWell(
                          onTap: () {
                            setState(() {
                              Selectedvillage = village['villageName'];
                              Selectedvillageid = village['villageid'];
                            });

                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => StreetReport(
                                        selectedvillage: Selectedvillage,
                                        selectedvillageid: Selectedvillageid,
                                      )),
                            );
                          },
                          child: Text(
                            village['villageName'] ?? '',
                            style: const TextStyle(
                              color: CustomColorTheme.iconColor,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      DataCell(
                        Text('${village['incomeFollowUpDue'] ?? 0}'),
                      ),
                      DataCell(
                        Text(
                            '${village['selectedHHWithoutIntervention'] ?? 0}'),
                      ),
                      DataCell(
                        Text(
                            '${village['interventionStartedButNotCompleted'] ?? 0}'),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
