import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mech_it/user/routine_maintenance_services_page.dart';
import 'package:mech_it/user/break_downs_services_page.dart';
import 'package:provider/provider.dart';

class SelectedServicesPage extends StatefulWidget {
  @override
  _SelectedServicesPageState createState() => _SelectedServicesPageState();
}

class _SelectedServicesPageState extends State<SelectedServicesPage> {
  List<String> selectedProblems = []; // Define a list to store selected problems
  List<String> selectedThings = []; // Define a list to store selected things

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Selected Services"),
      ),
      body: ListView(
        children: [
          if (selectedProblems.isNotEmpty)
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Selected Problems:",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Divider(),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: selectedProblems.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(selectedProblems[index]),
                      trailing: IconButton(
                        icon: Icon(Icons.remove_circle),
                        onPressed: () {
                          setState(() {
                            selectedProblems.removeAt(index);
                          });
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          if (selectedThings.isNotEmpty)
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Selected Things:",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Divider(),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: selectedThings.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(selectedThings[index]),
                      trailing: IconButton(
                        icon: Icon(Icons.remove_circle),
                        onPressed: () {
                          setState(() {
                            selectedThings.removeAt(index);
                          });
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
        ],
      ),
      // Rest of your UI for vehicle, routine maintenance, payment summary, buttons, etc.
    );
  }
}
