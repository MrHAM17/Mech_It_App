import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../common/login_page.dart';
import 'my_cars_screen.dart'; // Import the MyCarsScreen

class UserHomePage extends StatelessWidget {
  const UserHomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // This line removes the back arrow  // telling Flutter not to automatically show the back arrow button in the app bar, effectively removing it.
        title: Text('User Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Implement user logout logic here
              _logoutUser(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.35,
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
            SizedBox(height: 8), // Added spacing between the sections
            Container(
              height: 200, // Increased the height of the My Cars box
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/my_cars');
                },
                child: _buildMyCarsCard(),
              ),
            ),
            SizedBox(height: 20), // Added spacing between the sections
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
          FittedBox( // Use FittedBox to scale the image
            child: Image.asset(
              imagePath,
              height: 290,
              width: 260, // Adjust the width to your desired size
            ),
            // fit: BoxFit.contain, // Use BoxFit.contain to scale the image proportionally
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
            'Please add your at least one car to be able to use our services',
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
}
