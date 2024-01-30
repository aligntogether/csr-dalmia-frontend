import 'dart:convert';
import 'package:dalmia/common/size_constant.dart';
import 'package:dalmia/pages/vdf/intervention/Details.dart';
import 'package:dalmia/pages/vdf/street/Addstreet.dart';
import 'package:dalmia/pages/vdf/vdfhome.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Intervention {
  final String id;
  final String name;

  Intervention(this.id, this.name);
}

String intervention = '';

class Addinter extends StatefulWidget {
  final String? id;

  const Addinter({super.key, this.id});
  @override
  _AddinterState createState() => _AddinterState();
}

class _AddinterState extends State<Addinter> {
  final _formKey = GlobalKey<FormState>();
  bool isButtonEnabled = false;
  List<Intervention> interventions = [];
  List<Intervention> filteredInterventions = [];
  TextEditingController interventionController = TextEditingController();
  String selectedInterventionId = '';

  void filterInterventions(String query) async {
    intervention = query;
    if (query.isNotEmpty) {
      var url = Uri.parse('$base/get-matching-interventions?interventionPatternName=$query');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data != null && data['resp_body'] != null) {
          List<dynamic> fetchedInterventions = data['resp_body'];
          List<Intervention> interventionsList = fetchedInterventions
              .map((intervention) => Intervention(
              intervention['id'].toString(),
              intervention['interventionName']))
              .toList();
          setState(() {
            filteredInterventions = interventionsList;
          });
        } else {
          print("API response is null or empty.");
        }
      } else {
        throw Exception('Failed to load interventions');
      }
    } else {
      setState(() {
        filteredInterventions = interventions;
        isButtonEnabled = false;
      });
    }
  }

  void initState() {
    super.initState();
    filterInterventions(intervention);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          centerTitle: true,
          title: const Text(
            'Assign Intervention',
            style: TextStyle(color: Colors.black),
          ),
          actions: <Widget>[
            IconButton(
              iconSize: 30,
              onPressed: () {
                _confirmitem(context);
              },
              icon: const Icon(
                Icons.close,
                color: Colors.black,
              ),
            ),
          ],
        ),
        body:  SingleChildScrollView(
          child: Padding(
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
                          const Padding(
                            padding: EdgeInsets.only(right: 100.0),
                            child: Text(
                              'What intervention has been chosen for this family? ',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextField(
                            controller: interventionController,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: 'Search Intervention name/ID',
                              suffixIcon: IconButton(
                                onPressed: () {

                                },
                                icon: const Icon(
                                  Icons.search,
                                  color: Colors.orange,
                                ),
                              ),
                            ),
                            onChanged: (value) {
                              filterInterventions(value);
                            },
                          ),

                          Container(
                            height: MySize.screenHeight*(300/MySize.screenHeight),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                                border: Border.all(color: Colors.grey),
                              ),
                              //scrollable list of interventions
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: filteredInterventions.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(
                                      filteredInterventions[index].name,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        interventionController.text =
                                            filteredInterventions[index].name;
                                        selectedInterventionId =
                                            filteredInterventions[index].id;
                                        isButtonEnabled = true;
                                      });
                                    },
                                  );
                                },
                              )
                            ),

                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isButtonEnabled
                                  ? CustomColorTheme.primaryColor
                                  : Colors.lightBlue,
                              minimumSize: const Size(350, 50),
                            ),
                            onPressed: isButtonEnabled
                                ? () {
                              print(selectedInterventionId);
                              print(widget.id);
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => Details(
                                    interventionname: interventionController.text,
                                    hid: widget.id,
                                    interId: selectedInterventionId,
                                  ),
                                ),
                              );
                            }
                                : null,
                            child: const Text(
                              'Confirm',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ),
        ),

    );
  }
}

void _confirmitem(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('What do you wish to do next?'),
          ],
        ),
        content: SizedBox(
          height: 200,
          child: Column(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(10),
                  fixedSize: Size(250, 60),
                  backgroundColor: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const VdfHome(),
                    ),
                  );
                },
                child: Text(
                  'Save HH as draft and add intervention later ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: CustomColorTheme.primaryColor,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(250, 60),
                  backgroundColor: CustomColorTheme.primaryColor,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Continue adding Intervention',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
