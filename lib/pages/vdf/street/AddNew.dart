import 'package:dalmia/pages/vdf/vdfhome.dart';
import 'package:dalmia/theme.dart';

import 'package:flutter/material.dart';

class Addnew extends StatefulWidget {
  const Addnew({
    super.key,
  });

  @override
  _AddnewState createState() => _AddnewState();
}

class _AddnewState extends State<Addnew> {
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
              'Add a Street',
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
            child: Center(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 300,
                    height: 100,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 232, 253, 233)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text('Panchayat } '), Text('Village}')],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    width: 300,
                    child: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('Enter Street Name')),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    width: 300,
                    child: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('Enter Street Code')),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    width: 300,
                    child: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('Enter Number of Households')),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(350, 50),
                      backgroundColor: Colors.blue[900],
                    ),
                    onPressed: () {
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (context) => AddFarm(),
                      //   ),
                      // );
                      _confirmbox(context);
                    },
                    child: const Text('Add Street'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      'This street name and street code are already added to the village.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: CustomFontTheme.textSize,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 35),
                    child: Text(
                      'Check all streets added to the village here',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: CustomFontTheme.textSize,
                        color: Colors.red,
                      ),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}

void _confirmbox(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 40,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                  '“<Street name>” is added successfully. What do you wish to do next?'),
            ],
          ),
        ),
        content: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
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
                'Add another street in same village',
                style: TextStyle(color: Colors.blue),
              ),
            ),
            const SizedBox(
              height: 10,
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
                'Add household details for this street',
                style: TextStyle(color: Colors.blue),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[900],
                minimumSize: const Size(250, 50),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Save and Close'),
            ),
          ],
        ),
      );
    },
  );
}
