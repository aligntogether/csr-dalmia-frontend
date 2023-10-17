import 'package:dalmia/pages/vdf/household/addland.dart';
import 'package:dalmia/pages/vdf/vdfhome.dart';
import 'package:flutter/material.dart';

class AddCrop extends StatefulWidget {
  const AddCrop({super.key});

  @override
  State<AddCrop> createState() => _AddCropState();
}

class _AddCropState extends State<AddCrop> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Add Household',
          style: TextStyle(color: Colors.black),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AddLand(),
              ),
            );
          },
          child: Row(
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
                  builder: (context) => VdfHome(),
                ),
              );
            },
            icon: Icon(
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
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                'Add Crops Details',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                  'What are the crops you have cultivated in the past three years? '),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    cropRow('Paddy'),
                    cropRow('Sugarcane'),
                    cropRow('Maize, Corn'),
                    cropRow('Chilli'),
                    cropRow('Millet'),
                    cropRow('Fodder'),
                    cropRow('Gingilee'),
                    cropRow('Bengalgram'),
                    SizedBox(height: 16),
                    Container(
                      width: 120,
                      height: 35, // Set your desired width here
                      child: TextField(
                        decoration: InputDecoration(
                          label: Text('Other Crop 1'),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2), // Set the border width here
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    cropRow('Paddy'),
                    cropRow('Sugarcane'),
                    cropRow('Maize, Corn'),
                    cropRow('Chilli'),
                    cropRow('Millet'),
                    cropRow('Fodder'),
                    cropRow('Gingilee'),
                    cropRow('Bengalgram'),
                    SizedBox(height: 16),
                    Container(
                      width: 120,
                      height: 35, // Set your desired width here
                      child: TextField(
                        decoration: InputDecoration(
                          label: Text('Other crop 2'),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2), // Set the border width here
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue[900],
                  ),
                  onPressed: () {
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //     builder: (context) => AddCrop(),
                    //   ),
                    // );
                  },
                  child: Text('Next'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      primary: Colors.white,
                      side: BorderSide(width: 1, color: Colors.blue.shade900)),
                  onPressed: () {
                    // Perform actions with the field values

                    // Save as draft
                  },
                  child: Text('Save as Draft',
                      style: TextStyle(color: Colors.blue[800])),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }

  Widget cropRow(String text) {
    return Row(
      children: [
        Checkbox.adaptive(
          value: false,
          onChanged: (value) => value,
        ),
        Text(text),
      ],
    );
  }
}
