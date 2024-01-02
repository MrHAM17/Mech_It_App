


import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:convert';

import 'package:mech_it/mechanic/mech_home_screen.dart';

void main() {
  runApp(MaterialApp(
    home: MapPage(selectedProblems: [], selectedThings: []),
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
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  // Function to show mechanic details
  void showMechanicDetails(
      BuildContext context,
      String mechanicName,
      String mechanicPhone,
      String mechanicEmail,
      ) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Mechanic Details'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Mechanic Name: $mechanicName'),
              Text('Mechanic Phone: $mechanicPhone'),
              Text('Mechanic Email: $mechanicEmail'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  bool isSecondBottomSheetVisible = false;
  late var mechdetails;

  late Map<String, dynamic> orderData;

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


  //  ****************  ************************** ****************  **************************  view 5
  void _showSecondBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      builder: (BuildContext context) {
        final screenHeight = MediaQuery.of(context).size.height;
        final desiredHeight = screenHeight * 0.6;             // 60 %
        // final desiredHeight = screenHeight; // Set to full screen height            // 100 %

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
                    //                  // SizedBox(height: 5.0), // Add space at the top of the Column             // 60 %
                    SizedBox(height: 28.0), // Add space at the top of the Column             // 100 %

                    Card(
                      elevation: 20.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Padding(
                        //                     // padding: const EdgeInsets.all(16.0),
                        padding: const EdgeInsets.fromLTRB(16.0, 14.0, 16.0, 14.0),
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
                                    "₹ 850",
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
                              if (widget.selectedProblems.isNotEmpty)
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
                                      ],
                                    ),
                                  ),
                                ),
                              if (widget.selectedThings.isNotEmpty)
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
                                          "Selected Things",
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        for (String thing in widget.selectedThings)
                                          ListTile(
                                            title: Text(thing),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              SizedBox(height: 6.0),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: 2), // Add some spacing between the buttons
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0), // Add horizontal padding
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    // Handle Orders button action
                                    _showConfirmationDialog();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.blue, // Background color
                                    onPrimary: Colors.white, // Text color
                                    padding: EdgeInsets.symmetric(horizontal: 16), // Button padding
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10), // Button border radius
                                    ),
                                  ),
                                  child: Text("Cancel"),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    // Handle Responces button action
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.blue, // Background color
                                    onPrimary: Colors.white, // Text color
                                    padding: EdgeInsets.symmetric(horizontal: 16), // Button padding
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10), // Button border radius
                                    ),
                                  ),
                                  child: Text("All Responces"),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.blue, // Background color
                                    onPrimary: Colors.white, // Text color
                                    padding: EdgeInsets.symmetric(horizontal: 16), // Button padding
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10), // Button border radius
                                    ),
                                  ),
                                  child: Text("My Order"),
                                ),
                              ],
                            ),
                          ),
                        ],
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
                      // center: LatLng(19.2183, 72.9781),     // Thane Location
                      center: LatLng(19.0299202,73.0167709),   // Terna Campus Location
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
                                  "₹ ",
                                  style: TextStyle(fontSize: 16.0),
                                ),
                                SizedBox(width: 4.0),
                                Text(
                                  "850",
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              ],
                            ),
                          ),
                          onTap: () async {
                            uploadDataToFirestore(widget.selectedProblems, widget.selectedThings, 'mechanic_token_here');
                            _showSecondBottomSheet();
                            Future.delayed(Duration(seconds: 10));
                            showMechanicDetails(context, 'Atharva', '9322786689', 'atharvabirje200326@gmail.com');
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



void uploadDataToFirestore(List<String> selectedProblems, List<String> selectedThings, String mechanicToken) async {
  try {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userId = user.uid;
      final orderID = '${DateTime.now().millisecondsSinceEpoch}';
      final orderData = {
        'User ID'         : userId,
        'Order ID'        : orderID,
        'Status'          : 'Not Accepted',
        'Mech Name'       : 'harsh',
        'selectedProblems': selectedProblems,
        'selectedThings'  : selectedThings,
        'timestamp'       : FieldValue.serverTimestamp(),
        'mytime'          : '${DateTime.now().millisecondsSinceEpoch}',  // added extra for testing
      };

      // await FirebaseFirestore.instance.collection('User_Post').doc(userId).collection('OrderID').doc(orderID).collection('Order').add(orderData);
      await FirebaseFirestore.instance.collection('User_Post').doc(userId).collection('OrderID').add(orderData);
      // await FirebaseFirestore.instance.collection('User_Post').doc(userId).collection('orderData');        // not work
      
    }
    // else {
    //   print('User not logged in.');
    // }
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



void showMechanicDetails(String name, String photoUrl, String email) {
  var context;
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Mechanic Details'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(photoUrl),
              radius: 50, // Adjust the size as needed
            ),
            SizedBox(height: 16),
            Text('Name: $name'),
            SizedBox(height: 8),
            Text('Email: $email'),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text('Close'),
          ),
        ],
      );
    },
  );
}

