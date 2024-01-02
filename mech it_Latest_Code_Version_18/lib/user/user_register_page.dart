

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:image_picker/image_picker.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';

import 'package:mech_it/user/user_home_page.dart';
import 'package:mech_it/user/user_register_page.dart';

class UserRegisterPage extends StatefulWidget {
  const UserRegisterPage({Key? key}) : super(key: key);

  @override
  State<UserRegisterPage> createState() => _UserRegisterPageState();
}

class _UserRegisterPageState extends State<UserRegisterPage> {
  late Color myColor;
  late Size mediaSize;

  TextEditingController registerusernameController = TextEditingController();
  TextEditingController registerusercountryCodeController = TextEditingController();
  TextEditingController registeruserphoneController = TextEditingController();
  final countryPicker = const FlCountryCodePicker();
  final TextEditingController phoneNumberController = TextEditingController();
  CountryCode? countryCode;

  TextEditingController registeruseremailController = TextEditingController();
  TextEditingController registeruserpasswordController = TextEditingController();

  String imageUrl = ''; // Declare imageUrl variable at the class level

  File? _profileImage; // Added for profile image
  final _picker = ImagePicker(); // Added for image picker

  @override
  Widget build(BuildContext context) {
    myColor = Theme.of(context).primaryColor;
    mediaSize = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: myColor,
        image: DecorationImage(
          image: const AssetImage("assets/common images/bg.png"),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            myColor.withOpacity(0.2),
            BlendMode.dstATop,
          ),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Positioned(top: 80, child: _buildTop()),
            Positioned(bottom: 0, child: _buildBottom()),
          ],
        ),
      ),
    );
  }

  Widget _buildTop() {
    return SizedBox(
      width: mediaSize.width,
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.location_on_sharp,
            size: 100,
            color: Colors.white,
          ),
          Text(
            "Mech !t",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 40,
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottom() {
    return SizedBox(
      width: mediaSize.width,
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: _buildForm(),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildGreyText("Dear User, fill details to register yourself"),

        const SizedBox(height: 10),
        _buildProfileImage(), // Add this for profile image selection

        const SizedBox(height: 10), // Reduced spacing
        _buildPhoneNumberInput(),

        const SizedBox(height: 10), // Reduced spacing
        _buildInputField(
          registerusernameController,
          hintText: "Name",
          prefixIcon: Icon(Icons.person),
        ),

        const SizedBox(height: 10), // Reduced spacing
        _buildInputField(
          registeruseremailController,
          hintText: "Email address",
          prefixIcon: Icon(Icons.email),
        ),

        const SizedBox(height: 10), // Reduced spacing
        _buildInputField(
          registeruserpasswordController,
          hintText: "Password",
          prefixIcon: Icon(Icons.lock),
          isPassword: true,
        ),
        const SizedBox(height: 20), // Kept spacing for the Register button
        _buildRegisterButton(),
        const SizedBox(height: 20), // Kept spacing for the Register button
      ],
    );
  }

  Widget _buildGreyText(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.grey),
    );
  }

  Widget _buildInputField(
      TextEditingController controller, {
        bool isPassword = false,
        String? hintText,
        Icon? prefixIcon,
      }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey, // You can change the border color here
          width: 1.0, // You can change the border width here
        ),
        borderRadius: BorderRadius.circular(
            5.0), // You can change the border radius here
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: prefixIcon,
          contentPadding:
          EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          border: InputBorder.none, // Remove the default TextField border
        ),
        obscureText: isPassword,
      ),
    );
  }

  Widget _buildPhoneNumberInput() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormField(
            controller: phoneNumberController,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.done,
            maxLines: 1,
            decoration: InputDecoration(
              hintText: "Phone Number",
              border: InputBorder.none,
              prefixIcon: Container(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),  // space(for flag & phone number's frame from country code) to the both side of country code's box (in left: space creates/counts from before/left side of flag, if flag choosed; else from box's left side)
                margin: const EdgeInsets.symmetric(horizontal: 8 ), // space(flag & hint of phone number's frame from country code) to the both side of country code's box (in left: space creates/counts from before/left side of flag, if flag choosed; else from box's left side)
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final code = await countryPicker.showPicker(
                            context: context);
                        setState(() {
                          countryCode = code;
                        });
                      },
                      child: Row(
                        children: [
                          Container(
                            child: countryCode != null
                                ? countryCode!.flagImage()
                                : null,
                            //  If below 2 (Atleast still width) are not commented then by default country code box will not available from extreme left, some space ariives their & get cancel after choosing flag by code
                            //         width: 30, // Adjust the width of flag as needed
                            height: 30, // Adjust the height of flag as needed
                          ),
                          const SizedBox(width: 5),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              countryCode?.dialCode ?? "+",
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(width: 0), // space to the left side of phone number

                          /* The Below line was creating a repeated typed phone number values. So therefore commented it to solbe the issuue.
                             Text( phoneNumberController.text.trim(),  style: const TextStyle(fontSize: 14),  // space below the hint of phone number frame ), // Display the phone number text here
                          */

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileImage() {
    return Column(
      children: [
        GestureDetector(
          onTap: _pickImage,
          child: CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey,
            backgroundImage: _profileImage != null
                ? FileImage(_profileImage!)
                : null,
            child: _profileImage == null
                ? Icon(
              Icons.camera_alt,
              size: 40,
              color: Colors.white,
            )
                : null,
          ),
        ),
      ],
    );
  }

  Future<void> _pickImage() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _profileImage = File(pickedImage.path);
      });
    }
  }

  // Future<void> _uploadProfileImage() async {
  //
  //   // Upload the profile image to Firebase Storage here
  //   if (_profileImage != null) {
  //     final storage = FirebaseStorage.instance;
  //     final reference =
  //     storage.ref().child('user_profile_image/${DateTime.now()}.png');
  //
  //     final uploadTask = reference.putFile(_profileImage!);
  //     final snapshot = await uploadTask.whenComplete(() {});
  //     imageUrl = await snapshot.ref.getDownloadURL(); // Assign the imageUrl
  //
  //     // Now you can save the imageUrl along with other user data in Firestore or Firebase Realtime Database.
  //     // Example:
  //     // firestore.collection('users').doc(user.uid).set({
  //     //   'name': registerusernameController.text,
  //     //   'email': registeruseremailController.text,
  //     //   'profileImageUrl': imageUrl,
  //     //   // ... other fields ...
  //     // });
  //   }
  //
  //   // Use imageUrl as needed (e.g., you can pass it to Firestore)
  // }


  Widget _buildRegisterButton() {
    return ElevatedButton(
      onPressed: () async {

        final registerusername = registerusernameController.text.trim();
        final registeruseremail = registeruseremailController.text.trim();
        final registeruserpass = registeruserpasswordController.text.trim();
        final phoneNumber = phoneNumberController.text.trim();

        if (   phoneNumber.isEmpty ||   countryCode == null ||  registerusername.isEmpty ||  registeruseremail.isEmpty ||  registeruserpass.isEmpty )
        {
            ScaffoldMessenger.of(context).showSnackBar(   SnackBar( content: Text("Please fill all the fields."),    ),   );
            return; // Exit the function if any field is empty
        }

        try {
                // Continue with user registration
                UserCredential registeruserCredential = await FirebaseAuth
                                                            .instance
                                                            .createUserWithEmailAndPassword
                                                            ( email: registeruseremail, password: registeruserpass  );

                if (registeruserCredential.user != null)
                {

                        // Showing loading indicator
                        showDialog( context: context,   builder: (context){
                          return Center(child: CircularProgressIndicator( color: Colors.deepPurple, backgroundColor: Colors.grey) ); },  );

                        // // Allow access to the User section after a delay (you can use a Future.delayed here)
                        // await Future.delayed(Duration(seconds: 9)); // Replace with actual processing time

                        // Registration is successful, now upload the profile image
                        final storage = FirebaseStorage.instance;
                        final reference = storage.ref().child('User Profile Img Url/${DateTime.now()}.png');

                        final uploadTask = reference.putFile(_profileImage!);
                        final snapshot = await uploadTask.whenComplete(() {});
                        final imageUrl = await snapshot.ref.getDownloadURL(); // Get the imageUrl

                        // Save user all data to Firestore
                        final firestore = FirebaseFirestore.instance;
                        final user = FirebaseAuth.instance.currentUser;

                        await firestore.collection('User').doc(user!.uid).set({
                                'Name': registerusername,
                                'Email': registeruseremail,
                                'Phone Number': "${countryCode?.dialCode}-$phoneNumber",
                                'Profile Img Url': imageUrl,
                                'Password': registeruserpass
                                // Add other user details here...
                        });


                        // Closing loading indicator
                        Navigator.of(context).pop();

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => UserHomePage()),
                        );

                }
        }
        on FirebaseAuthException catch (e)
        {
                // Closing loading indicator
                Navigator.of(context).pop();

                if (e.code == 'weak-password')
                {
                  ScaffoldMessenger.of(context).showSnackBar(   SnackBar(  content: Text('Password is too weak.'),  ),   );
                } else if (e.code == 'email-already-in-use')
                {
                  ScaffoldMessenger.of(context).showSnackBar(   SnackBar(  content: Text('The account already exists for that email.'),   ),   );
                }
        }
        catch (e)
        {
                print(e);
        }
      },

      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        elevation: 20,
        shadowColor: myColor,
        minimumSize: const Size.fromHeight(60),
      ),
      child: const Text("Register Me"),
    );
  }


}
