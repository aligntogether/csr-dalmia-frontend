import 'package:flutter/material.dart';

class Intervention {
  final String id;
  final String name;

  Intervention(this.id, this.name);
}

class Addinter extends StatefulWidget {
  @override
  _AddinterState createState() => _AddinterState();
}

class _AddinterState extends State<Addinter> {
  final _formKey = GlobalKey<FormState>();
  List<Intervention> interventions = [
    Intervention('1', 'Intervention 1'),
    Intervention('2', 'Intervention 2'),
    Intervention('3', 'Intervention 3'),
    Intervention('4', 'Intervention 4'),
  ];

  List<Intervention> filteredInterventions = [];
  TextEditingController interventionController = TextEditingController();
  bool showListView = true;

  void filterInterventions(String query) {
    setState(() {
      if (query.isNotEmpty) {
        filteredInterventions = interventions
            .where((intervention) =>
                intervention.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      } else {
        filteredInterventions = interventions;
      }
    });
  }

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
            'Add Intervention',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.grey[50],
          actions: <Widget>[
            IconButton(
              iconSize: 30,
              onPressed: () {
                Navigator.of(context).pop();
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
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Container(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 100.0),
                          child: Text(
                            'What intervention has been chosen for this family? ',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: interventionController,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Search Intervention name/ID',
                              suffixIcon: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.search),
                              )),
                          onChanged: (value) {
                            filterInterventions(value);
                          },
                        ),

                        // const SizedBox(height: 20),
                        if (showListView)
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: filteredInterventions.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title:
                                      Text(filteredInterventions[index].name),
                                  onTap: () {
                                    setState(() {
                                      interventionController.text =
                                          filteredInterventions[index].name;
                                      showListView = false;
                                    });
                                  },
                                );
                              },
                            ),
                          ),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(350, 50),
                          ),
                          onPressed: () {
                            _confirmitem(context);
                          },
                          child: const Text('Confirm'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void _confirmitem(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return FractionallySizedBox(
        heightFactor: 0.3,
        child: AlertDialog(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('What do you wish to do next?'),
            ],
          ),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(10),
                  backgroundColor: Colors.white,
                ),
                onPressed: () {},
                child: Text(
                  'Save HH as draft and add intervention later ',
                  style: TextStyle(color: Colors.blue[900]),
                ),
              ),
              ElevatedButton(
                style:
                    ElevatedButton.styleFrom(backgroundColor: Colors.blue[900]),
                onPressed: () {
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) => const Login(),
                  //   ),
                  // );
                  // Perform actions when 'Yes' is clicked
                },
                child: const Text('Continue adding Intervention'),
              ),
            ],
          ),
        ),
      );
    },
  );
}
