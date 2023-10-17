import 'package:dalmia/pages/vdf/household/addcrops.dart';
import 'package:dalmia/pages/vdf/household/addhead.dart';
import 'package:dalmia/pages/vdf/vdfhome.dart';
import 'package:flutter/material.dart';

class AddLand extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<AddLand> {
  final _formKey = GlobalKey<FormState>();

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
                    builder: (context) => VdfHome(),
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
        body: Padding(
          padding: const EdgeInsets.only(left: 20, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add Land Ownership Details',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 32),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Rainfed',
                    style: TextStyle(color: Colors.grey[500], fontSize: 15),
                  ),
                  SizedBox(height: 16),
                  Wrap(
                    alignment: WrapAlignment.start,
                    spacing: 20,
                    children: [
                      inputdetail('6 acre'),
                      inputdetail('6 acre'),
                      inputdetail('6 acre'),
                      inputdetail('6 acre'),
                      inputdetail('6 acre'),
                      inputdetail('6 acre'),
                    ],
                  )
                ],
              ),
              SizedBox(height: 32),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Irrigated',
                    style: TextStyle(color: Colors.grey[500], fontSize: 15),
                  ),
                  SizedBox(height: 16),
                  Wrap(
                    alignment: WrapAlignment.start,
                    spacing: 20,
                    children: [
                      inputdetail('6 acre'),
                      inputdetail('6 acre'),
                      inputdetail('6 acre'),
                      inputdetail('6 acre'),
                      inputdetail('6 acre'),
                      inputdetail('6 acre'),
                    ],
                  )
                ],
              ),
              SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue[900],
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AddCrop(),
                        ),
                      );
                    },
                    child: Text('Next'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
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
    );
  }
}

class inputdetail extends StatelessWidget {
  final String acre;

  const inputdetail(
    this.acre, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Text(
        acre,
        style: TextStyle(color: Colors.black),
      ),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(85, 38),
        backgroundColor: Colors.white,
      ),
    );
  }
}
