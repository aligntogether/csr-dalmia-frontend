import 'package:dalmia/pages/vdf/addfamily.dart';
import 'package:flutter/material.dart';

class AddStreet extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<AddStreet> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _field1Controller = TextEditingController();
  TextEditingController _field2Controller = TextEditingController();
  TextEditingController _field3Controller = TextEditingController();
  TextEditingController _field4Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      // appBar: AppBar(
      //   title: Text('Form Example'),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Add a Street',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _field1Controller,
                  decoration: InputDecoration(
                    labelText: 'Enter Street Name',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue, // Change the border color here
                      ),
                      borderRadius:
                          BorderRadius.circular(10), // Adjust the border radius
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors
                            .green, // Change the border color when focused
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors
                            .red, // Change the border color when there's an error
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors
                            .red, // Change the border color when focused and there's an error
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorStyle: TextStyle(
                      color: Colors
                          .red, // Change the text color for error messages
                    ),
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter Number of Households';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _field1Controller,
                  decoration: InputDecoration(
                    labelText: 'Enter Street Name',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue, // Change the border color here
                      ),
                      borderRadius:
                          BorderRadius.circular(10), // Adjust the border radius
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors
                            .green, // Change the border color when focused
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors
                            .red, // Change the border color when there's an error
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors
                            .red, // Change the border color when focused and there's an error
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorStyle: TextStyle(
                      color: Colors
                          .red, // Change the text color for error messages
                    ),
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter Number of Households';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _field2Controller,
                  decoration: InputDecoration(
                    labelText: 'Select a Panchayat',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue, // Change the border color here
                      ),
                      borderRadius:
                          BorderRadius.circular(10), // Adjust the border radius
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors
                            .green, // Change the border color when focused
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors
                            .red, // Change the border color when there's an error
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors
                            .red, // Change the border color when focused and there's an error
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorStyle: TextStyle(
                      color: Colors
                          .red, // Change the text color for error messages
                    ),
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Field 2 is required';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _field3Controller,
                  decoration: InputDecoration(
                    labelText: 'Select a Village',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue, // Change the border color here
                      ),
                      borderRadius:
                          BorderRadius.circular(10), // Adjust the border radius
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors
                            .green, // Change the border color when focused
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors
                            .red, // Change the border color when there's an error
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors
                            .red, // Change the border color when focused and there's an error
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorStyle: TextStyle(
                      color: Colors
                          .red, // Change the text color for error messages
                    ),
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Field 3 is required';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                // padding: const EdgeInsets.all(.0),
                color: Colors.blue[900],
                width: 350,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[900],
                  ),
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      // All fields are valid, you can process the data
                      final field1Value = _field1Controller.text;
                      final field2Value = _field2Controller.text;
                      final field3Value = _field3Controller.text;
                      final field4Value = _field4Controller.text;

                      // Perform actions with the field values
                      print('Field 1: $field1Value');
                      print('Field 2: $field2Value');
                      print('Field 3: $field3Value');
                      print('Field 4: $field4Value');
                    }
                  },
                  child: Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
