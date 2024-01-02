import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
                            uploadDataToFirestore(widget.selectedProblems, widget.selectedThings, 'mechanic_token_here');
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

void uploadDataToFirestore(List<String> selectedProblems, List<String> selectedThings, String mechanicToken) async {
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

      await FirebaseFirestore.instance.collection('User_Post').doc(userId).collection('OrderID').doc(orderID).collection('Order').add(orderData);

      // Send a notification to your server with the mechanic's FCM token and order ID
      await sendNotificationToServer(mechanicToken, orderID);
    } else {
      print('User not logged in.');
    }
  } catch (e) {
    print('Error uploading data: $e');
  }
}

Future<void> sendNotificationToServer(String mechanicToken, String orderID) async {
  final serverUrl = 'YOUR_SERVER_URL'; // Replace with your server URL // ##############################    PAID                 #####################################################################
  final headers = {
    'Content-Type': 'application/json',
  };

  final body = jsonEncode({
    'mechanicToken': mechanicToken,
    'orderID': orderID,
  });

  try {
    final response = await http.post(
      Uri.parse(serverUrl),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      print('Notification sent to server');
    } else {
      print('Failed to send notification to server. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error sending notification to server: $e');
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


/*
Widget Structure: The code defines a Flutter app with a single screen, MapPage, that displays a map, vehicle and address information, and a user interface for booking a mechanic.

Map Display: The map is displayed using the flutter_map library, and it centers around a specific geographical location with a specific zoom level. In this code, it centers around latitude 19.2183 and longitude 72.9781.

Mechanic Booking Interface: When you tap on a specific area in the UI (probably a "Find me a mechanic" button), it triggers a function (_showSecondBottomSheet) to display a second bottom sheet (a UI element that slides up from the bottom). This sheet contains a loading animation, vehicle information, and selected problems.

Cancel Order: You can also cancel the order by clicking a "Cancel" button, which will display a confirmation dialog asking the user if they are sure they want to cancel the order.

Sending Data to Firestore: When you book a mechanic, it triggers the uploadDataToFirestore function. This function uploads data to a Firestore database. It associates the order with a specific user and generates a unique order ID.


**** ******* **********
Sending Notifications: After uploading data to Firestore, the code attempts to send a notification to the mechanic using the sendNotificationToServer function. However, this part is commented out, and the comment indicates that you should replace 'YOUR_SERVER_URL' with your actual server URL. The code is set up to send an HTTP POST request with JSON data to the specified server URL. The server should be set up to handle this request and send a notification to the mechanic with the provided FCM token and order ID.
**** ******* **********


Loading Animation: The code includes a loading animation of a dashed line using a custom widget DashedLoadingLine. This animation runs infinitely.

UI Styling: The code defines various UI elements such as cards, icons, buttons, and text styles to create a visually appealing interface for the mechanic booking process.

It's important to note that this code is part of a Flutter app, and the actual functionality may depend on external components, such as your server for sending notifications and Firestore for storing data. Make sure to replace placeholders like 'YOUR_SERVER_URL' with the actual values relevant to your project.
*/









// P.S. ---->>>>>

/*
Sending notifications from your server to a client device via Firebase Cloud Messaging (FCM) is not inherently a paid feature of Firebase, but there are some considerations to keep in mind:

Firebase Cloud Messaging (FCM): Firebase provides FCM as a free service for sending notifications to client devices. You can use FCM to send messages to devices on iOS, Android, and web. Basic notification functionality, like sending a message to a specific device with a specific token, is available for free.

Rate Limits: Firebase, like many other cloud services, has rate limits on the usage of its free tier. These limits can affect the number of messages you can send, how quickly you can send them, and how many devices you can send messages to. If you have a large number of users and need to send a high volume of messages, you may hit these rate limits.

Custom Server: In the code you provided, there's a section that sends an HTTP POST request to a server with the intention that this server will then use FCM to send a notification. The cost of maintaining and running this server is your responsibility, and it can vary depending on your server infrastructure and usage.

Costs for Additional Features: While basic FCM functionality is free, Firebase offers additional features like message targeting, analytics, and more advanced functionality that may come with associated costs. Be sure to review Firebase's pricing documentation to understand potential costs for these features.

In summary, sending basic FCM notifications from your server to client devices is generally free. However, if you plan to send a high volume of notifications or use advanced Firebase features, you should review Firebase's pricing to understand any potential costs that may apply to your specific use case.
*/