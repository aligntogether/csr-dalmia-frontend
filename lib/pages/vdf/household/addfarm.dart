import 'package:dalmia/pages/vdf/household/addland.dart';
import 'package:dalmia/pages/vdf/household/selecttype.dart';
import 'package:dalmia/pages/vdf/vdfhome.dart';
import 'package:flutter/material.dart';

class AddFarm extends StatefulWidget {
  const AddFarm({Key? key}) : super(key: key);

  @override
  State<AddFarm> createState() => _AddFarmState();
}

class _AddFarmState extends State<AddFarm> {
  List<bool> cropCheckList = List.filled(16, false);

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
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (context) => AddLand(),
              //   ),
              // );
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
                )
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'Add Farm Equipment Details',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Column(
                children: [
                  SizedBox(height: 20),
                  Rowstock('Tractor'),
                  SizedBox(height: 20),
                  Rowstock('Mini Tractor'),
                  SizedBox(height: 20),
                  Rowstock('Rotovator'),
                  SizedBox(height: 20),
                  Rowstock('Sprayer'),
                  SizedBox(height: 20),
                  Rowstock('Weeder'),
                  SizedBox(height: 20),
                  Rowstock('MB Plough'),
                  SizedBox(height: 20),
                  Rowstock('Harvestor'),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      SizedBox(
                        width: 40,
                      ),
                      Text(
                        'Others1',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey),
                      ),
                      SizedBox(
                        width: 85,
                        height: 35,
                        child: TextField(
                          decoration: const InputDecoration(
                            label: Text('Specify'),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 55,
                        height: 35,
                        child: TextField(
                          decoration: const InputDecoration(
                            label: Text('No.'),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        'Others2',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey),
                      ),
                      SizedBox(
                        width: 85,
                        height: 35,
                        child: TextField(
                          decoration: const InputDecoration(
                            label: Text('Specify'),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 55,
                        height: 35,
                        child: TextField(
                          decoration: const InputDecoration(
                            label: Text('No.'),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[900],
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SelectType(),
                        ),
                      );
                    },
                    child: const Text('Next'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.white,
                      side: const BorderSide(width: 1, color: Colors.blue),
                    ),
                    onPressed: () {
                      // Perform actions with the field values

                      // Save as draft
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
    );
  }
}

Widget Rowstock(String text) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      // SizedBox(
      //   width: 40,
      // ),
      Text(
        text,
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey),
      ),
      // SizedBox(
      //   width: 40,
      // ),
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
