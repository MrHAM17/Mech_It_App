

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:geolocator/geolocator.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_svg/svg.dart';

import 'package:mech_it/user/user_home_page.dart';
import 'package:mech_it/mechanic/mech_home_page.dart';

import 'package:mech_it/user/user_register_page.dart';
import 'package:mech_it/mechanic/mech_register_page.dart';

import 'package:mech_it/ham_consts.dart';
import 'package:mech_it/main.dart';

import 'package:mech_it/mechanic/mech_home_page.dart';
import 'package:mech_it/mechanic/mech_map_screen.dart';

import 'package:mech_it/mechanic/mech_register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.context}) : super(key: key);

  final BuildContext context; // Add context as a parameter

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
{
  late Size mediaSize;

  TextEditingController loginuserphoneController = TextEditingController();
  TextEditingController loginuseremailController = TextEditingController();
  TextEditingController loginuserpasswordController = TextEditingController();

  TextEditingController loginmechphoneController = TextEditingController();
  TextEditingController loginmechemailController = TextEditingController();
  TextEditingController loginmechpasswordController = TextEditingController();

  int currentPageIndex = 0; // Track the current page index

  // Define the page controller for PageView
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) => Scaffold(
    body: Stack(
      alignment: Alignment.topLeft, // Set alignment to top-left
      children: [
        PageView(
          controller: _pageController, // Provide the PageController
          onPageChanged: (int index) {
            setState(() {
              currentPageIndex = index; // Update the current page index
            });
          },
          children:
          [

            Container    ///////////////////////////////////////////////////////////// User Onboarding Screen ///////////////////////////
              (         // Your user onboarding screen content here
              child: Builder(
                builder: (BuildContext context){
                  Size size = MediaQuery.of(context).size; // Define 'size' here

                  return Container(
                    height: double.maxFinite,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [g1, g2],
                      ),
                    ),

                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(size.height * 0.070),     // gap from top for image

                        child: OverflowBar(
                          overflowAlignment: OverflowBarAlignment.center,
                          // overflowDirection: size.height * 0.014,
                          overflowDirection: VerticalDirection.down, // Specify the overflow direction


                          children: [
                            Image.asset(image1),
                            // Text(
                            //   "Wellcome Back!",
                            //   textAlign: TextAlign.center,
                            //   style: TextStyle(
                            //     fontWeight: FontWeight.w600,
                            //     fontSize: 20,
                            //     color: kWhiteColor.withOpacity(0.7),
                            //   ),
                            // ),



                            const Text(
                              "Hey User",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 34,
                                color: kWhiteColor,
                              ),
                            ),

                            SizedBox(height: size.height * 0.060), // gap from top for email

                            _buildFormUser(), // Add the _buildForm method here



                            CupertinoButton(
                              padding: EdgeInsets.zero,
                              child: Container(
                                alignment: Alignment.center,
                                width: double.infinity,
                                height: size.height * 0.080,
                                decoration: BoxDecoration(
                                  color: kButtonColor,
                                  borderRadius: BorderRadius.circular(37),
                                ),
                                child: const Text(
                                  "Login",
                                  style: TextStyle(
                                    color: kWhiteColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),

                              // Inside the onPressed callback for the login button in the User section
                              // Inside the onPressed callback for the login button in the User section
                              onPressed: () async
                              {
                                    final loginuseremail = loginuseremailController.text.trim();
                                    final loginuserpass = loginuserpasswordController.text.trim();

                                    try
                                    {

                                          FirebaseFirestore firestore = FirebaseFirestore.instance;
                                          QuerySnapshot userDocs = await firestore
                                              .collection('User')
                                              .where('Email', isEqualTo: loginuseremail)
                                              .where('Password', isEqualTo: loginuserpass)
                                              .limit(1) // Assuming email and password combinations are unique
                                              .get();

                                          if (userDocs.docs.isNotEmpty)
                                          {
                                            // Showing loading indicator
                                            showDialog( context: context,   builder: (context){
                                              return Center(child: CircularProgressIndicator( color: Colors.deepPurpleAccent, backgroundColor: Colors.grey, value: 0.75) ); },  );

                                            // Allow access to the User section after a delay (you can use a Future.delayed here)
                                            await Future.delayed(Duration(milliseconds: 200)); // Replace with actual processing time

                                            // Closing loading indicator
                                            Navigator.of(context).pop();

                                            // Allow access to the User section
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => UserHomePage()));

                                          }
                                          else
                                          {
                                                // Closing loading indicator
                                                Navigator.of(context).pop();

                                                ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                                                  content: Row(   mainAxisAlignment: MainAxisAlignment.center, // Center the content horizontally
                                                   children: [  Text('You are not registered as a "User".'),  ],   ),    ),  );

                                                ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                                                  content: Row(   mainAxisAlignment: MainAxisAlignment.center, // Center the content horizontally
                                                   children: [  Text("Otherwise, Invalid User's Details."),  ],   ),     ),   );


                                                // UserCredential loginuserCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: loginuseremail, password: loginuserpass);
                                                // if(loginuserCredential.user != null)
                                                // {
                                                //   ScaffoldMessenger.of(context).showSnackBar(   SnackBar(  content: Text('You are not registered as a "User".'),  ),   );
                                                //   ScaffoldMessenger.of(context).showSnackBar(   SnackBar(  content: Text("If not, then Invalid User's Details."),  ),   );
                                                // }
                                          }

                                }
                                    on FirebaseAuthException catch (e)
                                    {
                                      if (e.code == 'user-not-found')
                                      { print('No user found for that email.');   }
                                      else if (e.code == 'wrong-password')
                                      { print('Wrong password provided for that user.');   }
                                      else
                                      {  print('Error: $e');
                                      }
                                      // Handle other authentication errors here
                                    }
                              },



                            ),

                            SizedBox(height: size.height * 0.014),
                            SvgPicture.asset("assets/icons/deisgn.svg"),
                            SizedBox(height: size.height * 0.014),
                            CupertinoButton(
                              padding: EdgeInsets.zero,
                              child: Container(
                                alignment: Alignment.center,
                                width: double.infinity,
                                height: size.height * 0.080,
                                decoration:  BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                      blurRadius: 45,
                                      spreadRadius: 0,
                                      color: Color.fromRGBO(120, 37, 139, 0.25),
                                      offset: Offset(0, 25),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(37),
                                  color: const Color.fromRGBO(225, 225, 225, 0.28),
                                ),

                                child: const Text(
                                  "New one? Register Here",
                                  style: TextStyle(
                                    color: kWhiteColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),

                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => UserRegisterPage(), // Replace with your RegistrationScreen widget
                                  ),
                                );
                              },
                            ),

                          ],
                        ),
                      ),
                    ),

                  );
                },
              ),

            ),



            Container    ///////////////////////////////////////////////////////////// Mechanic Onboarding Screen ///////////////////////
              (         // Your mechanic onboarding screen content here
              child: Builder(
                builder: (BuildContext context){
                  Size size = MediaQuery.of(context).size; // Define 'size' here

                  return Container(
                    height: double.maxFinite,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [g1, g2],
                      ),
                    ),

                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(size.height * 0.054),   // gap from top for image

                        child: OverflowBar(
                          overflowAlignment: OverflowBarAlignment.center,
                          // overflowDirection: size.height * 0.014,
                          overflowDirection: VerticalDirection.down, // Specify the overflow direction


                          children: [
                            Image.asset(image2),
                            // Text(
                            //   "Welcome Back!",
                            //   textAlign: TextAlign.center,
                            //   style: TextStyle(
                            //     fontWeight: FontWeight.w600,
                            //     fontSize: 20,
                            //     color: kWhiteColor.withOpacity(0.7),
                            //   ),
                            // ),

                            const Text(
                              "Hey Mechanic",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 34,
                                color: kWhiteColor,
                              ),
                            ),

                            SizedBox(height: size.height * 0.048),  // gap from top for email

                            _buildFormMech(), // Integrate _buildForm here


                            CupertinoButton(
                              padding: EdgeInsets.zero,
                              child: Container(
                                alignment: Alignment.center,
                                width: double.infinity,
                                height: size.height * 0.080,
                                decoration: BoxDecoration(
                                  color: kButtonColor,
                                  borderRadius: BorderRadius.circular(37),
                                ),
                                child: const Text(
                                  "Login",
                                  style: TextStyle(
                                    color: kWhiteColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),

                              onPressed: () async
                              {
                                    final loginmechemail = loginmechemailController.text.trim();
                                    final loginmechpass = loginmechpasswordController.text.trim();

                                    ///
                                    try
                                    {
                                          FirebaseFirestore firestore = FirebaseFirestore.instance;
                                          QuerySnapshot userDocs = await firestore
                                              .collection('Mechanic')
                                              .where('Email', isEqualTo: loginmechemail)
                                              .where('Password', isEqualTo: loginmechpass)
                                              .limit(1) // Assuming email and password combinations are unique
                                              .get();

                                          if (userDocs.docs.isNotEmpty)
                                          {
                                                // Showing loading indicator
                                                showDialog( context: context,   builder: (context){
                                                  return Center(child: CircularProgressIndicator( color: Colors.deepPurpleAccent, backgroundColor: Colors.grey, value: 0.75) ); },  );

                                                // Allow access to the User section after a delay (you can use a Future.delayed here)
                                                await Future.delayed(Duration(milliseconds: 200)); // Replace with actual processing time

                                                // Closing loading indicator
                                                Navigator.of(context).pop();

                                                // Allow access to the User section
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => MechHomePage()));

                                          }
                                          else
                                          {
                                                // Closing loading indicator
                                                Navigator.of(context).pop();

                                                ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                                                  content: Row(   mainAxisAlignment: MainAxisAlignment.center, // Center the content horizontally
                                                    children: [  Text('You are not registered as a "Mechanic".'),  ],   ),    ),  );

                                                ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                                                  content: Row(   mainAxisAlignment: MainAxisAlignment.center, // Center the content horizontally
                                                    children: [  Text("Otherwise, Invalid Mechanic's Details."),  ],   ),     ),   );

                                                // UserCredential loginmechCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: loginmechemail, password: loginmechpass);
                                                // if(loginmechCredential.user != null)
                                                // {
                                                //   ScaffoldMessenger.of(context).showSnackBar(   SnackBar(  content: Text('You are not registered as a "Mechanic".'),  ),   );
                                                //   ScaffoldMessenger.of(context).showSnackBar(   SnackBar(  content: Text("If not, then Invalid User's Details."),  ),   );
                                                // }
                                          }
                                    }
                                    on FirebaseAuthException catch (e)
                                    {
                                          if (e.code == 'user-not-found')
                                          {   print('No user found for that email.');    }
                                          else if (e.code == 'wrong-password')
                                          {  print('Wrong password provided for that user.');   }

                                          // print('Error: $e');
                                          // print('Email: ${loginmechemailController.text}');
                                          // print('Password: ${loginmechpasswordController.text}');
                                    }
                                    ///
                              },

                            ),

                            SizedBox(height: size.height * 0.014),
                            SvgPicture.asset("assets/icons/deisgn.svg"),
                            SizedBox(height: size.height * 0.014),
                            CupertinoButton(
                              padding: EdgeInsets.zero,
                              child: Container(
                                alignment: Alignment.center,
                                width: double.infinity,
                                height: size.height * 0.080,
                                decoration:  BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                      blurRadius: 45,
                                      spreadRadius: 0,
                                      color: Color.fromRGBO(120, 37, 139, 0.25),
                                      offset: Offset(0, 25),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(37),
                                  color: const Color.fromRGBO(225, 225, 225, 0.28),
                                ),

                                child: const Text(
                                  "New one? Register Here",
                                  style: TextStyle(
                                    color: kWhiteColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),

                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => MechRegisterPage(), // Replace with your RegistrationScreen widget
                                  ),
                                );
                              },
                            ),

                          ],
                        ),
                      ),
                    ),

                  );
                },
              ),
            ),
          ],
        ),

        Positioned(
          left: 0,
          right: 0,
          top: 0,
          child: Container(
            padding: EdgeInsets.only(left: 100, top: 30, right: 0.0, bottom: 6),
            color: Colors.deepPurpleAccent,
            child: Text(
              "Choose Your Role",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),

        Positioned(
          left: 165,
          right: 150,
          bottom: 10, // Adjust the position of the page indicator
          child: SmoothPageIndicator(
            controller: _pageController, // Provide the PageController
            count: 2, // Number of pages
            effect: WormEffect(  // Choose the effect you prefer
              activeDotColor: Colors.deepPurpleAccent,
              dotColor: Colors.grey,
              dotWidth: 10.0, // Set the dot width
              dotHeight: 10.0, // Set the dot height

            ),
          ),
        ),
      ],
    ),
  );



  Widget _buildFormUser() {
    Size size = MediaQuery.of(context).size; // Define 'size' here
    return Column(
      children: [

        TextField(
          controller: loginuseremailController, // Use the appropriate controller
          keyboardType: TextInputType.text,
          style: const TextStyle(color: kInputColor),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: 0.0, right: 0.0, top: 0.200, bottom: 40.0),
            filled: true,
            hintText: "Phone or Email",
            prefixIcon: IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(userIcon),
            ),
            fillColor: kWhiteColor,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(37),
            ),
          ),
        ),
        SizedBox(height: size.height * 0.015),

        TextField(
          obscureText: true,
          controller: loginuserpasswordController,
          keyboardType: TextInputType.text,
          style: const TextStyle(color: kInputColor),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: 0.0, right: 0.0, top: 0.200, bottom: 40.0),
            filled: true,
            hintText: "Password",
            prefixIcon: IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(keyIcon),
            ),
            fillColor: kWhiteColor,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(37),
            ),
          ),
        ),
        SizedBox(height: size.height * 0.015),

      ],
    );
  }


  Widget _buildFormMech() {
    Size size = MediaQuery.of(context).size; // Define 'size' here
    return Column(
      children: [
        TextField(
          controller: loginmechemailController, // Use the appropriate controller
          keyboardType: TextInputType.text,
          style: const TextStyle(color: kInputColor),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: 0.0, right:0.0, top: 0.200, bottom: 40.0),
            filled: true,
            hintText: "Phone or Email",
            prefixIcon: IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(userIcon),
            ),
            fillColor: kWhiteColor,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(37),
            ),
          ),
        ),
        SizedBox(height: size.height * 0.015), // gap from top for password

        TextField(
          obscureText: true,
          controller: loginmechpasswordController, // Use the appropriate controller
          keyboardType: TextInputType.text,
          style: const TextStyle(color: kInputColor),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: 0.0, right:0.0, top: 0.200, bottom: 40.0),
            filled: true,
            hintText: "Password",
            prefixIcon: IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(keyIcon),
            ),
            fillColor: kWhiteColor,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(37),
            ),
          ),
        ),
        SizedBox(height: size.height * 0.015), // gap from top for login

      ],
    );
  }

}


