

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:mech_it/user/selected_services_page.dart';

import 'package:cloud_firestore/cloud_firestore.dart';


void main() {
  runApp(MaterialApp(
    home: MapPage(selectedProblems: [], selectedThings: [],),
  ));
}

class MapPage extends StatefulWidget {
  final List<String> selectedProblems;
  final List<String> selectedThings;

  MapPage({
    required this.selectedProblems,
    required this.selectedThings,
  });

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  bool isSecondBottomSheetVisible = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _showConfirmationDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Cancel Order"),
          content: Text("Are you sure you want to cancel your order?"),
          actions: <Widget>[
            TextButton(
              child: Text("No"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text("Yes"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                // Clear the navigation stack and reset the lists
                Navigator.of(context).pushNamedAndRemoveUntil(
                  'UserHomePage',
                      (route) => false,
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _showSecondBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      builder: (BuildContext context) {
        final screenHeight = MediaQuery.of(context).size.height;
        final desiredHeight = screenHeight * 0.6;

        return WillPopScope(
            onWillPop: () async {
              await _showConfirmationDialog();
              return false; // Prevent the second bottom sheet from being closed
            },

        child: StatefulBuilder(
          builder: (context, setState) {
            return Container(
              height: desiredHeight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: DefaultTextStyle(
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                        child: AnimatedTextKit(
                          animatedTexts: [
                            TyperAnimatedText("Looking for a mechanic"),
                            TyperAnimatedText("Requesting... Please Wait"),
                          ],
                          repeatForever: true,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  SizedBox(
                    height: 6,
                    child: DashedLoadingLine(),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 10.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(Icons.directions_car, color: Colors.blue),
                                SizedBox(width: 4.0),
                                Text(
                                  "Your Vehicle",
                                  style: TextStyle(fontSize: 16.0),
                                ),
                                Spacer(),
                                Icon(Icons.money, color: Colors.blue),
                                SizedBox(width: 4.0),
                                Text(
                                  "Rs. 300",
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(Icons.location_on, color: Colors.blue),
                                SizedBox(width: 4.0),
                                Expanded(
                                  child: Text(
                                    "User's Live Address",
                                    style: TextStyle(fontSize: 16.0),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.0),
          ////////////////////////////////////         View 1
                            Card(
                              elevation: 4.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Text(
                                      "Selected Problems",
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    for (String problem in widget.selectedProblems)
                                      ListTile(
                                        title: Text(problem),
                                      ),
                                    for (String thing in widget.selectedThings)
                                      ListTile(
                                        title: Text(thing),
                                      ),
                                  ],
                                ),
                              ),
                            ),

          ////////////////////////////////////         View 2
                            // Card(
                            //   elevation: 4.0,
                            //   shape: RoundedRectangleBorder(
                            //     borderRadius: BorderRadius.circular(20.0),
                            //   ),
                            //   child: Container(
                            //     height: 200, // Set a fixed height for the Card
                            //     child: ListView( // Wrap the Card in a ListView
                            //       children: [
                            //         Text(
                            //           "Selected Problems",
                            //           style: TextStyle(
                            //             fontSize: 16.0,
                            //             fontWeight: FontWeight.bold,
                            //           ),
                            //         ),
                            //         for (String problem in widget.selectedProblems)
                            //           ListTile(
                            //             title: Text(problem),
                            //           ),
                            //         for (String thing in widget.selectedThings)
                            //           ListTile(
                            //             title: Text(thing),
                            //           ),
                            //       ],
                            //     ),
                            //   ),
                            // ),


                            SizedBox(height: 6.0),
                            ElevatedButton(
                              onPressed: () {
                                // Pop all pages from the stack and push UserHome
                                // Navigator.of(context).pushNamedAndRemoveUntil('UserHomePage', (route) => false);
                                _showConfirmationDialog();
                              },
                              child: Text("Cancel"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7402,
                  child: FlutterMap(
                    options: MapOptions(
                      center: LatLng(19.2183, 72.9781),
                      zoom: 17.0,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                        "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                        subdomains: const ["a", "b", "c"],
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    isSecondBottomSheetVisible = true;
                  });
                  _showSecondBottomSheet();
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.1965,
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(height: 44.0),
                          Icon(Icons.location_on, color: Colors.blue),
                          SizedBox(width: 4.0),
                          Text(
                            "User's Current Address",
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.0),
                      Row(
                        children: [
                          Icon(Icons.directions_car, color: Colors.blue),
                          SizedBox(width: 4.0),
                          Text(
                            "Your Vehicle",
                            style: TextStyle(fontSize: 16.0),
                          ),
                          Spacer(),
                          Icon(Icons.money, color: Colors.blue),
                          SizedBox(width: 4.0),
                          Text(
                            "Cash",
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                      SizedBox(height: 1.0),
                      Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: ListTile(
                          title: Text(
                            "Find me a mechanic",
                            style: TextStyle(fontSize: 16.0),
                          ),
                          trailing: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Rs.",
                                  style: TextStyle(fontSize: 16.0),
                                ),
                                SizedBox(width: 4.0),
                                Text(
                                  "300",
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            uploadDataToFirestore(widget.selectedProblems, widget.selectedThings);
                            _showSecondBottomSheet();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (isSecondBottomSheetVisible)
                Container(
                  color: Colors.black.withOpacity(0.5),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

void uploadDataToFirestore(List<String> selectedProblems, List<String> selectedThings) async {
  final firestoreInstance = FirebaseFirestore.instance;

  try {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userId = user.uid;
      final orderID = '${DateTime.now().millisecondsSinceEpoch}';
      final orderData = {
        'selectedProblems': selectedProblems,
        'selectedThings': selectedThings,
        'timestamp': FieldValue.serverTimestamp(),
      };

      await firestoreInstance.collection('User_Post').doc(userId).collection('OrderID').doc(orderID).collection('Order').add(orderData);
    } else {
      print('User not logged in.');
    }
  } catch (e) {
    print('Error uploading data: $e');
  }
}

class DashedLoadingLine extends StatefulWidget {
  @override
  _DashedLoadingLineState createState() => _DashedLoadingLineState();
}

class _DashedLoadingLineState extends State<DashedLoadingLine> {
  double dashPhase = 0.0;
  final double dashWidth = 190.0; // Adjust the dash width as needed
  final double dashSpacing = 2.0; // Adjust the spacing between dashes as needed

  @override
  void initState() {
    super.initState();
    startDashAnimation();
  }

  void startDashAnimation() async {
    while (mounted) {
      await Future.delayed(Duration(milliseconds: 1));
      if (mounted) {
        setState(() {
          dashPhase = (dashPhase + 2) % (dashWidth + dashSpacing); // Control the speed and spacing independently
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 50),
      tween: Tween<double>(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return CustomPaint(
          size: Size(MediaQuery.of(context).size.width, 6), // Height of the dashed line
          painter: DashedLinePainter(dashPhase: dashPhase, dashWidth: dashWidth),
        );
      },
    );
  }
}

class DashedLinePainter extends CustomPainter {
  final double dashPhase;
  final double dashWidth;

  DashedLinePainter({required this.dashPhase, required this.dashWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.purple // Change the color as needed
      ..strokeWidth = 6 // Adjust the stroke/height of dashes width as needed
      ..style = PaintingStyle.stroke;

    for (double i = dashPhase; i < size.width; i += dashWidth * 2) {
      final double end = i + dashWidth;
      canvas.drawLine(Offset(i, 0), Offset(end, 0), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
