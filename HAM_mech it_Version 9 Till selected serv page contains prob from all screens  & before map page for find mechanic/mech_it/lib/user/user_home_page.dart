import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mech_it/user/break_downs_services_page.dart';
import 'package:mech_it/user/mechanic_services_page.dart';
import 'package:mech_it/user/routine_maintenance_services_page.dart';
import 'package:mech_it/user/winch_services_page.dart';
import '../common/login_page.dart';
import 'package:mech_it/user/car_details.dart';

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
    if (user != null) {
      final doc =
      await FirebaseFirestore.instance.collection('User').doc(user.uid).get();
      if (doc.exists) {
        setState(() {
          userData = doc.data() as Map<String, dynamic>;
        });
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

  void _showCarDetailsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return CarDetailsBottomSheet();
      },
    );
  }

  void clearLists() {
    // Add code here to clear your lists (selectedThings and selectedProblems)
    // For example, if you have a list named selectedThings, you can clear it like this:
    selectedProblems.clear();
    selectedThings.clear();
    // If you have other lists to clear, do the same for them.
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
                backgroundImage:
                NetworkImage(userData['Profile Img Url'] ?? ''),
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
            SizedBox(height: 8),
            GestureDetector(
              onTap: () {
                _showCarDetailsBottomSheet(context);
              },
              child: Container(
                height: 200,
                child: _buildMyCarsCard(context),
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
    return GestureDetector(
      onTap: () {
        if (title == 'Mechanic Service') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MechanicServicesPage(
                clearListsCallback: clearLists, // Pass the clearLists method as a callback
              ),
            ),
          );
        } else if (title == 'Winch Service') {
          // Navigate to the Winch Services page here
          // Replace 'WinchServicesPage()' with your actual Winch Services page widget
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => WinchServicesPage(),
          //   ),
          // );
        }
      },
      child: Container(
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
      ),
    );
  }


  Widget _buildMyCarsCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showCarDetailsBottomSheet(context);
      },
      child: Container(
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
            SizedBox(height: 5),
            Icon(
              Icons.add_circle,
              size: 45,
              color: Colors.blue,
            ),
            SizedBox(height: 10),
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
              'Add at least one vehicle & use our services',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CarDetailsBottomSheet extends StatefulWidget {
  @override
  _CarDetailsBottomSheetState createState() => _CarDetailsBottomSheetState();
}

class _CarDetailsBottomSheetState extends State<CarDetailsBottomSheet> {
  PageController _pageController = PageController(initialPage: 0);
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              Text(
                'Add Car Details',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 40),
            ],
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPageIndex = index;
                });
              },
              children: [
                UserCarDetailPage(
                  title: 'Car Brand',
                  onNext: () {
                    _pageController.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );
                  },
                ),
                UserCarDetailPage(
                  title: 'Car Model',
                  onNext: () {
                    _pageController.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );
                  },
                ),
                UserCarDetailPage(
                  title: 'Year of Production',
                  onNext: () {
                    _pageController.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );
                  },
                ),
                UserCarDetailPage(
                  title: 'Additional Information',
                  onNext: () {
                    // Save car details and close the bottom sheet
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          DotsIndicator(
            controller: _pageController,
            itemCount: 4,
            currentIndex: _currentPageIndex,
          ),
        ],
      ),
    );
  }
}

class UserCarDetailPage extends StatelessWidget {
  final String title;
  final Function onNext;

  UserCarDetailPage({required this.title, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        // Input fields for car details
        TextFormField(
          // ... rest of the code remains the same
        ),
      ],
    );
  }
}

class DotsIndicator extends StatelessWidget {
  final PageController controller;
  final int itemCount;
  final int currentIndex;

  DotsIndicator({
    required this.controller,
    required this.itemCount,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        itemCount,
            (index) {
          return Container(
            width: 10.0,
            height: 10.0,
            margin: EdgeInsets.symmetric(horizontal: 6.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: currentIndex == index ? Colors.blue : Colors.grey,
            ),
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: UserHomePage(),
  ));
}
