import 'dart:convert';
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

class Addinter extends StatefulWidget {
  @override
  _AddinterState createState() => _AddinterState();
}

class _AddinterState extends State<Addinter> {
  final _formKey = GlobalKey<FormState>();
  List<Intervention> interventions = [];
  List<Intervention> filteredInterventions = [];
  TextEditingController interventionController = TextEditingController();
  bool showListView = true;
  // RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  // String Function(Match) mathFunc = (Match match) => '${match[1]},';
  void filterInterventions(String query) async {
    if (query.isNotEmpty) {
      var url = Uri.parse(
          '$base/get-matching-interventions?interventionPatternName=$query');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data != null && data['resp_body'] != null) {
          List<dynamic> fetchedInterventions = data['resp_body'];
          List<Intervention> interventionsList = fetchedInterventions
              .map((intervention) => Intervention(
                  DateTime.now().millisecondsSinceEpoch.toString(),
                  intervention))
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
      });
    }
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
          backgroundColor: Colors.grey[50],
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
        body: SingleChildScrollView(
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
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.search,
                                  color: Colors
                                      .orange, // Customize the search icon color here
                                ),
                              )),
                          onChanged: (value) {
                            filterInterventions(value);
                          },
                        ),
                        if (showListView)
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: filteredInterventions.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title:
                                      Text(filteredInterventions[index].name),
                                  onTap: () {
                                    setState(() {
                                      interventionController.text =
                                          filteredInterventions[index].name;
                                      showListView = false;
                                    });
                                  },
                                );
                              },
                            ),
                          ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: CustomColorTheme.primaryColor,
                            minimumSize: const Size(350, 50),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => Details(),
                              ),
                            );
                          },
                          child: const Text('Confirm'),
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
    context: context,
    builder: (BuildContext context) {
      return FractionallySizedBox(
        heightFactor: 0.3,
        child: AlertDialog(
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('What do you wish to do next?'),
            ],
          ),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(10),
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
                  style: TextStyle(color: Colors.blue[900]),
                ),
              ),
              ElevatedButton(
                style:
                    ElevatedButton.styleFrom(backgroundColor: Colors.blue[900]),
                onPressed: () {},
                child: const Text('Continue adding Intervention'),
              ),
            ],
          ),
        ),
      );
    },
  );
}
