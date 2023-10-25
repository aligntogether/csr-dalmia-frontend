import 'package:dalmia/pages/vdf/household/addfarm.dart';
import 'package:dalmia/pages/vdf/vdfhome.dart';
import 'package:flutter/material.dart';

class Approval extends StatefulWidget {
  const Approval({Key? key}) : super(key: key);

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
          centerTitle: true,
          title: const Text(
            'Add Household',
            style: TextStyle(color: Colors.black),
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
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  RadioListTile<int>(
                    title: const Text(
                        'Family is financially stable and has accepted to be dropped from DBF intervention.'),
                    value: 1,
                    groupValue: selectedRadio,
                    onChanged: (value) {
                      setState(() {
                        selectedRadio = value;
                      });
                    },
                  ),
                  RadioListTile<int>(
                    title: const Text(
                        'Cultivable fields not used directly by owner who stays outstation.'),
                    value: 2,
                    groupValue: selectedRadio,
                    onChanged: (value) {
                      setState(() {
                        selectedRadio = value;
                      });
                    },
                  ),
                  RadioListTile<int>(
                    title: const Text(
                        'Family not willing to participate in our intervention.'),
                    value: 3,
                    groupValue: selectedRadio,
                    onChanged: (value) {
                      setState(() {
                        selectedRadio = value;
                      });
                    },
                  ),
                  RadioListTile<int>(
                    title: const Text('Other reason'),
                    value: 4,
                    groupValue: selectedRadio,
                    onChanged: (value) {
                      setState(() {
                        selectedRadio = value;
                      });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 13, right: 13),
                    child: TextField(
                      enabled: true,
                      decoration: const InputDecoration(
                        labelText: 'Please specify the reason',
                        border: OutlineInputBorder(),
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
                      backgroundColor: Colors.blue[900],
                    ),
                    onPressed: () {},
                    child: const Text('submit for approval'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
