import 'package:dalmia/pages/vdf/reports/Business.dart';
import 'package:dalmia/pages/vdf/reports/Cumulative.dart';
import 'package:dalmia/pages/vdf/reports/Form1.dart';
import 'package:dalmia/pages/vdf/reports/Leverwise.dart';
import 'package:dalmia/pages/vdf/reports/Livehood.dart';
import 'package:dalmia/pages/vdf/reports/Top20.dart';


import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';

class ReportPopupWidget extends StatefulWidget {
  final BuildContext context;
  ReportPopupWidget(this.context);

  @override
  _ReportPopupWidgetState createState() => _ReportPopupWidgetState();
}

class _ReportPopupWidgetState extends State<ReportPopupWidget> {
  int? selectedRadio;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 18),
                child: Text(
                  'View other Reports',
                  style: TextStyle(fontWeight: FontWeight.w600),
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
              'Form 1 Gram Parivartan',
              style: TextStyle(
                  fontSize: CustomFontTheme.textSize,
                  fontWeight: selectedRadio == 1
                      ? CustomFontTheme.headingwt
                      : CustomFontTheme.textwt,
                  color: selectedRadio == 1
                      ? CustomColorTheme.iconColor
                      : CustomColorTheme.textColor),
            ),
            value: 1,
            groupValue: selectedRadio,
            onChanged: (value) {
              setState(() {
                selectedRadio = value;
              });
            },
          ),

          RadioListTile<int>(
            activeColor: CustomColorTheme.iconColor,
            selectedTileColor: CustomColorTheme.iconColor,
            title: Text(
              'Cumulative Household data',
              style: TextStyle(
                  fontSize: CustomFontTheme.textSize,
                  fontWeight: selectedRadio == 2
                      ? CustomFontTheme.headingwt
                      : CustomFontTheme.textwt,
                  color: selectedRadio == 2
                      ? CustomColorTheme.iconColor
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
          RadioListTile<int>(
            activeColor: CustomColorTheme.iconColor,
            selectedTileColor: CustomColorTheme.iconColor,
            title: Text(
              'Leverwise number of interventions',
              style: TextStyle(
                  fontSize: CustomFontTheme.textSize,
                  fontWeight: selectedRadio == 3
                      ? CustomFontTheme.headingwt
                      : CustomFontTheme.textwt,
                  color: selectedRadio == 3
                      ? CustomColorTheme.iconColor
                      : CustomColorTheme.textColor),
            ),
            value: 3,
            groupValue: selectedRadio,
            onChanged: (value) {
              setState(() {
                selectedRadio = value;
              });
            },
          ),
          RadioListTile<int>(
            activeColor: CustomColorTheme.iconColor,
            selectedTileColor: CustomColorTheme.iconColor,
            title: Text(
              'Top 20 additional income HH',
              style: TextStyle(
                  fontSize: CustomFontTheme.textSize,
                  fontWeight: selectedRadio == 4
                      ? CustomFontTheme.headingwt
                      : CustomFontTheme.textwt,
                  color: selectedRadio == 4
                      ? CustomColorTheme.iconColor
                      : CustomColorTheme.textColor),
            ),
            value: 4,
            groupValue: selectedRadio,
            onChanged: (value) {
              setState(() {
                selectedRadio = value;
              });
            },
          ),
          RadioListTile<int>(
            activeColor: CustomColorTheme.iconColor,
            selectedTileColor: CustomColorTheme.iconColor,
            title: Text(
              'List of Business Plans engaged',
              style: TextStyle(
                  fontSize: CustomFontTheme.textSize,
                  fontWeight: selectedRadio == 5
                      ? CustomFontTheme.headingwt
                      : CustomFontTheme.textwt,
                  color: selectedRadio == 5
                      ? CustomColorTheme.iconColor
                      : CustomColorTheme.textColor),
            ),
            value: 5,
            groupValue: selectedRadio,
            onChanged: (value) {
              setState(() {
                selectedRadio = value;
              });
            },
          ),
          RadioListTile<int>(
            activeColor: CustomColorTheme.iconColor,
            selectedTileColor: CustomColorTheme.iconColor,
            title: Text(
              'Livelihood Funds Utilization',
              style: TextStyle(
                  fontSize: CustomFontTheme.textSize,
                  fontWeight: selectedRadio == 6
                      ? CustomFontTheme.headingwt
                      : CustomFontTheme.textwt,
                  color: selectedRadio == 6
                      ? CustomColorTheme.iconColor
                      : CustomColorTheme.textColor),
            ),
            value: 6,
            groupValue: selectedRadio,
            onChanged: (value) {
              setState(() {
                selectedRadio = value;
              });
            },
          ),
          // Add other RadioListTiles as needed
        ],
      ),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: CustomColorTheme.primaryColor,
              ),
              onPressed: () {
                if (selectedRadio == 1) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const Form1(),
                    ),
                  );
                } else if (selectedRadio == 2) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const Cumulative(),
                    ),
                  ); // Navigate to the corresponding tab
                } else if (selectedRadio == 3) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const Leverwise(),
                    ),
                  ); // Navigate to the corresponding tab
                } else if (selectedRadio == 4) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const Top20(),
                    ),
                  ); // Navigate to the corresponding tab
                } else if (selectedRadio == 5) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const BusinessPlan(),
                    ),
                  ); // Navigate to the corresponding tab
                } else if (selectedRadio == 6) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const LivehoodPlan(),
                    ),
                  ); // Navigate to the corresponding tab
                }
              },
              child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: const Text(
                    'View Report',
                    style: TextStyle(color: Colors.white),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
