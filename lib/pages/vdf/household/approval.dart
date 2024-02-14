import 'dart:convert';

import 'package:dalmia/pages/vdf/household/addland.dart';
import 'package:dalmia/pages/vdf/street/Addstreet.dart';
import 'package:dalmia/pages/vdf/vdfhome.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';
import 'package:http_interceptor/http/intercepted_http.dart';
import '../../../../helper/http_intercepter.dart';
final http = InterceptedHttp.build(interceptors: [HttpInterceptor()]);

class Approval extends StatefulWidget {
  final String? id;
  const Approval({super.key, this.id});

  @override
  State<Approval> createState() => _ApprovalState();
}

class _ApprovalState extends State<Approval> {
  List<String> selectedCheckboxes = [];
  List<DropdownOption> dropdownOptions = [];

  @override
  void initState() {
    super.initState();
    fetchApprovalOptions(); // Call the method to fetch dropdown options when the page initializes
  }

  Future<void> addreason() async {
    print("Selected checkboxes: ${selectedCheckboxes.toString()}");
    print("Selected checkboxes: ${selectedCheckboxes.runtimeType}");
    final apiUrl = '$base/add-household';

    final Map<String, dynamic> requestData = {
      "id": widget.id,
      "reason_for_dropping": selectedCheckboxes.toString().replaceAll("[","").replaceAll("]",""),
      "is_draft": 0
    };
    print("Request data: $requestData");

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(requestData),
      );
      print("Response: ${response.body}");

      if (response.statusCode == 200) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => VdfHome(),
          ),
        );
        print("Reason added");
      } else {
        print("Failed to add data: ${response.statusCode}");
        print(response.body);
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> fetchApprovalOptions() async {
    try {
      final response = await http.get(
        Uri.parse('$base/dropdown?titleId=115'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        final List<dynamic> options = jsonData['resp_body']['options'];

        setState(() {
          dropdownOptions = options
              .map(
                (option) => DropdownOption.fromJson(option),
          )
              .toList();
        });
      } else {
        throw Exception(
            'Failed to load dropdown options: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text(
            'Add Household',
            style: TextStyle(color: Color(0xFF181818)),
          ),
          backgroundColor: Colors.grey[50],
          actions: <Widget>[
            IconButton(
              iconSize: 30,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const VdfHome(),
                  ),
                );
              },
              icon: const Icon(
                Icons.close,
                color: Color(0xFF181818),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  'Why do you want to drop this family from intervention?',
                  style: TextStyle(
                    fontSize: CustomFontTheme.textSize,
                    fontWeight: CustomFontTheme.headingwt,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  for (DropdownOption option in dropdownOptions)
                    CheckboxElement(option.titleData, option.titleData),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(300, 50),
                      backgroundColor: CustomColorTheme.primaryColor,
                    ),
                    onPressed: () {
                      addreason();
                    },
                    child: const Text(
                      'Submit for Approval',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: CustomFontTheme.textSize,
                          fontWeight: CustomFontTheme.labelwt),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  CheckboxListTile CheckboxElement(String title, String? checkboxValue) {
    return CheckboxListTile(
      title: Text(
        title,
        style: TextStyle(
          color: selectedCheckboxes.contains(checkboxValue) ? CustomColorTheme.iconColor : CustomColorTheme.textColor,
          fontSize: CustomFontTheme.textSize,
          fontWeight: selectedCheckboxes.contains(checkboxValue) ? CustomFontTheme.labelwt : CustomFontTheme.textwt,
        ),
      ),
      value: selectedCheckboxes.contains(checkboxValue),
      onChanged: (isChecked) {
        setState(() {
          if (isChecked != null && isChecked) {
            selectedCheckboxes.add(checkboxValue!);
          } else {
            selectedCheckboxes.remove(checkboxValue);
          }
        });
      },
      activeColor: CustomColorTheme.iconColor,
      selectedTileColor: CustomColorTheme.iconColor,
    );
  }
}
