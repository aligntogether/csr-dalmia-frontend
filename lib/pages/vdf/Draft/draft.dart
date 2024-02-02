import 'package:dalmia/common/bottombar.dart';
import 'package:dalmia/common/navmenu.dart';
import 'package:dalmia/common/size_constant.dart';
import 'package:dalmia/pages/vdf/household/addhead.dart';
import 'package:dalmia/pages/vdf/household/addhouse.dart';
import 'package:dalmia/pages/vdf/street/Addstreet.dart';
import 'package:dalmia/pages/vdf/vdfhome.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dalmia/apis/commonobject.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../Constants/constants.dart';
import '../../../helper/sharedpref.dart';
import '../notifications.dart';

class Draft extends StatefulWidget {
  const Draft({Key? key});

  @override
  State<Draft> createState() => _DraftState();
}




class _DraftState extends State<Draft> {
  int selectedIndex = 0;
  String? SelectedId;
  bool isdraftMenuOpen = false;
  String? refId;

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
    SharedPrefHelper.getSharedPref(USER_ID_SHAREDPREF_KEY, context, false)
        .then((value) => setState(() {
      refId = value;
      fetchDraftHouseholds().then((value) {
        setState(() {
          draftHouseholds = value;

        });

      });
    }));

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
                scrolledUnderElevation: 0,
                backgroundColor: Colors.white,
                title: const Image(image: AssetImage('images/icon.jpg')),
                automaticallyImplyLeading: false,
                actions: <Widget>[
                  CircleAvatar(
                    backgroundColor: CustomColorTheme.primaryColor,
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const Notifications(),
                          ),
                        );
                      },
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
                'Select a row to delete draft HH',
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
                          label: Text('Family\nHead Name',
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
                                   SelectedId = draftHousehold.id;

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
                        backgroundColor: checkedHousehols.length != 1
                            ? MaterialStateProperty.all<Color>(
                                CustomColorTheme.primaryColor.withOpacity(0.5))
                            : MaterialStateProperty.all<Color>(
                                CustomColorTheme.primaryColor),
                      ),
                      onPressed: checkedHousehols.length != 1
                          ? () {
                              return null;
                            }
                          : () {
                              print('selected hid is $SelectedId');
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => AddHead(
                                    vdfid: refId,
                                    id: SelectedId,

                                  ),
                                ),
                              );
                            },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Edit Household',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w500),
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
                      onPressed: checkedHousehols.length != 0
                          ? () {
                        
                        _deleteConfirmationDialog(context);
                        // deleteCheckedHousehold();
                            }
                          : null,
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
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            // color: Colors.white,
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
            // elevation: 10,
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
      ),
    );
  }

  Future<List<DraftHousehold>> fetchDraftHouseholds() async {
    try {
      print("refId is $refId");
      final response = await http.get(
        Uri.parse('$base/get-draft-households'),
        headers: <String, String>{
          'vdfId': refId.toString(),
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

  void _deleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          alignment: Alignment.topCenter,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          titlePadding: EdgeInsets.all(0),
          title: Padding(
            padding: const EdgeInsets.only(top: 10, left: 20, right: 10),
            child: SizedBox(
              width: MySize.screenWidth * (280 / MySize.screenWidth),
              height: MySize.screenHeight * (100 / MySize.screenHeight),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(Icons.close),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 20, right: 10),
                    child: const Text(
                      'Are you sure you want to delete the selected households?',
                      style: TextStyle(
                        fontSize: 16,
                        // fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          content: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: MySize.screenWidth * (100 / MySize.screenWidth),
                height: MySize.screenHeight * (50 / MySize.screenHeight),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    side: const BorderSide(),
                    backgroundColor: CustomColorTheme.primaryColor,
                  ),
                  onPressed: () {
                    deleteCheckedHousehold();
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Yes',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: CustomFontTheme.textSize,
                      fontWeight: CustomFontTheme.labelwt,
                      letterSpacing: 0.84,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 20),
              SizedBox(
               width: MySize.screenWidth * (100 / MySize.screenWidth),
                height: MySize.screenHeight * (50 / MySize.screenHeight),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    side: const BorderSide(),
                    backgroundColor: Colors.white,
                  ),
                  onPressed: () {
                    // deleteCheckedHousehold();
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'NO',
                    style: TextStyle(
                      color: CustomColorTheme.primaryColor,
                      fontSize: CustomFontTheme.textSize,
                      fontWeight: CustomFontTheme.labelwt,
                      letterSpacing: 0.84,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
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
