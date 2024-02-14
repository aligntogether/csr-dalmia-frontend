import 'dart:convert';
import 'package:dalmia/common/size_constant.dart';
import 'package:dalmia/pages/vdf/intervention/Details.dart';
import 'package:dalmia/pages/vdf/street/Addstreet.dart';
import 'package:dalmia/pages/vdf/vdfhome.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';
import 'package:http_interceptor/http/intercepted_http.dart';
import '../../../../helper/http_intercepter.dart';
final http = InterceptedHttp.build(interceptors: [HttpInterceptor()]);

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
  bool onTap = false;

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
    print(widget.id);
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

                       child:  Column(
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
                                    onTap = true;
                                    filterInterventions(" ");

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


                            onTap?SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Container(
                                height: MySize.screenHeight/2,
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
                                ),
                              )
                            ):Container(
                            )
                            ,

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
    builder: (BuildContext context)
  {
    return AlertDialog(
      title: Center(
          child:
          Container(

            child: Text(
              'Are you sure you want to cancel assigning intervention?',
              style: TextStyle(
                fontSize: MySize.screenWidth * (16 / MySize.screenWidth),
                fontWeight: FontWeight.w600,
              ),
            ),
          )

      ),
      content: SizedBox(
        height: MySize.screenHeight * (180 / MySize.screenHeight),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(10),
                fixedSize: Size(
                    MySize.screenWidth * (250 / MySize.screenWidth), 60),
                backgroundColor: CustomColorTheme.primaryColor,
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const VdfHome(),
                  ),
                );
              },
              child: Text(
                'Yes',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ), SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(10),
                fixedSize: Size(
                    MySize.screenWidth * (250 / MySize.screenWidth), 60),
                backgroundColor: Colors.white,
                shadowColor: Colors.black,


              ),

              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'No',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: CustomColorTheme.textColor,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),

          ],
        ),
      ),
    );
  },
  );
}



