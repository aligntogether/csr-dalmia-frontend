import 'package:dalmia/pages/vdf/vdfhome.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';

class Approval extends StatefulWidget {
  const Approval({super.key});

  @override
  State<Approval> createState() => _ApprovalState();
}

class _ApprovalState extends State<Approval> {
  int? selectedRadio;

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
                padding: EdgeInsets.only(left: 20),
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
                  RadioElement(
                      'HH financially stable and agreed to get dropped.', 1),
                  RadioElement(
                      'Refused to get enrolled, but financially not stable.',
                      2),
                  RadioElement('HH Visibly Rich.', 3),
                  RadioElement('Works at Dalmia.', 4),
                  RadioElement('Works in Organized Sector.', 5),
                  RadioElement('No intervention possible.', 6),
                  RadioElement('Other reason.', 7),
                  Padding(
                    padding: EdgeInsets.only(left: 13, right: 13),
                    child: TextField(
                      enabled: selectedRadio == 7 ? true : false,

                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        labelStyle:
                            TextStyle(color: CustomColorTheme.labelColor),
                        labelText: 'Please specify the reason',
                      ),
                      maxLines:
                          3, // Adjust the number of lines as per your requirement
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(350, 50),
                      backgroundColor: CustomColorTheme.primaryColor,
                    ),
                    onPressed: () {},
                    child: const Text(
                      'submit for approval',
                      style: TextStyle(
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

  RadioListTile<int> RadioElement(String title, int radio) {
    return RadioListTile<int>(
      title: Text(
        title,
        style: TextStyle(
            color: selectedRadio == radio
                ? CustomColorTheme.iconColor
                : CustomColorTheme.textColor,
            fontSize: CustomFontTheme.textSize,
            fontWeight: selectedRadio == radio
                ? CustomFontTheme.labelwt
                : CustomFontTheme.textwt),
      ),
      value: radio,
      groupValue: selectedRadio,
      onChanged: (value) {
        setState(() {
          selectedRadio = value;
        });
      },
      activeColor: CustomColorTheme.iconColor,
      selectedTileColor: CustomColorTheme.iconColor,
    );
  }
}
