
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



// ********************   *******************   ***************************   *******************  View 1 (Old one but fine)
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
                            Text('Sub Total', style: TextStyle(fontSize: 18)),    // Add dynamic content here for charges based on user selection
                            Text('\₹ 750',   style: TextStyle(fontSize: 18),                                         // $ tha instead of  ₹
                              // style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Visit Fare', style: TextStyle(fontSize: 18)),
                            Text('\₹ 100', style: TextStyle(fontSize: 18)),         // $ tha instead of  ₹
                            // style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                            Text('\₹ 850', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),  // Add dynamic content here for total charges     // $ tha instead of  ₹
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
                          primary: Colors.deepPurpleAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(11),   // old = 20
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
                            borderRadius: BorderRadius.circular(14), // old = 20
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


// ********************   *******************   ***************************   *******************  View 2
// class _SelectedServicesPageState extends State<SelectedServicesPage> {
//   @override
//   Widget build(BuildContext context) {
//
//     // not working
//     // Colors:Container(
//     //     decoration: BoxDecoration(
//     //       gradient: LinearGradient(
//     //         colors: [Colors.blue, Colors.deepPurple],
//     //         begin: Alignment.topLeft,
//     //         end: Alignment.bottomLeft,
//     //       ),
//     //     ),
//     // );
//     return Scaffold(
//       appBar: null,
//       body: CustomScrollView(
//         slivers: [
//           SliverPadding(
//             padding: EdgeInsets.symmetric(vertical: .0, horizontal: .0),   // old = 20, 16
//             sliver: SliverToBoxAdapter(
//               child: Container(
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [Colors.blue, Colors.deepPurple],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomLeft,
//                   ),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     Center(
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(
//                             Icons.directions_car,
//                             size: 32,
//                           ),
//                           SizedBox(height: 28.0),
//                           SizedBox(width: 16),
//                           Text(
//                             'Your Vehicle',
//                             style: TextStyle(
//                               fontSize: 24,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: 1),
//                     Container(
//                       height: 225,
//                       child: ServiceCard(
//                         title: "Breakdowns",
//                         items: widget.selectedProblems,
//                         onRemove: (index) {
//                           setState(() {
//                             widget.selectedProblems.removeAt(index);
//                           });
//                         },
//                       ),
//                     ),
//                     SizedBox(height: 0),
//                     Container(
//                       height: 225,
//                       child: ServiceCard(
//                         title: "Routine Maintenance",
//                         items: widget.selectedThings,
//                         onRemove: (index) {
//                           setState(() {
//                             widget.selectedThings.removeAt(index);
//                           });
//                         },
//                       ),
//                     ),
//                     SizedBox(height: 0),
//                     Container(
//                       margin: EdgeInsets.symmetric(vertical: 4.0),
//                       padding: EdgeInsets.all(16.0),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(20),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.2),
//                             spreadRadius: 2,
//                             blurRadius: 5,
//                             offset: Offset(0, 3),
//                           ),
//                         ],
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.stretch,
//                         children: [
//                           Text(
//                             'Payment Summary',
//                             style: TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           SizedBox(height: 10),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text('Sub Total', style: TextStyle(fontSize: 18)),
//                               Text(
//                                 '\$200',
//                                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 10),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text('Visit Fare', style: TextStyle(fontSize: 18)),
//                               Text('\$100', style: TextStyle(fontSize: 18)),
//                             ],
//                           ),
//                           SizedBox(height: 6),
//                           Divider(
//                             thickness: 1,
//                             color: Colors.grey,
//                           ),
//                           SizedBox(height: 10),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 'Total Estimated Fare',
//                                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                               ),
//                               Text(
//                                 '\$300',
//                                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: 6),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         ElevatedButton(
//                           onPressed: () {
//                             Navigator.pop(context);
//                           },
//                           style: ElevatedButton.styleFrom(
//                             primary: Colors.deepPurpleAccent,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(11), // old = 20
//                             ),
//                           ),
//                           child: Text(
//                             'Add More Services',
//                             style: TextStyle(fontSize: 18),
//                           ),
//                         ),
//                         ElevatedButton(
//                           onPressed: () {
//                             if (widget.selectedProblems.isNotEmpty || widget.selectedThings.isNotEmpty) {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => MapPage(
//                                     selectedProblems: widget.selectedProblems,
//                                     selectedThings: widget.selectedThings,
//                                   ),
//                                 ),
//                               );
//                             } else {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(
//                                   content: Text("You haven't selected any problem"),
//                                 ),
//                               );
//                             }
//                           },
//                           style: ElevatedButton.styleFrom(
//                             primary: Colors.green,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(14), // old = 20
//                             ),
//                           ),
//                           child: Text(
//                             "Let's Confirm",
//                             style: TextStyle(fontSize: 18),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


// ********************   *******************   ***************************   *******************  View 3
// class _SelectedServicesPageState extends State<SelectedServicesPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: null,
//       body: CustomScrollView(
//         slivers: [
//           SliverPadding(
//             padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
//             sliver: SliverToBoxAdapter(
//               child: Container(
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [Colors.blue, Colors.deepPurple],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     Center(
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(
//                             Icons.directions_car,
//                             size: 32,
//                           ),
//                           SizedBox(height: 28.0),
//                           SizedBox(width: 16),
//                           Text(
//                             'Your Vehicle',
//                             style: TextStyle(
//                               fontSize: 24,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: 1),
//                     Container(
//                       height: 225,
//                       child: ServiceCard(
//                         title: "Breakdowns",
//                         items: widget.selectedProblems,
//                         onRemove: (index) {
//                           setState(() {
//                             widget.selectedProblems.removeAt(index);
//                           });
//                         },
//                       ),
//                     ),
//                     SizedBox(height: 0),
//                     Container(
//                       height: 225,
//                       child: ServiceCard(
//                         title: "Routine Maintenance",
//                         items: widget.selectedThings,
//                         onRemove: (index) {
//                           setState(() {
//                             widget.selectedThings.removeAt(index);
//                           });
//                         },
//                       ),
//                     ),
//                     SizedBox(height: 0),
//                     Container(
//                       margin: EdgeInsets.symmetric(vertical: 4.0),
//                       padding: EdgeInsets.all(16.0),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(20),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.2),
//                             spreadRadius: 2,
//                             blurRadius: 5,
//                             offset: Offset(0, 3),
//                           ),
//                         ],
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.stretch,
//                         children: [
//                           Text(
//                             'Payment Summary',
//                             style: TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           SizedBox(height: 10),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text('Sub Total', style: TextStyle(fontSize: 18)),
//                               Text(
//                                 '\$200',
//                                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 10),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text('Visit Fare', style: TextStyle(fontSize: 18)),
//                               Text('\$100', style: TextStyle(fontSize: 18)),
//                             ],
//                           ),
//                           SizedBox(height: 6),
//                           Divider(
//                             thickness: 1,
//                             color: Colors.grey,
//                           ),
//                           SizedBox(height: 10),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 'Total Estimated Fare',
//                                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                               ),
//                               Text(
//                                 '\$300',
//                                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: 6),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         ElevatedButton(
//                           onPressed: () {
//                             Navigator.pop(context);
//                           },
//                           style: ElevatedButton.styleFrom(
//                             primary: Colors.deepPurpleAccent,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(11), // old = 20
//                             ),
//                           ),
//                           child: Text(
//                             'Add More Services',
//                             style: TextStyle(fontSize: 18),
//                           ),
//                         ),
//                         ElevatedButton(
//                           onPressed: () {
//                             if (widget.selectedProblems.isNotEmpty || widget.selectedThings.isNotEmpty) {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => MapPage(
//                                     selectedProblems: widget.selectedProblems,
//                                     selectedThings: widget.selectedThings,
//                                   ),
//                                 ),
//                               );
//                             } else {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(
//                                   content: Text("You haven't selected any problem"),
//                                 ),
//                               );
//                             }
//                           },
//                           style: ElevatedButton.styleFrom(
//                             primary: Colors.green,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(14), // old = 20
//                             ),
//                           ),
//                           child: Text(
//                             "Let's Confirm",
//                             style: TextStyle(fontSize: 18),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

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
