

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

    //  **** FROM GPT Eariler ********************   //           // ----------------------------------->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>   Useless
    //
    // orderStream = FirebaseFirestore.instance
    //     .collection('User_Post')
    //     .snapshots()
    //     .listen((event) async {
    //         for (var userDocument in event.docs) {
    //           // Access the user's document ID
    //           var userId = userDocument.id;
    //
    //           // Access the 'OrderID' subcollection for the user
    //           var orderIDCollection = userDocument.reference.collection('OrderID');
    //
    //           var orderIDDocuments = await orderIDCollection.get();
    //
    //           for (var orderDocument in orderIDDocuments.docs) {
    //             var latestOrder = orderDocument.data();
    //             // Now, you have access to each order's details
    //             var orderId = orderDocument.id;
    //
    //             // Process or display each order as needed
    //             print('New order for user $userId with OrderID: $orderId');
    //             showOrderDetailsToMechanic(latestOrder);
    //           }
    //         }
    // });

    //  **** FROM GPT 4 NOV 2023 ********************      //           // ----------------------------------->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>   Useless
    // orderStream = FirebaseFirestore.instance
    //     .collection('User_Post') // Reference to the 'User_Post' collection
    //     .snapshots()
    //     .listen((event) async
    //     {
    //       for (var userDocument in event.docs)
    //       {
    //           var userId = userDocument.id;
    //
    //           var orderIDCollection = userDocument.reference.collection('OrderID');
    //           var orderIDDocuments = await orderIDCollection.get();
    //
    //           for (var orderDocument in orderIDDocuments.docs)
    //           {
    //             var orderDetails = orderDocument.data();
    //             var orderId = orderDocument.id;
    //
    //             // Now you have access to each order's details, user's document ID, and 'User_Post' reference
    //             print('New order for user $userId with OrderID: $orderId');
    //             showOrderDetailsToMechanic(orderDetails);
    //           }
    //       }
    //     });


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

    /*  whats the difference between both

        The two code snippets serve similar purposes but use slightly different approaches to achieve the same goal. The difference lies in how they structure the Firestore data and the way you query for new orders. Here's a breakdown of the differences: Collection Structure:
        The first code snippet uses the collectionGroup method to query all 'OrderID' subcollections across all users. This means that the 'User_Post' folder doesn't need to be traversed explicitly in your code. It scans all 'OrderID' subcollections under any user's documents within the Firestore database.
        The second code snippet explicitly queries the 'User_Post' collection and then navigates to the 'OrderID' subcollection within each user's document. It directly specifies the path to the user's documents and then looks for the 'OrderID' subcollection.
        Query Approach:
        The first code snippet uses the collectionGroup approach, which is more generic and flexible. It will detect and return all 'OrderID' subcollections under different user documents, so you don't need to know the specific user document IDs.
        The second code snippet is more explicit in its approach. It assumes that you're interested in the 'User_Post' collection, and then it navigates to 'OrderID' subcollections within specific user documents. You need to know the structure and hierarchy of your data.
        In summary, the first code snippet is more flexible and generic, as it doesn't rely on the 'User_Post' collection's path and will automatically detect and return 'OrderID' subcollections under any user document. The second code snippet is more explicit and suitable if you want to target a specific collection and know the structure of your data.
        You should choose the approach that best fits your application's requirements and Firestore data structure.

        ********************

        actually i have User_Post in that OrderID in that order details of all orders of that user

        If you have a Firestore structure where you have a collection called 'User_Post' that contains documents for each user, and within each user document, there is a subcollection called 'OrderID' where the order details are stored, you can use either of the code snippets I provided in my previous responses.
        The choice between the two approaches depends on whether you want to listen for new orders across all users' documents or just within a specific user's documents. Here's a recap of the use cases for each approach:
        Use the first code snippet (collectionGroup approach) if you want to listen to new orders across all users. This approach scans all 'OrderID' subcollections within all user documents without needing to specify the specific user's document ID. It's more suitable if you want to receive notifications for new orders from any user.
        Use the second code snippet (explicit user document approach) if you want to focus on a specific user's documents and their orders. This approach is more explicit and suitable if you want to work with orders from a particular user. It requires knowing the user's document ID.
        Choose the approach that aligns with your specific use case and requirements. If you want to listen for new orders across all users, use the first code snippet. If you want to work with orders from a specific user, use the second code snippet with the user's document ID.

        ********** **********  ************

        So it finally worked @ 9:34 pm 4 Nov 2023
        Though it gives all orders before loggin as well --> but ye bhi 13 bhai sambhal lega for now atleast ye order to receive ho gaya mechanic when user(driver) upload his issue in the app !!!!!!!!!!!
    */


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
              Text('***New Order Details:***'),
              Text(' '),
              Text(' '),
              Text('User ID  : ${orderDetails['UserId']}'),
              Text('Order ID : ${orderDetails['OrderID']}'),
              Text(' '),

              // Display the selected problems
              Text('*Selected Problems:*'),
              for (var problem in orderDetails['selectedProblems'] as List<dynamic>)
                Text(problem.toString()),
                Text(' '),

              // Display the selected things
              Text('*Selected Things:*'),
              for (var thing in orderDetails['selectedThings'] as List<dynamic>)
                Text(thing.toString()),
                Text(' '),

              // Display the timestamp
              Text('*Timestamp:*'),
              Text(' ${orderDetails['timestamp'].toDate().toString()}'),
              // You can include additional order details here
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

  //           // ----------------------------------->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>   Useless
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
