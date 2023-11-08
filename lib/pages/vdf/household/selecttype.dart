import 'package:dalmia/pages/vdf/household/approval.dart';
import 'package:dalmia/pages/vdf/intervention/Addinter.dart';
import 'package:dalmia/pages/vdf/vdfhome.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';

class SelectType extends StatefulWidget {
  const SelectType({Key? key}) : super(key: key);

  @override
  State<SelectType> createState() => _SelectTypeState();
}

class _SelectTypeState extends State<SelectType> {
  List<bool> cropCheckList = List.filled(16, false);
  bool ownChecked = false;
  bool rentedChecked = false;

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Icon(Icons.close),
              ),
              const Text(
                  'Would you like to enroll this household for intervention?'),
            ],
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: CustomColorTheme.primaryColor),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Addinter(),
                    ),
                  );
                  // Perform actions when 'Yes' is clicked
                },
                child: const Text('Yes'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.white,
                  side: const BorderSide(
                      width: 1, color: CustomColorTheme.primaryColor),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const Approval(),
                    ),
                  );
                  // Perform actions when 'No' is clicked
                },
                child: const Text(
                  'No',
                  style: TextStyle(color: CustomColorTheme.primaryColor),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Add Household',
            style: TextStyle(color: Color(0xFF181818)),
          ),
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Row(
              children: [
                Icon(
                  Icons.keyboard_arrow_left_outlined,
                  color: Color(0xFF181818),
                ),
                Text(
                  'Back',
                  style: TextStyle(color: Color(0xFF181818)),
                ),
              ],
            ),
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
          child: Padding(
            padding: const EdgeInsets.only(left: 40, right: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Select House Type',
                  style: TextStyle(
                      fontSize: CustomFontTheme.textSize,
                      fontWeight: CustomFontTheme.headingwt),
                ),
                const SizedBox(height: 20),
                RadioListTile(
                  value: true,
                  groupValue: ownChecked,
                  onChanged: (value) {
                    setState(() {
                      ownChecked = value as bool;
                      if (value) rentedChecked = false;
                    });
                  },
                  title: Text(
                    'Own',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: ownChecked
                            ? CustomColorTheme.iconColor
                            : CustomColorTheme.labelColor),
                  ),
                  activeColor: Colors
                      .orange, // Define the active color for the radio button
                  selectedTileColor: Colors.orange,
                ),
                const Divider(
                  color: Colors.grey, // Add your desired color for the line
                  thickness: 1, // Add the desired thickness for the line
                ),
                if (ownChecked) ...[
                  const SizedBox(height: 20),
                  Text(
                    'Fill at least one choice',
                    style: TextStyle(
                        color: Color(0xFF181818).withOpacity(0.80),
                        fontSize: 14,
                        fontWeight: CustomFontTheme.labelwt),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Rowst('Pakka'),
                      const SizedBox(height: 20),
                      Rowst('Titled'),
                      const SizedBox(height: 20),
                      Rowst('Kutcha'),
                    ],
                  ),
                ],
                const SizedBox(height: 20),
                RadioListTile(
                  value: true,
                  groupValue: rentedChecked,
                  onChanged: (value) {
                    setState(() {
                      rentedChecked = value as bool;
                      if (value) ownChecked = false;
                    });
                  },
                  title: Text(
                    'Rented',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: rentedChecked
                            ? CustomColorTheme.iconColor
                            : CustomColorTheme.labelColor),
                  ),
                  activeColor: CustomColorTheme
                      .iconColor, // Define the active color for the radio button
                  selectedTileColor: CustomColorTheme.iconColor,
                ),
                const Divider(
                  color: Colors.grey, // Add your desired color for the line
                  thickness: 1, // Add the desired thickness for the line
                ),
                const SizedBox(height: 20),
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Any remarks about this household?',
                    border: OutlineInputBorder(),
                  ),
                  maxLines:
                      3, // Adjust the number of lines as per your requirement
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[900],
                      ),
                      onPressed: () {
                        _showConfirmationDialog(context);
                      },
                      child: const Text('Done'),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Colors.white,
                        side: const BorderSide(
                            color: CustomColorTheme.primaryColor, width: 1),
                      ),
                      onPressed: () {
                        // Perform actions with the field values

                        // Save as draft
                      },
                      child: Text(
                        'Save as Draft',
                        style: TextStyle(color: Colors.blue[900]),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget Rowst(String text) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Color(0xFF181818).withOpacity(0.80),
        ),
      ),
      const SizedBox(
        width: 45,
        height: 30,
        child: TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(
                width: 2,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
