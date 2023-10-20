import 'package:dalmia/pages/vdf/household/approval.dart';
import 'package:dalmia/pages/vdf/vdfhome.dart';
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Icon(Icons.close),
              ),
              Text('Would you like to enroll this household for intervention?'),
            ],
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                ),
                onPressed: () {
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) => const Approval(),
                  //   ),
                  // );
                  // Perform actions when 'Yes' is clicked
                },
                child: const Text('Yes'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  side: const BorderSide(width: 1, color: Colors.blue),
                ),
                onPressed: () {
                  // Perform actions when 'No' is clicked
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'No',
                  style: TextStyle(color: Colors.blue),
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
            style: TextStyle(color: Colors.black),
          ),
          leading: GestureDetector(
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
                color: Colors.black,
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
                Text(
                  'Select House Type',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Checkbox(
                      value: ownChecked,
                      onChanged: (value) {
                        setState(() {
                          ownChecked = value!;
                        });
                      },
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    const Text('Own'),
                  ],
                ),
                if (ownChecked) ...[
                  const SizedBox(height: 20),
                  const Text('Fill at least one choice'),
                  const SizedBox(height: 20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Rowstock('Pakka'),
                      const SizedBox(height: 20),
                      Rowstock('Titled'),
                      const SizedBox(height: 20),
                      Rowstock('Kutcha'),
                    ],
                  ),
                ],
                const SizedBox(height: 20),
                Row(
                  children: [
                    Checkbox(
                      value: rentedChecked,
                      onChanged: (value) {
                        setState(() {
                          rentedChecked = value!;
                        });
                      },
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    const Text('Rented'),
                  ],
                ),
                const SizedBox(height: 20),
                TextField(
                  decoration: const InputDecoration(
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
                        side: BorderSide(width: 1, color: Colors.blue),
                      ),
                      onPressed: () {
                        // Perform actions when 'Save as Draft' is clicked
                      },
                      child: const Text(
                        'Save as Draft',
                        style: TextStyle(color: Colors.blue),
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

Widget Rowstock(String text) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
      ),
      SizedBox(
        width: 45,
        height: 30,
        child: TextField(
          decoration: const InputDecoration(
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
