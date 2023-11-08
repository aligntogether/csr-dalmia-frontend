import 'package:dalmia/pages/vdf/household/addcrops.dart';
import 'package:dalmia/pages/vdf/household/addhead.dart';
import 'package:dalmia/pages/vdf/vdfhome.dart';
import 'package:dalmia/theme.dart';
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
          iconTheme: const IconThemeData(color: Color(0xFF181818)),
          centerTitle: true,
          title: const Text(
            'Add Household',
            style: TextStyle(
                color: Color(0xFF181818),
                fontSize: CustomFontTheme.headingSize,
                fontWeight: CustomFontTheme.headingwt),
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
                color: Color(0xFF181818),
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
                const Text(
                  'Add Land Ownership Details',
                  style: TextStyle(
                    fontSize: CustomFontTheme.textSize,
                    fontWeight: CustomFontTheme.headingwt,
                  ),
                ),
                const SizedBox(height: 32),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Rainfed',
                      style: TextStyle(
                          color: Color(0xFF181818).withOpacity(0.80),
                          fontSize: CustomFontTheme.textSize),
                    ),
                    const SizedBox(height: 16),
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
                const SizedBox(height: 32),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Irrigated',
                      style: TextStyle(
                          color: Color(0xFF181818).withOpacity(0.80),
                          fontSize: CustomFontTheme.textSize),
                    ),
                    const SizedBox(height: 16),
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
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustomColorTheme.primaryColor,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const AddCrop(),
                          ),
                        );
                      },
                      child: Text('Next'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        side: BorderSide(
                            color: CustomColorTheme.primaryColor, width: 1),
                        backgroundColor: Colors.white,
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
        side: isSelectedMap[acre]!
            ? BorderSide(width: 1, color: CustomColorTheme.iconColor)
            : BorderSide(width: 1, color: Color(0x99181818)),
        elevation: 0,
        minimumSize: const Size(85, 38),
        backgroundColor:
            isSelectedMap[acre]! ? const Color(0xFFF15A22) : Colors.white,
      ),
      child: Text(
        acre,
        style: TextStyle(
            color: isSelectedMap[acre]! ? Colors.white : Color(0xFF181818)),
      ),
    );
  }
}
