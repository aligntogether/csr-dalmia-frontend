import 'package:dalmia/pages/vdf/household/addcrops.dart';
import 'package:dalmia/pages/vdf/household/addhead.dart';
import 'package:dalmia/pages/vdf/vdfhome.dart';
import 'package:flutter/material.dart';

class AddLand extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<AddLand> {
  void updateRainfedSelection(String selectedAcre) {
    setState(() {
      for (var key in selectedRainfedMap.keys) {
        selectedRainfedMap[key] = key == selectedAcre;
      }
    });
  }

  void updateIrrigatedSelection(String selectedAcre) {
    setState(() {
      for (var key in selectedIrrigatedMap.keys) {
        selectedIrrigatedMap[key] = key == selectedAcre;
      }
    });
  }

  final Map<String, bool> selectedRainfedMap = {
    '1 acres': false,
    '2 acres': false,
    '3 acres': false,
    '4 acres': false,
    '5 acres': false,
    '5 & above': false,
  };

  final Map<String, bool> selectedIrrigatedMap = {
    '1 acres': false,
    '2 acres': false,
    '3 acres': false,
    '4 acres': false,
    '5 acres': false,
    '5 & above': false,
  };
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
        body: SingleChildScrollView(
          child: Padding(
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
                    FractionallySizedBox(
                      widthFactor: 1.0,
                      child: Wrap(
                        alignment: WrapAlignment.spaceAround,
                        runSpacing: 20,
                        spacing: 20,
                        children: [
                          InputDetail('1 acres', selectedRainfedMap,
                              updateRainfedSelection),
                          InputDetail('2 acres', selectedRainfedMap,
                              updateRainfedSelection),
                          InputDetail('3 acres', selectedRainfedMap,
                              updateRainfedSelection),
                          InputDetail('4 acres', selectedRainfedMap,
                              updateRainfedSelection),
                          InputDetail('5 acres', selectedRainfedMap,
                              updateRainfedSelection),
                          InputDetail('5 & above', selectedRainfedMap,
                              updateRainfedSelection),
                        ],
                      ),
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
                    FractionallySizedBox(
                      widthFactor: 1.0,
                      child: Wrap(
                        alignment: WrapAlignment.spaceAround,
                        runSpacing: 20,
                        spacing: 20,
                        children: [
                          InputDetail('1 acres', selectedIrrigatedMap,
                              updateIrrigatedSelection),
                          InputDetail('2 acres', selectedIrrigatedMap,
                              updateIrrigatedSelection),
                          InputDetail('3 acres', selectedIrrigatedMap,
                              updateIrrigatedSelection),
                          InputDetail('4 acres', selectedIrrigatedMap,
                              updateIrrigatedSelection),
                          InputDetail('5 acres', selectedIrrigatedMap,
                              updateIrrigatedSelection),
                          InputDetail('5 & above', selectedIrrigatedMap,
                              updateIrrigatedSelection),
                        ],
                      ),
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
      ),
    );
  }
}

class InputDetail extends StatelessWidget {
  final String acre;
  final Map<String, bool> isSelectedMap;
  final Function(String) updateSelection;

  const InputDetail(this.acre, this.isSelectedMap, this.updateSelection,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        updateSelection(acre);
      },
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(85, 38),
        backgroundColor:
            isSelectedMap[acre]! ? const Color(0xFFF15A22) : Colors.white,
      ),
      child: Text(
        acre,
        style: TextStyle(
            color: isSelectedMap[acre]! ? Colors.white : Colors.black),
      ),
    );
  }
}
