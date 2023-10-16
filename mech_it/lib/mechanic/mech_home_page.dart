import 'dart:async';

import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:mech_it/mechanic/mech_map_screen.dart';
import 'package:mech_it/mechanic/mech_register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mech_it/user/map_page.dart';

import 'package:firebase_messaging/firebase_messaging.dart';

// Initialize Firebase Messaging
// final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();


class UserData {
  final String Name;
  final String Email;

  UserData(this.Name, this.Email);
}

class MechHomePage extends StatefulWidget {
  @override
  _MechHomePageState createState() => _MechHomePageState();
}

class _MechHomePageState extends State<MechHomePage> {
  late StreamSubscription<QuerySnapshot> orderStream;
  String? latestOrderID;
  Map<String, dynamic> userData = {};
  bool isOnline = true;
  bool showIndividual = true;
  String mechanicName = '';
  String mechanicEmail = '';
  String mechanicPhoto = '';

  @override
  void initState() {
    super.initState();
    _loadMechanicData();

    // orderStream = FirebaseFirestore.instance
    //     .collection('User_Post')
    //     .snapshots()
    //     .listen((event) {
    //   if (event.docs.isNotEmpty) {
    //     var latestOrder = event.docs.first.data();
    //     sendNotificationToMechanics(
    //         'mechanic_token_here', latestOrder['orderID']);
    //     print('hiii............');
    //     showOrderDetailsToMechanic(latestOrder);
    //     latestOrderID = latestOrder['orderID'];
    //   }
    // });
  }

  void showOrderDetailsToMechanic(Map<String, dynamic> orderDetails) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('New Order Details:'),
              Text('Order ID: ${orderDetails['orderID']}'),
              Text('Customer Name: ${orderDetails['customerName']}'),
              // Include other order details
              // Add buttons to accept or reject the order
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    orderStream?.cancel();
  }

  void _loadMechanicData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc = await FirebaseFirestore.instance.collection('Mechanic').doc(
          user.uid).get();
      if (doc.exists) {
        setState(() {
          mechanicName = doc.get('Name') ?? 'Mech_Name';
          mechanicEmail = doc.get('Email') ?? 'Mech_Name@gmail.com';
          mechanicPhoto = doc.get('Profile Img Url') ?? '';
        });
      }
    }
  }

  void toggleOnlineOffline(bool value) {
    setState(() {
      isOnline = value;
    });
  }

  void toggleShowIndividual(bool value) {
    setState(() {
      showIndividual = value;
    });
  }

  void navigateToMapScreen() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => MechMapScreen(),
    ));
  }

  void logout() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => MechRegisterPage(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mechanic Home Page'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: logout,
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(mechanicName),
              accountEmail: Text(mechanicEmail),
              currentAccountPicture: CircleAvatar(
                backgroundImage: _buildProfileImage(mechanicPhoto),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                // Implement User Profile functionality here
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                // Implement Settings functionality here
              },
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Notification'),
              onTap: () {
                // Implement Notification Center functionality here
              },
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text('Help & Support'),
              onTap: () {
                // Implement Help and Support functionality here
              },
            ),
            ListTile(
              leading: Icon(Icons.article),
              title: Text('News & Updates'),
              onTap: () {
                // Implement News and Updates functionality here
              },
            ),
            ListTile(
              leading: Icon(Icons.local_offer),
              title: Text('Offers & Promotions'),
              onTap: () {
                // Implement Promotions and Offers functionality here
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About'),
              onTap: () {
                // Implement App Version functionality here
              },
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            margin: EdgeInsets.all(16),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          toggleOnlineOffline(!isOnline);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8, vertical: 8),
                          decoration: BoxDecoration(
                            color: isOnline ? Colors.orange : Colors.green,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 4,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 30.0,
                                height: 30.0,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Container(
                                    width: 15.0,
                                    height: 22.0,
                                    decoration: BoxDecoration(
                                      color: isOnline ? Colors.orange : Colors
                                          .green,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 0),
                              Text(
                                isOnline ? ' Go Online' : ' Go Offline',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: navigateToMapScreen,
                        child: Container(
                          width: 50.0,
                          height: 50.0,
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Icon(
                            Icons.map,
                            color: Colors.white,
                            size: 30.0,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          toggleShowIndividual(!showIndividual);
                        },
                        child: Container(
                          width: 120.0,
                          height: 50.0,
                          padding: EdgeInsets.symmetric(
                              horizontal: 8, vertical: 8),
                          decoration: BoxDecoration(
                            color: showIndividual ? Colors.green : Colors
                                .orange,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 4,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 30.0,
                                height: 30.0,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Container(
                                    width: 15.0,
                                    height: 22.0,
                                    decoration: BoxDecoration(
                                      color: showIndividual
                                          ? Colors.green
                                          : Colors.orange,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 1),
                              Text(
                                showIndividual ? ' Individual' : ' Centers',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                ],
              ),
            ),
          ),
          showIndividual
              ? Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 16),
                Image.asset(
                  'assets/mechanic images/user_home_page_mech_service_logo.jpg',
                  width: 400.0,
                  height: 400.0,
                ),
                SizedBox(height: 16),
                AnimatedSwitcher(
                  duration: Duration(seconds: 1),
                  child: isOnline
                      ? WavyAnimatedTextKit(
                    textStyle: TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                    text: ['You are currently offline'],
                    isRepeatingAnimation: true,
                  )
                      : WavyAnimatedTextKit(
                    textStyle: TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                    text: ['You are currently online'],
                    isRepeatingAnimation: true,
                  ),
                ),
              ],
            ),
          )
              : Expanded(
            child: Center(
              child: Text(
                'Centers',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on),
            label: 'Earnings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              _navigateToPage(context, 'Home');
              break;
            case 1:
              _navigateToPage(context, 'Earnings');
              break;
            case 2:
              _navigateToPage(context, 'Profile');
              break;
          }
        },
      ),
    );
  }

  ImageProvider<Object>? _buildProfileImage(String? profileImgUrl) {
    if (profileImgUrl != null && profileImgUrl.isNotEmpty) {
      return NetworkImage(profileImgUrl);
    } else {
      return AssetImage('assets/common images/profile.png');
    }
  }

  void _navigateToPage(BuildContext context, String pageName) {
    // Implement navigation logic here based on the selected pageName
  }


  // void sendNotificationToMechanics(String mechanicToken, String orderID) {
  //   // Define the notification message
  //   final notification = {
  //     'title': 'New Order',
  //     'body': 'You have a new order: Order ID $orderID',
  //   };
  //
  //   // Define the data payload (optional)
  //   final data = {
  //     'orderID': orderID,
  //   };
  //
  //   // Send the notification
  //   _firebaseMessaging.subscribeToTopic(
  //       'Mechanic'); // Subscribe mechanics to a topic (optional)
  //   _firebaseMessaging.sendToTopic(
  //     'mechanics', // Send to the topic where mechanics are subscribed
  //     <String, dynamic>{
  //       'notification': notification,
  //       'data': data,
  //       'to': mechanicToken, // Specify the mechanic's FCM token
  //     },
  //   );
  // }

}








//
// /*
// The provided Flutter code appears to be the implementation of the user interface for a mechanic's home page. Let's break down what this code does:
//
// Imports: The code imports necessary packages and other Dart files for building a Flutter app, including Firebase Authentication and Firestore integration.
//
// UserData Class: A simple class is defined to hold user data, specifically "Name" and "Email." It is used to represent a mechanic's data.
//
// MechHomePage Class: This is a StatefulWidget class representing the mechanic's home page.
//
// Init State: In the initState method, several important actions are taken:
//
// It loads the mechanic's data from Firestore and assigns it to local variables.
// It sets up a stream to listen for changes in the Firestore "User_Post" collection, which appears to be related to new user orders. If a new order arrives, it invokes sendNotificationToMechanics (which is a function for sending notifications) and displays order details to the mechanic.
// Disposing of the Stream: In the dispose method, the stream subscription is canceled to prevent memory leaks when the widget is no longer in use.
//
// Methods:
//
// _loadMechanicData(): This function loads the mechanic's data (Name, Email, Profile Image) from Firestore.
// toggleOnlineOffline(): Toggles the mechanic's online or offline status.
// toggleShowIndividual(): Toggles between showing individual data or centers.
// navigateToMapScreen(): Navigates to a map screen (possibly for viewing locations or orders).
// logout(): Logs the mechanic out of the application.
// UI Elements: The code builds the user interface using various widgets, including Card, IconButton, Drawer, BottomNavigationBar, and other widgets to show the mechanic's name, email, online status, and additional controls and options.
//
// It shows whether the mechanic is online or offline and allows them to switch between these states.
// It provides a bottom navigation bar for navigation within the app.
// Depending on the mechanic's status, different UI elements are shown. If the mechanic is online, it displays animated text, and if not, it displays a static message. The choice between showing individual data and centers is also handled.
// The code is a part of a Flutter app that seems to be designed for mechanics. It allows mechanics to manage their online status, view orders, and interact with customers. The code represents the user interface and includes placeholders for various features like user profile, settings, notifications, help and support, and more.
//
// Keep in mind that this code is just the UI and does not include the entire application logic. To fully understand how the app works, you would need to look at the code for other parts of the app and any associated Firebase functions (like sendNotificationToMechanics).
// */