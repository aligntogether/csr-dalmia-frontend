import 'dart:convert';

import 'package:dalmia/common/bottombar.dart';
import 'package:dalmia/common/navmenu.dart';

import 'package:dalmia/pages/vdf/Draft/draft.dart';

import 'package:dalmia/pages/vdf/Reports/home.dart';

import 'package:dalmia/pages/vdf/Reports/updateinter.dart';
import 'package:dalmia/pages/vdf/household/addhead.dart';
import 'package:dalmia/pages/vdf/household/addhouse.dart';
import 'package:dalmia/pages/vdf/intervention/Addinter.dart';
import 'package:dalmia/pages/vdf/intervention/Followup.dart';
import 'package:dalmia/pages/vdf/street/Addstreet.dart';
import 'package:dalmia/pages/vdf/vdfhome.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;

class Panchayat {
  final String panchayatId;
  final String clusterId;
  final String panchayatName;

  Panchayat(this.panchayatId, this.clusterId, this.panchayatName);

  factory Panchayat.fromJson(Map<String, dynamic> json) {
    return Panchayat(
      json['panchayatId'].toString(),
      json['clusterId'].toString(),
      json['panchayatName'].toString(),
    );
  }
}

class Village {
  final String villageid;
  final String village;
  final String panchayatId;

  Village(this.villageid, this.village, this.panchayatId);

  factory Village.fromJson(Map<String, dynamic> json) {
    return Village(
      json['villageId'].toString(),
      json['villageName'].toString(),
      json['panchayatId'].toString(),
    );
  }
}

class Street {
  final String streetid;
  final String street;
  final String villageId;

  Street(this.streetid, this.street, this.villageId);

  factory Street.fromJson(Map<String, dynamic> json) {
    return Street(
      json['streetId'].toString(),
      json['streetName'].toString(),
      json['villageId'].toString(),
    );
  }
}

class HhidForm extends StatefulWidget {
  const HhidForm({super.key});

  @override
  State<HhidForm> createState() => _HhidFormState();
}

class _HhidFormState extends State<HhidForm> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedPanchayat;
  String? _selectedVillage;
  String? _selectedStreet;

  List<Panchayat> panchayats = [];
  List<Village> villages = [];
  List<Street> streets = [];
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

  bool isreportMenuOpen = false;
  void _toggleMenu() {
    setState(() {
      isreportMenuOpen = !isreportMenuOpen;
    });
  }

  int selectedIndex = 0;
  List<Map<String, dynamic>> addincomeData = [];

  Future<List<Map<String, dynamic>>> fetchaddincomeData(String hhid) async {
    final String apiUrl =
        '$base/interventions-additional-income-active?hhid=$hhid';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);

        if (jsonData['resp_code'] == 200) {
          final List<dynamic> respBody = jsonData['resp_body'];

          List<Map<String, String>> extractedData = [];

          for (var data in respBody) {
            // Extracting each entry in resp_body
            Map<String, String> entry = {};
            entry[data.keys.first.toString()] = data.values.first.toString();
            extractedData.add(entry);
          }

          return extractedData;
        } else {
          throw Exception(
              'API request failed with status ${jsonData['resp_code']}');
        }
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw e; // Rethrow the exception to handle it elsewhere if needed
    }
  }

  List<Map<String, dynamic>> updatecompletionData = [];
  Future<List<Map<String, dynamic>>> fetchupdateData(String hhid) async {
    final String apiUrl =
        '$base/interventions-completion-date-active?hhid=$hhid';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);

        if (jsonData['resp_code'] == 200) {
          final List<dynamic> respBody = jsonData['resp_body'];

          List<Map<String, String>> extractedData = [];

          for (var data in respBody) {
            // Extracting each entry in resp_body
            Map<String, String> entry = {};
            entry[data.keys.first.toString()] = data.values.first.toString();
            extractedData.add(entry);
          }

          return extractedData;
        } else {
          throw Exception(
              'API request failed with status ${jsonData['resp_code']}');
        }
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw e; // Rethrow the exception to handle it elsewhere if needed
    }
  }

  @override
  Widget build(BuildContext context) {
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
                        'Cumulative Household Details',
                        style: TextStyle(
                            fontSize: CustomFontTheme.textSize,
                            fontWeight: CustomFontTheme.headingwt),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Form(
                          key: _formKey,
                          child: Container(
                            padding: const EdgeInsets.only(top: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(height: 20),
                                Column(
                                  children: [
                                    const SizedBox(height: 20),
                                    DropdownButtonFormField<String>(
                                      value: _selectedPanchayat,
                                      items:
                                          panchayats.map((Panchayat panchayat) {
                                        return DropdownMenuItem<String>(
                                          value: panchayat.panchayatId,
                                          child: Text(
                                            panchayat.panchayatName,
                                            style: TextStyle(
                                              color: Color(0xFF181818),
                                              fontWeight: _selectedPanchayat ==
                                                      panchayat.panchayatId
                                                  ? CustomFontTheme
                                                      .labelwt // FontWeight for selected item
                                                  : CustomFontTheme
                                                      .textwt, // FontWeight for other items
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) async {
                                        if (newValue != null) {
                                          setState(() {
                                            _selectedPanchayat = newValue;
                                            _selectedVillage = null;
                                            _selectedStreet = null;
                                            fetchVillages(newValue)
                                                .then((value) {
                                              setState(() {
                                                villages =
                                                    value.cast<Village>();
                                              });
                                            });
                                          });
                                        }
                                      },
                                      icon: const Icon(
                                        Icons.keyboard_arrow_down_sharp,
                                        color: CustomColorTheme.iconColor,
                                      ),
                                      decoration: InputDecoration(
                                        labelText: 'Select a Panchayat',
                                        labelStyle: TextStyle(
                                            color: CustomColorTheme.labelColor),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Panchayat is required';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 20),
                                    DropdownButtonFormField<String>(
                                      value: _selectedVillage,
                                      items: villages
                                          // .where((village) =>
                                          //     village.panchayatId == _selectedPanchayat)
                                          .map((Village village) {
                                        return DropdownMenuItem<String>(
                                          value: village.villageid,
                                          child: Text(village.village,
                                              style: TextStyle(
                                                fontWeight: _selectedVillage ==
                                                        village.villageid
                                                    ? CustomFontTheme
                                                        .labelwt // FontWeight for selected item
                                                    : CustomFontTheme.textwt,
                                                color: Color(0xFF181818),
                                              )),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) async {
                                        if (newValue != null) {
                                          setState(() {
                                            _selectedVillage = newValue;
                                            _selectedStreet = null;
                                            fetchStreets(newValue)
                                                .then((value) {
                                              setState(() {
                                                streets = value.cast<Street>();
                                              });
                                            });
                                          });
                                        }
                                      },
                                      icon: const Icon(
                                        Icons.keyboard_arrow_down_sharp,
                                        color: CustomColorTheme.iconColor,
                                      ),
                                      decoration: InputDecoration(
                                        labelText: 'Select a Village',
                                        labelStyle: TextStyle(
                                            color: CustomColorTheme.labelColor),
                                      ),
                                      validator: (value) {
                                        if (_selectedPanchayat == null ||
                                            value == null ||
                                            value.isEmpty) {
                                          return 'Village is required';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 20),
                                    DropdownButtonFormField<String>(
                                      value: _selectedStreet,
                                      items: streets
                                          // .where((street) =>
                                          //     street.villageId == _selectedVillage)
                                          .map((Street street) {
                                        return DropdownMenuItem<String>(
                                          value: street.streetid,
                                          child: Text(street.street,
                                              style: TextStyle(
                                                color: Color(0xFF181818),
                                                fontWeight: _selectedStreet ==
                                                        street.streetid
                                                    ? CustomFontTheme
                                                        .labelwt // FontWeight for selected item
                                                    : CustomFontTheme.textwt,
                                              )),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          _selectedStreet = newValue;
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.keyboard_arrow_down_sharp,
                                        color: CustomColorTheme.iconColor,
                                      ),
                                      decoration: InputDecoration(
                                        labelText: 'Select a Street',
                                        labelStyle: TextStyle(
                                            color: CustomColorTheme.labelColor),
                                      ),
                                      validator: (value) {
                                        if (_selectedVillage == null ||
                                            value == null ||
                                            value.isEmpty) {
                                          return 'Street is required';
                                        }
                                        return null;
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 5,
                          child: DataTable(
                            dividerThickness: 00,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                            ),
                            columns: const <DataColumn>[
                              DataColumn(
                                label: Text(
                                  'HHID',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Selected',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Names',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Intervention planned',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Intervention completed',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Expected additional income p/a',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Actual annual income',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                              DataColumn(
                                label: Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        'Follow ups for income update',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('int.1',
                                              style: TextStyle(
                                                  color: Colors.white)),
                                          Text('int.2',
                                              style: TextStyle(
                                                  color: Colors.white)),
                                          Text('int.3',
                                              style: TextStyle(
                                                  color: Colors.white)),
                                          Text('int.4',
                                              style: TextStyle(
                                                  color: Colors.white)),
                                          Text('int.5',
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                            headingRowColor: MaterialStateColor.resolveWith(
                                (states) => Color(0xFF008CD3)),
                            rows: <DataRow>[
                              DataRow(
                                cells: <DataCell>[
                                  DataCell(
                                    InkWell(
                                      onTap: () {
                                        _takeaction(context, 'DPKDMKS003');
                                      },
                                      child: const Text(
                                        'DPKDMKS003',
                                        style: TextStyle(
                                          color: CustomColorTheme.iconColor,
                                          decoration: TextDecoration.underline,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const DataCell(Text('Yes')),
                                  const DataCell(Text('John Doe')),
                                  const DataCell(Text('Intervention 1')),
                                  const DataCell(Text('Yes')),
                                  const DataCell(Text('500')),
                                  const DataCell(Text('600')),
                                  const DataCell(Text('')),
                                ],
                              ),
                              DataRow(
                                cells: <DataCell>[
                                  DataCell(
                                    InkWell(
                                      onTap: () {
                                        _takeaction(context, 'DPKDMKS003');
                                      },
                                      child: const Text(
                                        'DPKDMKS003',
                                        style: TextStyle(
                                          color: CustomColorTheme.iconColor,
                                          decoration: TextDecoration.underline,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const DataCell(Text('No')),
                                  const DataCell(Text('Jane Smith')),
                                  const DataCell(Text('Intervention 2')),
                                  const DataCell(Text('No')),
                                  const DataCell(Text('300')),
                                  const DataCell(Text('400')),
                                  const DataCell(Text('')),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            side: const BorderSide(
                                width: 1, color: CustomColorTheme.primaryColor),
                            minimumSize: const Size(80, 50),
                            backgroundColor: CustomColorTheme.backgroundColor),
                        onPressed: () {},
                        child: Row(
                          children: [
                            SvgPicture.asset('images/Excel.svg'),
                            const Text(
                              'Download  Excel',
                              style: TextStyle(
                                  color: CustomColorTheme.primaryColor),
                            ),
                          ],
                        )),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(80, 50),
                            side: const BorderSide(
                                width: 1, color: CustomColorTheme.primaryColor),
                            backgroundColor: CustomColorTheme.backgroundColor),
                        onPressed: () {},
                        child: Row(
                          children: [
                            SvgPicture.asset('images/pdf.svg'),
                            const Text(
                              'Download PDF',
                              style: TextStyle(
                                  color: CustomColorTheme.primaryColor),
                            ),
                          ],
                        )),
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
      ),
    );
  }

  Future<void> _takeaction(BuildContext context, String hhid) async {
    addincomeData = await fetchaddincomeData(hhid);
    updatecompletionData = await fetchupdateData(hhid);
    bool additionalinactive = addincomeData.isEmpty;
    bool updateinactive = updatecompletionData.isEmpty;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return AlertDialog(
              // contentPadding: EdgeInsets.all(70),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    children: [
                      Text(
                        'What action do you wish to take for HHID -$hhid',
                        // textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: CustomFontTheme.textSize,
                          fontWeight: CustomFontTheme.headingwt,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const Icon(Icons.close),
                      ),
                    ],
                  ),
                  RadioListTile<int>(
                    activeColor: CustomColorTheme.iconColor,
                    selectedTileColor: CustomColorTheme.iconColor,
                    title: Text(
                      'Add Interventions',
                      style: TextStyle(
                          fontSize: CustomFontTheme.textSize,
                          color: CustomColorTheme.textColor),
                    ),
                    value: 1,
                    groupValue: selectedRadio,
                    onChanged: (value) {
                      setState(() {
                        selectedRadio = value;
                      });
                    },
                  ),
                  IgnorePointer(
                    ignoring: updateinactive,
                    child: RadioListTile<int>(
                      activeColor: CustomColorTheme.iconColor,
                      selectedTileColor: CustomColorTheme.iconColor,
                      title: Text(
                        'Update Completion Date',
                        style: TextStyle(
                            fontSize: CustomFontTheme.textSize,
                            color: updateinactive
                                ? CustomColorTheme.labelColor
                                : CustomColorTheme.textColor),
                      ),
                      value: 2,
                      groupValue: selectedRadio,
                      onChanged: (value) {
                        setState(() {
                          selectedRadio = value;
                        });
                      },
                    ),
                  ),
                  IgnorePointer(
                    ignoring: additionalinactive,
                    child: RadioListTile<int>(
                      activeColor: CustomColorTheme.iconColor,
                      selectedTileColor: CustomColorTheme.iconColor,
                      title: Text(
                        'Add Additional Income',
                        style: TextStyle(
                          fontSize: CustomFontTheme.textSize,
                          color: additionalinactive
                              ? CustomColorTheme.labelColor
                              : CustomColorTheme.textColor,
                        ),
                      ),
                      value: 3,
                      groupValue: selectedRadio,
                      onChanged: (value) {
                        setState(() {
                          selectedRadio = value;
                        });
                      },
                    ),
                  ),
                  RadioListTile<int>(
                    activeColor: CustomColorTheme.iconColor,
                    selectedTileColor: CustomColorTheme.iconColor,
                    title: const Text(
                      'Update Household Details',
                      style: TextStyle(
                          fontSize: CustomFontTheme.textSize,
                          color: CustomColorTheme.textColor),
                    ),
                    value: 4,
                    groupValue: selectedRadio,
                    onChanged: (value) {
                      setState(() {
                        selectedRadio = value;
                      });
                    },
                  ),
                ],
              ),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustomColorTheme.primaryColor,
                        minimumSize: const Size(250, 50),
                      ),
                      onPressed: () {
                        if (selectedRadio == 1) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => Addinter(),
                            ),
                          );
                        } else if (selectedRadio == 2) {
                          Navigator.of(context).pop();
                          _updatecompletion(context, hhid);
                        } else if (selectedRadio == 3) {
                          Navigator.of(context).pop();
                          Addadditional(context,
                              hhid); // Navigate to the corresponding tab
                        } else if (selectedRadio == 4) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const AddHead(),
                            ),
                          );
                          // Navigate to the corresponding tab
                        }
                      },
                      child: const Text('Continue'),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _updatecompletion(BuildContext context, String hhid) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(hhid),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const Icon(Icons.close),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Update Completion Date',
                    style: TextStyle(
                        fontSize: CustomFontTheme.textSize,
                        fontWeight: CustomFontTheme.headingwt),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: updatecompletionData.map<Widget>((data) {
                        return RadioListTile<int>(
                          activeColor: CustomColorTheme.iconColor,
                          selectedTileColor: CustomColorTheme.iconColor,
                          title: Text(
                            'int.${data.keys.first}    ${data.values.first}',
                            style: TextStyle(
                              fontSize: CustomFontTheme.textSize,
                              fontWeight: CustomFontTheme.headingwt,
                              color: CustomColorTheme.textColor,
                            ),
                          ),
                          value: int.parse(data.keys.first),
                          groupValue: selectedRadio,
                          onChanged: (value) {
                            setState(() {
                              selectedRadio = value;
                            });
                          },
                        );
                      }).toList(),
                    ),
                  )
                ],
              ),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(250, 50),
                          backgroundColor: CustomColorTheme.primaryColor),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Followup(),
                          ),
                        );
                      },
                      child: const Text('Continue'),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void Addadditional(BuildContext context, String hhid) {
    String? interventionid;
    String? interventiontype;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(hhid),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const Icon(Icons.close),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Add Additional Income ',
                    style: TextStyle(
                        fontSize: CustomFontTheme.textSize,
                        fontWeight: CustomFontTheme.headingwt),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: addincomeData.map<Widget>((data) {
                      interventionid = data.keys.first;
                      interventiontype = data.values.first;
                      return RadioListTile<int>(
                        activeColor: CustomColorTheme.iconColor,
                        selectedTileColor: CustomColorTheme.iconColor,
                        title: Text(
                          'int.${data.keys.first}    ${data.values.first}',
                          style: TextStyle(
                            fontSize: CustomFontTheme.textSize,
                            fontWeight: CustomFontTheme.headingwt,
                            color: CustomColorTheme.textColor,
                          ),
                        ),
                        value: int.parse(data.keys.first),
                        groupValue: selectedRadio,
                        onChanged: (value) {
                          setState(() {
                            selectedRadio = value;
                          });
                        },
                      );
                    }).toList(),
                  )
                ],
              ),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(250, 50),
                          backgroundColor: CustomColorTheme.primaryColor),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => UpdateIntervention(
                              hhid: hhid,
                              interventionid: interventionid,
                              interventiontype: interventiontype,
                            ),
                          ),
                        );
                      },
                      child: const Text('Continue'),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
