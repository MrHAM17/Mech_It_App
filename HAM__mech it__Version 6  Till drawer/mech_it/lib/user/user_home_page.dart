//
// import 'package:flutter/material.dart';
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// import '../common/login_page.dart';
// import 'my_cars_screen.dart'; // Import the MyCarsScreen
//
// class UserHomePage extends StatelessWidget {
//   const UserHomePage({Key? key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Text('User Home'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.logout),
//             onPressed: () {
//               // Implement user logout logic here
//               _logoutUser(context);
//             },
//           ),
//         ],
//       ),
//       drawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: [
//             UserAccountsDrawerHeader(
//               accountName: Text('User Name'), // Replace with the user's name fetched from Firebase
//               accountEmail: Text('user@example.com'), // Replace with the user's email fetched from Firebase
//               currentAccountPicture: CircleAvatar(
//                 // Replace with the user's profile picture fetched from Firebase
//                 backgroundImage: NetworkImage(
//                     'https://example.com/profile_image_url.jpg'),
//               ),
//             ),
//
//             ListTile(
//               leading: Icon(Icons.person),
//               title: Text('User Profile'),
//               onTap: () {
//                 // Implement User Profile functionality here
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.search),
//               title: Text('Search'),
//               onTap: () {
//                 // Implement Search functionality here
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.notifications),
//               title: Text('Notification Center'),
//               onTap: () {
//                 // Implement Notification Center functionality here
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.settings),
//               title: Text('Settings'),
//               onTap: () {
//                 // Implement Settings functionality here
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.history),
//               title: Text('Order History'),
//               onTap: () {
//                 // Implement Order History functionality here
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.help),
//               title: Text('Help and Support'),
//               onTap: () {
//                 // Implement Help and Support functionality here
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.local_offer),
//               title: Text('Promotions and Offers'),
//               onTap: () {
//                 // Implement Promotions and Offers functionality here
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.article),
//               title: Text('News and Updates'),
//               onTap: () {
//                 // Implement News and Updates functionality here
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.info),
//               title: Text('App Version'),
//               onTap: () {
//                 // Implement App Version functionality here
//               },
//             ),
//             // ListTile(
//             //   leading: Icon(Icons.star),
//             //   title: Text('Favorites'),
//             //   onTap: () {
//             //     // Implement Favorites functionality here
//             //   },
//             // ),
//             // ListTile(
//             //   leading: Icon(Icons.star_rate),
//             //   title: Text('User Reviews and Ratings'),
//             //   onTap: () {
//             //     // Implement User Reviews and Ratings functionality here
//             //   },
//             // ),
//             // ListTile(
//             //   leading: Icon(Icons.feedback),
//             //   title: Text('Feedback'),
//             //   onTap: () {
//             //     // Implement Feedback functionality here
//             //   },
//             // ),
//             // ListTile(
//             //   leading: Icon(Icons.security),
//             //   title: Text('Security'),
//             //   onTap: () {
//             //     // Implement Security functionality here
//             //   },
//             // ),
//           ],
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               height: MediaQuery.of(context).size.height * 0.35,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(30),
//                   bottomRight: Radius.circular(30),
//                 ),
//                 gradient: LinearGradient(
//                   colors: [Colors.blue, Colors.green],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   Expanded(
//                     child: _buildServiceCard(
//                       context,
//                       'Mechanic Service',
//                       'assets/mechanic images/user_home_page_mech_service_logo.jpg',
//                     ),
//                   ),
//                   Expanded(
//                     child: _buildServiceCard(
//                       context,
//                       'Winch Service',
//                       'assets/mechanic images/user_home_winch_service_logo.jpg',
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 8),
//             Container(
//               height: 200,
//               child: GestureDetector(
//                 onTap: () {
//                   Navigator.pushNamed(context, '/my_cars');
//                 },
//                 child: _buildMyCarsCard(),
//               ),
//             ),
//             SizedBox(height: 20),
//             ListView(
//               shrinkWrap: true,
//               children: [
//                 // Add widgets that go below the My Cars section here
//                 // For example:
//                 // ListTile(
//                 //   title: Text('Item 1'),
//                 // ),
//                 // ListTile(
//                 //   title: Text('Item 2'),
//                 // ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildServiceCard(BuildContext context, String title, String imagePath) {
//     return Container(
//       padding: EdgeInsets.all(20),
//       margin: EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.5),
//             spreadRadius: 2,
//             blurRadius: 5,
//             offset: Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           FittedBox(
//             child: Image.asset(
//               imagePath,
//               height: 290,
//               width: 260,
//             ),
//           ),
//           SizedBox(height: 20),
//           Text(
//             title,
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildMyCarsCard() {
//     return Container(
//       padding: EdgeInsets.all(20),
//       margin: EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.5),
//             spreadRadius: 2,
//             blurRadius: 5,
//             offset: Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Container(
//             width: 120 / 3,
//             height: 120 / 3,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: Colors.grey,
//             ),
//             child: Center(
//               child: Icon(
//                 Icons.add,
//                 size: 60 / 3,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//           SizedBox(height: 20),
//           Text(
//             'No Added Cars',
//             style: TextStyle(
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//               color: Colors.black,
//             ),
//           ),
//           SizedBox(height: 10),
//           Text(
//             'Please add at least one car to be able to use our services',
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontSize: 16,
//               color: Colors.grey,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _logoutUser(BuildContext context) async {
//     try {
//       await FirebaseAuth.instance.signOut();
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(
//           builder: (context) => LoginPage(context: context),
//         ),
//       );
//     } catch (e) {
//       print('Error during logout: $e');
//     }
//   }
// }
//
//
//
//
//
//
//
//
//
//







//////////////////////





import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../common/login_page.dart';
import 'my_cars_screen.dart'; // Import the MyCarsScreen

class UserData {
  final String name;
  final int age;

  UserData(this.name, this.age);
}

class UserHomePage extends StatefulWidget {
  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  Map<String, dynamic> userData = {};

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null)
    {
      final doc =
      await FirebaseFirestore.instance.collection('User').doc(user.uid).get();
      if (doc.exists)
      {
        setState( ()
        {   userData = doc.data() as Map<String, dynamic>;   });
      }
    }
  }

  Future<Map<String, dynamic>> fetchUserDataFromFirestore() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc =
      await FirebaseFirestore.instance.collection('User').doc(user.uid).get();
      if (doc.exists) {
        return doc.data() as Map<String, dynamic>;
      }
    }
    return {}; // Return an empty map if no data is found
  }

  void _logoutUser(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => LoginPage(context: context),
        ),
      );
    } catch (e) {
      print('Error during logout: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('User Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              _logoutUser(context);
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(userData['Name'] ?? ''),
              accountEmail: Text(userData['Email'] ?? ''),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(userData['Profile Img Url'] ?? ''),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.green],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: _buildServiceCard(
                      context,
                      'Mechanic Service',
                      'assets/mechanic images/user_home_page_mech_service_logo.jpg',
                    ),
                  ),
                  Expanded(
                    child: _buildServiceCard(
                      context,
                      'Winch Service',
                      'assets/mechanic images/user_home_winch_service_logo.jpg',
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            Container(
              height: 200,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/my_cars');
                },
                child: _buildMyCarsCard(),
              ),
            ),
            SizedBox(height: 20),
            ListView(
              shrinkWrap: true,
              children: [
                // Add widgets that go below the My Cars section here
                // For example:
                // ListTile(
                //   title: Text('Item 1'),
                // ),
                // ListTile(
                //   title: Text('Item 2'),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard(BuildContext context, String title, String imagePath) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          FittedBox(
            child: Image.asset(
              imagePath,
              height: 290,
              width: 260,
            ),
          ),
          SizedBox(height: 20),
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMyCarsCard() {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 120 / 3,
            height: 120 / 3,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey,
            ),
            child: Center(
              child: Icon(
                Icons.add,
                size: 60 / 3,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
            'No Added Cars',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Please add at least one car to be able to use our services',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
