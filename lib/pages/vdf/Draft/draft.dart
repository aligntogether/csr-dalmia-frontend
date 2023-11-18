import 'package:dalmia/Constants/constants.dart';
import 'package:dalmia/common/bottombar.dart';
import 'package:dalmia/common/navmenu.dart';
import 'package:dalmia/components/reportappbar.dart';
import 'package:dalmia/pages/vdf/household/addhouse.dart';
import 'package:dalmia/pages/vdf/street/Addstreet.dart';
import 'package:dalmia/pages/vdf/vdfhome.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dalmia/apis/commonobject.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class Draft extends StatefulWidget {
  const Draft({Key? key});

  @override
  State<Draft> createState() => _DraftState();
}

int selectedIndex = 0;

class _DraftState extends State<Draft> {
  bool isdraftMenuOpen = false;
  void _toggleMenu() {
    setState(() {
      isdraftMenuOpen = !isdraftMenuOpen;
    });
  }

  String? base = dotenv.env['BASE_URL'];
  List<DraftHousehold> draftHouseholds = [];
  Set<String> checkedHousehols = {};
  @override
  void initState() {
    super.initState();
    fetchDraftHouseholds().then((value) {
      setState(() {
        draftHouseholds = value;
      });
    });
  }

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
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(isdraftMenuOpen ? 150 : 100),
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
                    child: const Text(
                      'Drafts',
                      style: TextStyle(
                        fontSize: CustomFontTheme.headingSize,

                        // Adjust the font size
                        fontWeight:
                            CustomFontTheme.headingwt, // Adjust the font weight
                      ),
                    ),
                  ),
                ),
              ),
              if (isdraftMenuOpen) navmenu(context, _toggleMenu),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Center(
                  child: Text(
                'Select a row to edit or delete draft HH',
                style: TextStyle(
                    fontSize: CustomFontTheme.textSize,
                    fontWeight: CustomFontTheme.headingwt),
              )),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                      headingRowColor: MaterialStateColor.resolveWith(
                        (states) => const Color(0xFF008CD3),
                      ),
                      columns: const <DataColumn>[
                        DataColumn(
                          label: Text(
                            ' ',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        DataColumn(
                          label: Text('Date',
                              style: TextStyle(color: Colors.white)),
                        ),
                        DataColumn(
                          label: Text('Family\n Head Name',
                              style: TextStyle(color: Colors.white)),
                        ),
                        DataColumn(
                          label: Text('Street',
                              style: TextStyle(color: Colors.white)),
                        ),
                        DataColumn(
                          label: Text('Village',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ],
                      rows:
                          draftHouseholds.map((DraftHousehold draftHousehold) {
                        return DataRow(cells: <DataCell>[
                          DataCell(
                            Checkbox(
                              value:
                                  checkedHousehols.contains(draftHousehold.id),
                              onChanged: (value) {
                                setState(() {
                                  if (value != null && value) {
                                    checkedHousehols.add(draftHousehold.id);
                                  } else {
                                    checkedHousehols.remove(draftHousehold.id);
                                  }
                                });
                              },
                            ),
                          ),
                          DataCell(Text(draftHousehold
                              .dateOfEnrollment)), // Placeholder date, replace with actual data
                          DataCell(Text(draftHousehold
                              .headName)), // Placeholder name, replace with actual data
                          DataCell(Text(draftHousehold
                              .streetName)), // Placeholder street, replace with actual data
                          DataCell(Text(draftHousehold.villageName)),
                        ]);
                      }).toList()),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0.0),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            CustomColorTheme.primaryColor),
                      ),
                      onPressed: () {},
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Edit Household',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      )),
                  ElevatedButton(
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0.0),
                        side: MaterialStateProperty.all<BorderSide>(
                            const BorderSide(
                                color: CustomColorTheme.primaryColor,
                                width: 1)),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            CustomColorTheme.backgroundColor),
                      ),
                      onPressed: () {
                        deleteCheckedHousehold();
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Delete Household',
                          style:
                              TextStyle(color: CustomColorTheme.primaryColor),
                        ),
                      )),
                ],
              )
            ],
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
                  selectedIndex: 3,
                  onTabTapped: _onTabTapped,
                ),
                CustomTabItem(
                  imagePath: 'images/Household_Outline.svg',
                  label: "Add Household",
                  index: 1,
                  selectedIndex: 3,
                  onTabTapped: _onTabTapped,
                ),
                CustomTabItem(
                  imagePath: 'images/Street_Outline.svg',
                  label: "Add Street",
                  index: 2,
                  selectedIndex: 3,
                  onTabTapped: _onTabTapped,
                ),
                CustomTabItem(
                  imagePath: 'images/draftfill.svg',
                  label: "Drafts",
                  index: 3,
                  selectedIndex: 3,
                  onTabTapped: _onTabTapped,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<List<DraftHousehold>> fetchDraftHouseholds() async {
    try {
      final response = await http.get(
        Uri.parse('$base/get-draft-households'),
        headers: <String, String>{
          'vdfId': '10001',
        },
      );
      if (response.statusCode == 200) {
        CommonObject commonObject =
            CommonObject.fromJson(json.decode(response.body));

        List<dynamic> draftHouseholdsData =
            commonObject.respBody as List<dynamic>;
        List<DraftHousehold> draftHouseholds = draftHouseholdsData
            .map((model) =>
                DraftHousehold.fromJson(model as Map<String, dynamic>))
            .toList();

        return draftHouseholds;
      } else {
        throw Exception('Failed to load panchayats: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  void deleteCheckedHousehold() async {
    try {
      final response = await http.delete(
        Uri.parse('$base/delete-draft'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(checkedHousehols.toList()),
      );
      if (response.statusCode == 200) {
        fetchDraftHouseholds().then((value) {
          setState(() {
            draftHouseholds = value;
          });
        });
      } else {
        throw Exception('Failed to load panchayats: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}

class DraftHousehold {
  final String id;
  final String headName;
  final String villageName;
  final String hhid;
  final String dateOfEnrollment;
  final String streetName;

  DraftHousehold(this.id, this.headName, this.villageName, this.hhid,
      this.dateOfEnrollment, this.streetName);

  factory DraftHousehold.fromJson(Map<String, dynamic> json) {
    return DraftHousehold(
      json['id'].toString(),
      json['memberName'].toString(),
      json['villageName'].toString(),
      json['hhid'].toString(),
      json['dateOfEnrollment'].toString(),
      json['streetName'].toString(),
    );
  }
}
