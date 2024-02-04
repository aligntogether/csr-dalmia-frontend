import 'dart:convert';
import 'package:dalmia/common/bottombar.dart';
import 'package:dalmia/common/navmenu.dart';
import 'package:dalmia/pages/vdf/Draft/draft.dart';
import 'package:http/http.dart' as http;
import 'package:dalmia/pages/vdf/household/addhouse.dart';
import 'package:dalmia/pages/vdf/street/Addstreet.dart';
import 'package:dalmia/pages/vdf/vdfhome.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';
class UpdateIntervention extends StatefulWidget {
  final String? interventiontype;
  final String? interventionid;
  final String? hhid;
  const UpdateIntervention(
      {super.key, this.interventionid, this.hhid, this.interventiontype});

  @override
  State<UpdateIntervention> createState() => _UpdateInterventionState();
}

class _UpdateInterventionState extends State<UpdateIntervention> {
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

  int selectedIndex = 0;
  List<Map<String, dynamic>> updateData = []; // List to store API data

  @override
  void initState() {
    super.initState();
    fetchupdateData(); // Call the method to fetch API data when the page initializes
  }

  Future<void> fetchupdateData() async {
    try {
      final response = await http.get(
        Uri.parse(
              '$base/get-income-followup-dates?hhid=${widget.hhid}&interventionId=${widget.interventionid}'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        print("jsonData: $jsonData");

        setState(() {
          updateData = List<Map<String, dynamic>>.from(jsonData['resp_body']);
          print("updateData: $updateData");

        });
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> saveUpdatedData(List<Map<String, dynamic>> updatedData) async {
    try {
      print("updatedData: $updatedData");
      updatedData.forEach((element) {element['amount']=element['followUpAmount'];});
      print("updatedData: ${jsonEncode(updatedData)}");
      print("updatedData: ${widget.hhid}");
      print("sdf${json.encode(
          updatedData.map((e) => {"id": e['id'], "amount": e['amount']})
              .toList())}");
      var headers = {
        'accept': '*/*',
        'Content-Type': 'application/json'
      };
      final response = await http.put(
        Uri.parse(
              '$base/update-income-followup-amount?hhid=${widget.hhid}'),
        headers: headers,
        body: json.encode(updatedData.map((e) => {"id":e['id'],"amount":e['amount']}).toList())
      );

      if (response.statusCode == 200) {

        print("jsonData: ${response.body}");


      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    // final List<int> householdList =
    //     List.generate(10, (index) => random.nextInt(100));
    // final List<int> populationList =
    //     List.generate(10, (index) => random.nextInt(100));

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
                title:  Image.asset(('images/icon.jpg'),
                    height: 40,
                ),
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
                const SizedBox(height: 20),
                Center(
                  child: Column(
                    children: [
                      Text(
                        '${widget.hhid ?? ''}',
                        style: TextStyle(
                            fontSize: CustomFontTheme.textSize,
                            fontWeight: CustomFontTheme.headingwt),
                      ),
                      Text(
                        '${widget.interventiontype ?? ''}',
                        style: TextStyle(
                            fontSize: CustomFontTheme.textSize,
                            fontWeight: CustomFontTheme.labelwt),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Card(
                          // shape: RoundedRectangleBorder(
                          //   // borderRadius: BorderRadius.circular(10.0),
                          // ),
                          elevation: 5,
                          child: DataTable(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                            ),
                            dividerThickness: 00,
                            columns: const <DataColumn>[
                              DataColumn(
                                label: Text(
                                  'Details',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Proposed',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Additional income (Rs.)',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                            headingRowColor: MaterialStateColor.resolveWith(
                                (states) => Color(0xFF008CD3)),
                            rows: updateData.map<DataRow>((data) {
                              return DataRow(
                                cells: <DataCell>[
                                  DataCell(Text('Follow up ${data['id']}')),
                                  DataCell(Text('${new DateTime.fromMicrosecondsSinceEpoch(data['followUpDate']*1000).day}-${new DateTime.fromMicrosecondsSinceEpoch(data['followUpDate']*1000).month}-${new DateTime.fromMicrosecondsSinceEpoch(data['followUpDate']*1000).year}')),
                                  DataCell(
                              data['followUpDate']>DateTime.now().millisecondsSinceEpoch?
                                      Text(
                                      '${data['followUpAmount'] ?? 'N/A'}'):
                              TextFormField(
                    initialValue:'${data['followUpAmount'] ?? ''}',
                                          decoration: InputDecoration(
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: CustomColorTheme
                                                      .primaryColor),
                                            ),
                                          ),
                                          keyboardType: TextInputType.number,
                                          style: TextStyle(
                                              fontSize: CustomFontTheme.textSize,
                                              fontWeight: CustomFontTheme.textwt,
                                              color: CustomColorTheme.textColor),
                                          onChanged: (value) {
                                            setState(() {
                                              data['followUpAmount'] = value;
                                            });
                                          },
                                                                      ),
                                      )

                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(350, 50),
                        backgroundColor: CustomColorTheme.primaryColor),
                    onPressed: () {

                      saveUpdatedData(updateData).then((value) => alertDialog(
                          context, "Data Updated Successfully", VdfHome()));
                    },
                    child: const Text(
                      'Save Update',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: CustomFontTheme.textSize),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          side: BorderSide(
                              color: CustomColorTheme.primaryColor, width: 1),
                          minimumSize: const Size(350, 50),
                          backgroundColor: CustomColorTheme.backgroundColor),
                      onPressed: () {},
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Call Beneficiary',
                          style:
                              TextStyle(color: CustomColorTheme.primaryColor),
                        ),
                      )),
                ),
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
  void alertDialog(BuildContext context, String message, Widget route) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // backgroundColor: Colors.white,
          backgroundColor: Colors.white,
          title: SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 40,
                ),
                SizedBox(
                  height: 20,
                ),
                Text('Saved Data to Draft'),
              ],
            ),
          ),
          content: SizedBox(
            height: 80,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(100, 50),
                    elevation: 0,
                    backgroundColor: CustomColorTheme.primaryColor,
                    side: const BorderSide(
                      width: 1,
                      color: CustomColorTheme.primaryColor,
                    ),
                  ),
                  onPressed: () {
                    //pop all screen until VDFHome
Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => route),
                            (Route<dynamic> route) => false);
                  },
                  child: const Text(
                    'Ok',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: CustomFontTheme.textSize,
                        fontWeight: CustomFontTheme.headingwt),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
