import 'dart:convert';

import 'package:dalmia/common/size_constant.dart';
import 'package:dalmia/pages/CDO/action.dart';
import 'package:dalmia/pages/CDO/cdohome.dart';
import 'package:dalmia/theme.dart';

import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ActionDetail extends StatefulWidget {
  final String hhid;
  final String locationId;

  ActionDetail({super.key, required this.hhid, required this.locationId});

  @override
  State<ActionDetail> createState() => _ActionDetailState();
}

void _callAcceptHouseholdAPI(String hhid) async {
  try {
    final response = await http.put(
      Uri.parse(
        'https://mobileqacloud.dalmiabharat.com:443/csr/cdo-accept-household?hhid=$hhid',
      ),
    );

    if (response.statusCode == 200) {
      // Handle success
      print('Household $hhid accepted for intervention');
    } else {
      // Handle error
      print('Error accepting household $hhid: ${response.statusCode}');
    }
  } catch (error) {
    // Handle error
    print('Error accepting household $hhid: $error');
  }
}

void _calldropHouseholdAPI(String hhid) async {
  try {
    final response = await http.put(
      Uri.parse(
        'https://mobileqacloud.dalmiabharat.com:443/csr/cdo-drop-household?hhid=$hhid',
      ),
    );
    print("hi$response");

    if (response.statusCode == 200) {
      // Handle success
      print('Household $hhid droped');
    } else {
      // Handle error
      print('Error droping household $hhid: ${response.statusCode}');
    }
  } catch (error) {
    // Handle error
    print('Error droping household $hhid: $error');
  }
}

class _ActionDetailState extends State<ActionDetail> {
  Map<String, dynamic>? houseHoldDetail;

  @override
  void initState() {
    super.initState();
    print(widget.hhid);
    fetchHouseHoldDetails();
  }

  void fetchHouseHoldDetails() async {
    try {
      final response = await http.get(
        Uri.parse(
          'https://mobileqacloud.dalmiabharat.com:443/csr/dropped-household-details?locationId=${widget.locationId}&hhid=${widget.hhid}',
        ),
      );

      if (response.statusCode == 200) {
        // Handle success
        print('Household details fetched');
        print(response.body);
        setState(() {
          houseHoldDetail = jsonDecode(response.body)['resp_body'][0];
          print(houseHoldDetail);
        });
      } else {
        // Handle error
        print('Error fetching household details: ${response.statusCode}');
      }
    } catch (error) {
      // Handle error
      print('Error fetching household details: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> livestock = [];
    if (houseHoldDetail != null) {
      jsonDecode(houseHoldDetail?['livestockNumbers'])
          .forEach((key, value) {
            if(value!=0){
              livestock.add(HouseDetails(
                heading: key,
                text: value.toString(),
              ));
            }
      });
    }
    List<Widget> farmEquipment = [];
    if (houseHoldDetail != null) {
      if(houseHoldDetail?['farmEquipment']!=null){
        jsonDecode(houseHoldDetail?['farmEquipment'])
            .forEach((key, value) {
          if(value!=0){
            farmEquipment.add(HouseDetails(
              heading: key,
              text: value.toString(),
            ));
          }
        });
      }
    }
    List<Widget> houseType = [];
    if (houseHoldDetail != null) {

      if(houseHoldDetail?['houseType']!=null){
        jsonDecode(houseHoldDetail?['houseType'])
            .forEach((key, value) {
          if(value!=0){
            houseType.add(HouseDetails(
              heading: key,
              text: value.toString(),
            ));
          }
        });
      }
    }


    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 10),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.close))
              ],
            ),
            Center(
              child: Text(
                widget.hhid,
                style: TextStyle(
                    fontSize: CustomFontTheme.headingSize,
                    fontWeight: CustomFontTheme.headingwt),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Name of VDF',
              style: TextStyle(
                  fontSize: CustomFontTheme.textSize,
                  fontWeight: CustomFontTheme.headingwt),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              houseHoldDetail == null ? "" : houseHoldDetail?['vdfName'],
              style: TextStyle(
                  fontSize: CustomFontTheme.textSize,
                  color: CustomColorTheme.labelColor),
            ),
            SizedBox(
              height: 20,
            ),
            Text('Remarks By VDF',
                style: TextStyle(
                    fontSize: CustomFontTheme.textSize,
                    fontWeight: CustomFontTheme.headingwt)),
            SizedBox(
              height: 10,
            ),
            Text(
              houseHoldDetail == null
                  ? ""
                  : houseHoldDetail?['reasonForDropping'],
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: CustomFontTheme.textSize,
                fontWeight: CustomFontTheme.labelwt,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              thickness: 0.5,
              color: CustomColorTheme.labelColor,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Household Details',
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: CustomColorTheme.labelColor,
                  fontWeight: CustomFontTheme.labelwt),
            ),
            SizedBox(
              height: 20,
            ),
            HouseDetails(
              heading: 'Family Head',
              text:
                  houseHoldDetail == null ? "" : houseHoldDetail?['memberName'],
            ),
            HouseDetails(
              heading: 'Street Name',
              text:
                  houseHoldDetail == null ? "" : houseHoldDetail?['streetName'],
            ),
            HouseDetails(
              heading: 'Village Name',
              text: houseHoldDetail == null
                  ? ""
                  : houseHoldDetail?['villageName'],
            ),
            HouseDetails(
              heading: 'Panchayat Name',
              text: houseHoldDetail == null
                  ? ""
                  : houseHoldDetail?['panchayatName'],
            ),
            HouseDetails(
              heading: 'Primary Occupation',
              text: houseHoldDetail == null
                  ? ""
                  : houseHoldDetail?['primaryEmployment'],
            ),
            HouseDetails(
              heading: 'Secondary Information',
              text: houseHoldDetail == null
                  ? ""
                  : houseHoldDetail?['secondaryEmployment'],
            ),
            HouseDetails(
              heading: 'Irrigated Land',
              text: houseHoldDetail == null
                  ? ""
                  : houseHoldDetail?['irrigatedLand'] == null
                      ? "0"
                      : houseHoldDetail?['irrigatedLand'],
            ),
            HouseDetails(
              heading: 'Rainfed Land',
              text: houseHoldDetail == null
                  ? ""
                  : houseHoldDetail?['rainfedLand'] == null
                      ? "0"
                      : houseHoldDetail?['rainfedLand'],
            ),
            for( var widget in livestock) widget,
            for( var widget in farmEquipment) widget,
            for( var widget in houseType) widget,


            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    minimumSize: const Size(130, 50),
                    backgroundColor: CustomColorTheme.primaryColor,
                  ),
                  onPressed: () {
                    _drophhDialog(context, widget.hhid, widget.locationId);
                  },
                  child: const Text(
                    'Drop HH',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: CustomFontTheme.textSize,
                        fontWeight: CustomFontTheme.labelwt),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    minimumSize: const Size(130, 50),
                    side: BorderSide(
                        color: CustomColorTheme.primaryColor, width: 1),
                    backgroundColor: Colors.white,
                  ),
                  onPressed: () {
                    _selecthhDialog(context, widget.hhid, widget.locationId);
                  },
                  child: Text(
                    'Select HH',
                    style: TextStyle(
                        color: CustomColorTheme.primaryColor,
                        fontSize: CustomFontTheme.textSize,
                        fontWeight: CustomFontTheme.labelwt),
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    ));
  }
}

class HouseDetails extends StatelessWidget {
  final String heading;
  final String text;
  const HouseDetails({
    super.key,
    required this.heading,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              heading,
              style: TextStyle(
                  fontSize: CustomFontTheme.textSize,
                  fontWeight: CustomFontTheme.headingwt),
            ),
          ),
          SizedBox(
            width: 30,
          ),
          SizedBox(
            width: MySize.screenWidth * (140 / MySize.screenWidth),
            child: Text(
              text,
              softWrap: true,
              style: TextStyle(
                  color: CustomColorTheme.labelColor,
                  fontSize: CustomFontTheme.textSize),
            ),
          )
        ],
      ),
    );
  }
}

void _drophhDialog(BuildContext context, String hhid, String locationId) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        alignment: Alignment.topCenter,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: SizedBox(
          width: 290,
          height: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const CDOHome()),
                      (Route<dynamic> route) => false);
                },
                child: const Icon(Icons.close),
              ),
              Text(
                'Are you sure you want to drop $hhid from intervention? ',
                style: TextStyle(
                  fontSize: 16,
                  // fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: 157,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(),
                  backgroundColor: CustomColorTheme.primaryColor,
                ),
                onPressed: () {
                  _calldropHouseholdAPI(hhid);
                  // pop all screens and go to action against hh
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const CDOHome()),
                      (Route<dynamic> route) => false);
                },
                child: const Text(
                  'Confirm',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

void _selecthhDialog(BuildContext context, String hhid, String locationId) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        alignment: Alignment.topCenter,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: SizedBox(
          width: 283,
          height: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const CDOHome()),
                      (Route<dynamic> route) => false);
                },
                child: const Icon(Icons.close),
              ),
              Text(
                'Are you sure you want to select $hhid for intervention? ',
                style: TextStyle(
                  fontSize: 16,
                  // fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: 157,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(),
                  backgroundColor: CustomColorTheme.primaryColor,
                ),
                onPressed: () {
                  _callAcceptHouseholdAPI(hhid);
                  Navigator.pop(context);
                  _confirmbox(context, hhid, locationId);
                },
                child: const Text(
                  'Confirm',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

void _confirmbox(BuildContext context, String hhid, String locationId) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => ActionAgainstHH(
                locationId: locationId,
              ),
            ),
          );
          return false;
        },
        child: AlertDialog(
          alignment: Alignment.topCenter,
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
                Text(
                  '$hhid   is  successfully approved.',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          content: SizedBox(
            height: 100,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(150, 50),
                  elevation: 0,
                  backgroundColor: CustomColorTheme.primaryColor,
                ),
                onPressed: () {
                  //pop all screens and go to action against hh
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const CDOHome()),
                      (Route<dynamic> route) => false);
                },
                child: const Text(
                  'Ok',
                  style: TextStyle(
                      color: Colors.white, fontSize: CustomFontTheme.textSize),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ]),
          ),
        ),
      );
    },
  );
}
