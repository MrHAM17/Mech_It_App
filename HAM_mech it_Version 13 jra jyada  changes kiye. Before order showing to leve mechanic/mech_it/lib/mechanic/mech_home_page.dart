import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:mech_it/common/login_page.dart';
import 'package:mech_it/mechanic/mech_map_screen.dart';
import 'package:mech_it/mechanic/mech_register_page.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


void main() {
  runApp(MaterialApp(
    home: MechHomePage(),
  ));
}

class UserData {
  final String Name;
  final int Email;

  UserData(this.Name, this.Email);
}

class MechHomePage extends StatefulWidget {
  @override
  _MechHomePageState createState() => _MechHomePageState();
}

class _MechHomePageState extends State<MechHomePage> {
  Map<String, dynamic> userData = {};

  bool isOnline = true; // Change to true for online, false for offline
  bool showIndividual = true; // Change to true for individual, false for centers

  String mechanicName = '';
  String mechanicEmail = '';
  String mechanicPhoto = '';

  @override
  void initState() {
    super.initState();
    // Load mechanic data when the page is initialized
    _loadMechanicData();
  }

  Future<void> _loadMechanicData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc = await FirebaseFirestore.instance.collection('Mechanic').doc(user.uid).get();
      if (doc.exists) {
        setState(() {
          mechanicName = doc.get('Name') ?? '';
          mechanicEmail = doc.get('Email') ?? '';
          mechanicPhoto = doc.get('Profile Img Url') ?? '';
        });
      }
    }
  }

  void _navigateToPage(BuildContext context, String pageName) {
    // Add your navigation logic here based on the selected pageName
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
    // Implement navigation to the Mech Map Screen here
    // Example:
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => MechMapScreen(),
    ));
  }

  void logout() {
    // Implement the logout functionality here, which should navigate to the login page.
    // Example:
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => MechRegisterPage(), // Replace LoginPage with your actual login page.
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
              accountName: Text(userData['Name'] ?? 'Mech_Name'), // Name displayed dynamically
              accountEmail: Text(userData['Email'] ?? 'Mech_Name@gmail.com'), // Email displayed dynamically
              currentAccountPicture: CircleAvatar(
                backgroundImage: _buildProfileImage(userData['Profile Img Url']),
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
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
                                      color: isOnline ? Colors.orange : Colors.green,
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
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
                                      color: showIndividual ? Colors.green : Colors.orange,
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
                SizedBox(height: 16), // Add some space
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
                    textStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    text: ['You are currently offline'],
                    isRepeatingAnimation: true,
                  )
                      : WavyAnimatedTextKit(
                    textStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
}


ImageProvider<Object>? _buildProfileImage(String? profileImgUrl) {
  if (profileImgUrl != null && profileImgUrl.isNotEmpty) {
    return NetworkImage(profileImgUrl);
  } else {
    return AssetImage('assets/common images/profile.png');
  }
}