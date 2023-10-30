import 'package:dalmia/pages/vdf/household/addland.dart';
import 'package:dalmia/pages/vdf/household/addlivestock.dart';
import 'package:dalmia/pages/vdf/vdfhome.dart';
import 'package:dalmia/theme.dart';
import 'package:flutter/material.dart';

class AddCrop extends StatefulWidget {
  const AddCrop({Key? key}) : super(key: key);

  @override
  State<AddCrop> createState() => _AddCropState();
}

class _AddCropState extends State<AddCrop> {
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
                  'Add Crops Details',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20, bottom: 20),
                child: Text(
                  'What are the crops you have cultivated in the past three years? ',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      cropRow('Paddy', 0),
                      cropRow('Sugarcane', 1),
                      cropRow('Maize, Corn', 2),
                      cropRow('Chilli', 3),
                      cropRow('Millet', 4),
                      cropRow('Fodder', 5),
                      cropRow('Gingilee', 6),
                      cropRow('Bengalgram', 7),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: 120,
                        height: 35,
                        child: TextField(
                          decoration: const InputDecoration(
                            labelText: 'Other Crop 1',
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      cropRow('Paddy', 8),
                      cropRow('Sugarcane', 9),
                      cropRow('Maize, Corn', 10),
                      cropRow('Chilli', 11),
                      cropRow('Millet', 12),
                      cropRow('Fodder', 13),
                      cropRow('Gingilee', 14),
                      cropRow('Bengalgram', 15),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: 120,
                        height: 35,
                        child: TextField(
                          decoration: const InputDecoration(
                            labelText: 'Other crop 2',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 25),
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
                          builder: (context) => AddStock(),
                        ),
                      );
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (context) => AddCrop(),
                      //   ),
                      // );
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

  Widget cropRow(String text, int index) {
    return Row(
      children: [
        Checkbox(
          value: cropCheckList[index],
          onChanged: (value) {
            setState(() {
              cropCheckList[index] = value!;
            });
          },
          activeColor: CustomColorTheme.iconColor,
        ),
        Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: cropCheckList[index]
                ? CustomColorTheme.iconColor
                : CustomColorTheme.labelColor,
          ),
        ),
      ],
    );
  }
}
