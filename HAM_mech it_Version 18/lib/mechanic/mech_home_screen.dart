

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:mech_it/mechanic/mech_map_screen.dart';
import 'package:mech_it/mechanic/mech_register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mech_it/user/map_page.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mech_it/mechanic/mech_earning_screen.dart';


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

    //  **** FROM GPT 4 NOV 2023 ********************
    orderStream = FirebaseFirestore.instance
        .collectionGroup('OrderID') // This will query all 'OrderID' subcollections across all users
        .snapshots()
        .listen((event) async
        {
            for (var orderDocument in event.docs)
            {
              var orderDetails = orderDocument.data();
              var userDocumentReference = orderDocument.reference.parent.parent;
              var userId = userDocumentReference!.id;

              // Now, you have access to each order's details and the user's document ID
              var orderId = orderDocument.id;
              print('New order for user $userId with OrderID: $orderId');
              showOrderDetailsToMechanic(orderDetails);
            }
        });


  }

   //      ********* ************** ************  3d BASIC VIEW    ********* ************** ************
  void showOrderDetailsToMechanic(Map<String, dynamic>? orderDetails) {
    if (orderDetails == null) {
      // Handle the case where orderDetails is null
      return;
    }
    // Define fixed height and width for the dialog
    double dialogHeight = 500; // Adjust this value as needed
    double dialogWidth = 350;   // Adjust this value as needed

    showDialog(
      context: context,
      barrierDismissible: false, // This prevents the dialog from closing on outside click
      builder: (context) {
        return Container(
          height: dialogHeight,
          width: dialogWidth,
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            backgroundColor: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'New Order Details',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Colors.grey,
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'User ID:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          orderDetails['UserId'] ?? 'N/A',
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Order ID:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          orderDetails['OrderID'] ?? 'N/A',
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Location:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          orderDetails['Location'] ?? 'N/A',
                        ),
                        SizedBox(height: 16),
                        if (orderDetails['selectedProblems'] != null &&
                            (orderDetails['selectedProblems'] as List).isNotEmpty)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Selected Problems:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: (orderDetails['selectedProblems'] as List<dynamic>)
                                    .map<Widget>((problem) => Text(problem.toString()))
                                    .toList(),
                              ),
                            ],
                          ),
                        SizedBox(height: 16),
                        if (orderDetails['selectedThings'] != null &&
                            (orderDetails['selectedThings'] as List).isNotEmpty)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Selected Things:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: (orderDetails['selectedThings'] as List<dynamic>)
                                    .map<Widget>((thing) => Text(thing.toString()))
                                    .toList(),
                              ),
                            ],
                          ),
                        SizedBox(height: 16),
                        Text(
                          'Timestamp:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          orderDetails['timestamp']?.toDate().toString() ?? 'N/A',
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              child: Text('Accept'),
                              onPressed: () {
                                // Implement the logic to accept the order
                                // Navigator.of(context).pop();
                                FirebaseFirestore.instance.collection('User_Post').doc(orderDetails['User ID']).collection('OrderID').doc(orderDetails['Order ID']).update(
                                    {'Status' : 'Accepted'});
                                Navigator.pop(context);

                        // ****************************        // showMechanicDetails({required,this.mechanicName, required,this.mechanicPhoto,required, this.mechanicEmail} as String);
                        //         showMechanicDetails(mechanicName, mechanicPhoto, mechanicEmail);



                                // Define a function that you want to call from MechHomePage
                                void processOrder() {
                                  // Implement the logic to process the order here
                                  // You can access mechanicInfo and orderDetails here
                                  print('Processing order: $orderDetails');
                                }

                              },
                            ),
                            SizedBox(width: 8),
                            ElevatedButton(
                              child: Text('Reject'),
                              onPressed: () {
                                // Implement the logic to reject the order
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: Text('Ignore'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
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
        title: Text('Welcome Mech_Name'),
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
                                isOnline ? ' Go Offline' : ' Go Online',
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
                            color: showIndividual ? Colors.green : Colors.orange,
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
                    text: ['You are currently online'],
                    isRepeatingAnimation: true,
                  )
                      : WavyAnimatedTextKit(
                    textStyle: TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                    text: ['You are currently offline'],
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
            icon: Icon(Icons.groups_2_rounded),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on),
            label: 'Earnings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.handshake_rounded),
            label: 'My Work',
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              _navigateToPage(context, 'Orders');
              break;
            case 1:
              _navigateToPage(context, 'Earnings');
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MechEarningScreen(), // Replace with your Earnings page widget
              ));
              break;
            case 2:
              _navigateToPage(context, 'My Work');
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
}
