


// ********************** Below          Code 1 -->   For basic UI & backend functionality    *****************************************************


// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:mech_it/user/routine_maintenance_services_page.dart';
// import 'package:mech_it/user/break_downs_services_page.dart';
// import 'package:provider/provider.dart';
//
// class SelectedServicesPage extends StatefulWidget {
//   final List<String> selectedProblems;
//   final List<String> selectedThings;
//
//   SelectedServicesPage({
//     required this.selectedProblems,
//     required this.selectedThings,
//   });
//
//   @override
//   _SelectedServicesPageState createState() => _SelectedServicesPageState();
// }
//
//
// class _SelectedServicesPageState extends State<SelectedServicesPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Final Selected Services"),
//       ),
//       body: ListView(
//         children: [
//           if (widget.selectedProblems.isNotEmpty)
//             Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(
//                     "Selected Problems:",
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 Divider(),
//                 ListView.builder(
//                   shrinkWrap: true,
//                   itemCount: widget.selectedProblems.length,
//                   itemBuilder: (context, index) {
//                     return ListTile(
//                       title: Text(widget.selectedProblems[index]),
//                       trailing: IconButton(
//                         icon: Icon(Icons.remove_circle),
//                         onPressed: () {
//                           setState(() {
//                             widget.selectedProblems.removeAt(index);
//                           });
//                         },
//                       ),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           if (widget.selectedThings.isNotEmpty)
//             Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(
//                     "Selected Things:",
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 Divider(),
//                 ListView.builder(
//                   shrinkWrap: true,
//                   itemCount: widget.selectedThings.length,
//                   itemBuilder: (context, index) {
//                     return ListTile(
//                       title: Text(widget.selectedThings[index]),
//                       trailing: IconButton(
//                         icon: Icon(Icons.remove_circle),
//                         onPressed: () {
//                           setState(() {
//                             widget.selectedThings.removeAt(index);
//                           });
//                         },
//                       ),
//                     );
//                   },
//                 ),
//               ],
//             ),
//         ],
//       ),
//       // Rest of your UI for vehicle, routine maintenance, payment summary, buttons, etc.
//     );
//   }
// }
//



// ********************** Below          Code 2 -->   For updated UI & same backend functionality    *****************************************************






// import 'package:flutter/material.dart';
//
// class SelectedServicesPage extends StatefulWidget {
//   final List<String> selectedProblems;
//   final List<String> selectedThings;
//
//   SelectedServicesPage({
//     required this.selectedProblems,
//     required this.selectedThings,
//   });
//
//   @override
//   _SelectedServicesPageState createState() => _SelectedServicesPageState();
// }
//
// class _SelectedServicesPageState extends State<SelectedServicesPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: null,
//       backgroundColor: Colors.deepPurple[100], // Set the background color for the entire screen
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(top: 22.0, bottom: 10.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(
//                   Icons.directions_car,
//                   size: 32,
//                 ),
//                 SizedBox(width: 5),
//                 Text(
//                   'Your Vehicle',
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: 16),
//           Container(
//             width: 350, // Set a fixed width for the boxes
//             height: 250, // Set a fixed height for the boxes
//             child: ServiceCard(
//               title: "Breakdowns",
//               items: widget.selectedProblems,
//               onRemove: (index) {
//                 setState(() {
//                   widget.selectedProblems.removeAt(index);
//                 });
//               },
//             ),
//           ),
//           SizedBox(height: 8),
//           Container(
//             width: 350, // Set a fixed width for the boxes
//             height: 250, // Set a fixed height for the boxes
//             child: ServiceCard(
//               title: "Routine Maintenance",
//               items: widget.selectedThings,
//               onRemove: (index) {
//                 setState(() {
//                   widget.selectedThings.removeAt(index);
//                 });
//               },
//             ),
//           ),
//           SizedBox(height: 8),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 ElevatedButton(
//                   onPressed: () {
//                     // Add more services button logic
//                     Navigator.pop(context);
//                   },
//                   style: ElevatedButton.styleFrom(
//                     primary: Colors.blue,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     elevation: 10, // Increase elevation for "Add More Services" button
//                   ),
//                   child: Text(
//                     'Add More Services',
//                     style: TextStyle(fontSize: 18),
//                   ),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     // Let's confirm button logic
//                     // Navigate to the next screen
//                   },
//                   style: ElevatedButton.styleFrom(
//                     primary: Colors.green,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     elevation: 10, // Increase elevation for "Let's Confirm" button
//                   ),
//                   child: Text(
//                     "Let's Confirm",
//                     style: TextStyle(fontSize: 18),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class ServiceCard extends StatelessWidget {
//   final String title;
//   final List<String> items;
//   final Function(int) onRemove;
//
//   ServiceCard({
//     required this.title,
//     required this.items,
//     required this.onRemove,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: title == "Breakdowns" || title == "Routine Maintenance" ? 10 : 2, // Increase elevation for both "Breakdowns" and "Routine Maintenance"
//       color: Colors.white,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           ListTile(
//             title: Material( // Wrap the Text widget with Material
//               elevation: 5, // Add shadow just below the text
//               child: Text(
//                 title,
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             child: Column(
//               children: [
//                 Divider(),
//                 if (items.isNotEmpty)
//                   Expanded(
//                     child: ListView.builder(
//                       shrinkWrap: true,
//                       itemCount: items.length,
//                       itemBuilder: (context, index) {
//                         return ListTile(
//                           title: Material( // Wrap the Text widget with Material
//                             elevation: 5, // Add shadow just below the text
//                             child: Text(items[index]),
//                           ),
//                           trailing: IconButton(
//                             icon: Icon(Icons.remove_circle),
//                             onPressed: () => onRemove(index),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 if (items.isEmpty)
//                   Padding(
//                     padding: const EdgeInsets.all(50.0),
//                     child: Text(
//                       "NA",
//                       style: TextStyle(fontSize: 16),
//                     ),
//                   ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//
// void main() {
//   runApp(MaterialApp(
//     home: SelectedServicesPage(
//       selectedProblems: ["Problem 1", "Problem 2"],
//       selectedThings: ["Thing 1", "Thing 2"],
//     ),
//   ));
// }







// ********************** Below          Code 3 -->   For updated UI & same backend functionality    *****************************************************





//
//
// import 'package:flutter/material.dart';
//
// class SelectedServicesPage extends StatefulWidget {
//   final List<String> selectedProblems;
//   final List<String> selectedThings;
//
//   SelectedServicesPage({
//     required this.selectedProblems,
//     required this.selectedThings,
//   });
//
//   @override
//   _SelectedServicesPageState createState() => _SelectedServicesPageState();
// }
//
// class _SelectedServicesPageState extends State<SelectedServicesPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: null,
//       backgroundColor: Colors.deepPurple[100],
//       body: CustomScrollView(
//         slivers: [
//           SliverPadding(
//             padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
//             sliver: SliverToBoxAdapter(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   Center(
//                     child: Column(
//                       children: [
//                         Icon(
//                           Icons.directions_car,
//                           size: 32,
//                         ),
//                         SizedBox(height: 3.0),
//                         Text(
//                           'Your Vehicle',
//                           style: TextStyle(
//                             fontSize: 24,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 6),
//                   Container(
//                     height: 225,
//                     child: ServiceCard(
//                       title: "Breakdowns",
//                       items: widget.selectedProblems,
//                       onRemove: (index) {
//                         setState(() {
//                           widget.selectedProblems.removeAt(index);
//                         });
//                       },
//                     ),
//                   ),
//                   SizedBox(height: 6),
//                   Container(
//                     height: 225,
//                     child: ServiceCard(
//                       title: "Routine Maintenance",
//                       items: widget.selectedThings,
//                       onRemove: (index) {
//                         setState(() {
//                           widget.selectedThings.removeAt(index);
//                         });
//                       },
//                     ),
//                   ),
//                   SizedBox(height: 6),
//                   Container(
//                     margin: EdgeInsets.symmetric(vertical: 4.0),
//                     padding: EdgeInsets.all(16.0),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(20),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.2),
//                           spreadRadius: 2,
//                           blurRadius: 5,
//                           offset: Offset(0, 3),
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         Text(
//                           'Payment Summary',
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         SizedBox(height: 12),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text('Sub Total', style: TextStyle(fontSize: 18)),
//                             Text(
//                               // Add dynamic content here for charges based on user selection
//                               '\$200',
//                               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 12),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text('Visit Fare', style: TextStyle(fontSize: 18)),
//                             Text('\$100', style: TextStyle(fontSize: 18)),
//                           ],
//                         ),
//                         SizedBox(height: 12),
//                         Divider(
//                           thickness: 1,
//                           color: Colors.grey,
//                         ),
//                         SizedBox(height: 12),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               'Total Estimated Fare',
//                               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                             ),
//                             Text(
//                               // Add dynamic content here for total charges
//                               '\$300',
//                               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                             ),
//                           ],
//                         ),
//                         // SizedBox(height: 12),
//                         // Text(
//                         //   'Additional Charges: \$50', // Add your additional charges text here
//                         //   style: TextStyle(fontSize: 16),
//                         // ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 12),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       ElevatedButton(
//                         onPressed: () {
//                           // Add more services button logic
//                           Navigator.pop(context);
//                         },
//                         style: ElevatedButton.styleFrom(
//                           primary: Colors.blue,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                         ),
//                         child: Text(
//                           'Add More Services',
//                           style: TextStyle(fontSize: 18),
//                         ),
//                       ),
//                       ElevatedButton(
//                         onPressed: () {
//                           // Let's confirm button logic
//                           // Navigate to the next screen
//                         },
//                         style: ElevatedButton.styleFrom(
//                           primary: Colors.green,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                         ),
//                         child: Text(
//                           "Let's Confirm",
//                           style: TextStyle(fontSize: 18),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class ServiceCard extends StatelessWidget {
//   final String title;
//   final List<String> items;
//   final Function(int) onRemove;
//
//   ServiceCard({
//     required this.title,
//     required this.items,
//     required this.onRemove,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 18.0),
//       padding: EdgeInsets.all(18.0),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.2),
//             spreadRadius: 2,
//             blurRadius: 5,
//             offset: Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Material(
//             elevation: 5, // Add elevation to this section
//             child: Text(
//               title,
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           SizedBox(height: 8),
//           if (items.isNotEmpty)
//             Expanded(
//               child: ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: items.length,
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     title: Text(items[index]),
//                     trailing: IconButton(
//                       icon: Icon(Icons.remove_circle),
//                       onPressed: () => onRemove(index),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           if (items.isEmpty)
//             Container(
//               alignment: Alignment.center,
//               padding: EdgeInsets.all(55),
//               child: Text(
//                 "NA",
//                 style: TextStyle(fontSize: 16),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }
//
// void main() {
//   runApp(MaterialApp(
//     home: SelectedServicesPage(
//       selectedProblems: List.generate(10, (index) => "Problem $index"),
//       selectedThings: List.generate(10, (index) => "Thing $index"),
//     ),
//   ));
// }








// ********************** Below          Code 4 -->   For updated UI & quite backend functionality    *****************************************************
// clearing previously selected data when user go back to home page & again come to add problem






import 'package:flutter/material.dart';

import 'package:mech_it/user/map_page.dart';

class SelectedServicesPage extends StatefulWidget {
  final List<String> selectedProblems;
  final List<String> selectedThings;

  SelectedServicesPage({
    required this.selectedProblems,
    required this.selectedThings,
  });

  @override
  _SelectedServicesPageState createState() => _SelectedServicesPageState();
}

class _SelectedServicesPageState extends State<SelectedServicesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      backgroundColor: Colors.deepPurple[100],
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center, // Align the Row's content to the center.
                      children: [
                        Icon(
                          Icons.directions_car,
                          size: 32,
                        ),
                        SizedBox(height: 28.0),
                        SizedBox(width: 16), // Increase the value to add more space between the icon and text
                        Text(
                          'Your Vehicle',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 1),
                  Container(
                    height: 225,
                    child: ServiceCard(
                      title: "Breakdowns",
                      items: widget.selectedProblems,
                      onRemove: (index) {
                        setState(() {
                          widget.selectedProblems.removeAt(index);
                        });
                      },
                    ),
                  ),
                  SizedBox(height:0),
                  Container(
                    height: 225,
                    child: ServiceCard(
                      title: "Routine Maintenance",
                      items: widget.selectedThings,
                      onRemove: (index) {
                        setState(() {
                          widget.selectedThings.removeAt(index);
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 0),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 4.0),
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Payment Summary',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Sub Total', style: TextStyle(fontSize: 18)),
                            Text(
                              // Add dynamic content here for charges based on user selection
                              '\$200',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Visit Fare', style: TextStyle(fontSize: 18)),
                            Text('\$100', style: TextStyle(fontSize: 18)),
                          ],
                        ),
                        SizedBox(height: 6),
                        Divider(
                          thickness: 1,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Estimated Fare',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              // Add dynamic content here for total charges
                              '\$300',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        // SizedBox(height: 12),
                        // Text(
                        //   'Additional Charges: \$50', // Add your additional charges text here
                        //   style: TextStyle(fontSize: 16),
                        // ),
                      ],
                    ),
                  ),
                  SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Add more services button logic
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          'Add More Services',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (widget.selectedProblems.isNotEmpty || widget.selectedThings.isNotEmpty) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MapPage(
                                  selectedProblems: widget.selectedProblems, // Pass selectedProblems
                                  selectedThings: widget.selectedThings,     // Pass selectedThings
                                ),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("You haven't selected any problem"),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          "Let's Confirm",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final String title;
  final List<String> items;
  final Function(int) onRemove;

  ServiceCard({
    required this.title,
    required this.items,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 18.0),
      padding: EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Material(
            elevation: 5, // Add elevation to this section
            child: Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 8),
          if (items.isNotEmpty)
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(items[index]),
                    trailing: IconButton(
                      icon: Icon(Icons.remove_circle),
                      onPressed: () => onRemove(index),
                    ),
                  );
                },
              ),
            ),
          if (items.isEmpty)
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(55),
              child: Text(
                "NA",
                style: TextStyle(fontSize: 16),
              ),
            ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: SelectedServicesPage(
      selectedProblems: List.generate(10, (index) => "Problem $index"),
      selectedThings: List.generate(10, (index) => "Thing $index"),
    ),
  ));
}
