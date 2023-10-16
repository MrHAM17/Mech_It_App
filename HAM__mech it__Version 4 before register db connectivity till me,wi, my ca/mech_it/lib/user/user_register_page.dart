import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mech_it/user/user_home_page.dart';
import 'package:mech_it/user/user_register_page.dart';

import 'package:fl_country_code_picker/fl_country_code_picker.dart';



class UserRegisterPage extends StatefulWidget {
  const UserRegisterPage({super.key});

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
  final TextEditingController phoneNumberController =TextEditingController();
  CountryCode? countryCode;

  TextEditingController registeruseremailController = TextEditingController();
  TextEditingController registeruserpasswordController = TextEditingController();

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
          colorFilter:
          ColorFilter.mode(myColor.withOpacity(0.2), BlendMode.dstATop),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(children: [
          Positioned(top: 80, child: _buildTop()),
          Positioned(bottom: 0, child: _buildBottom()),
        ]),
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
            // Icons.diversity_1_outlined,
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
                letterSpacing: 2),
          )
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
            )),
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
        borderRadius: BorderRadius.circular(5.0), // You can change the border radius here
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: prefixIcon,
          contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
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
                        final code = await countryPicker.showPicker(context: context);
                        setState(() {
                          countryCode = code;
                        });
                      },
                      child: Row(
                        children: [
                          Container(
                            child: countryCode != null ? countryCode!.flagImage() : null,

                      //  If below 2 (Atleast still width) are not commented then by default country code box will not available from extreme left, some space ariives their & get cancel after choosing flag by code
                      //         width: 30, // Adjust the width of flag as needed
                              height: 30 // Adjust the height of flag as needed
                          ),

                          const SizedBox(width: 5),  // space between right side of flag & left side of country code box

                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 6),   // space both side to the country code inside that country code's box
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              countryCode?.dialCode ?? "+",
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),

                          const SizedBox(width: 0),  // space to the left side of phone number

                          Text(
                            phoneNumberController.text.trim(),
                            style: const TextStyle(fontSize: 14),  // space below the hint of phone number frame
                          ), // Display the phone number text here
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



  Widget _buildRegisterButton() {
    return ElevatedButton(
      onPressed: () async {

        // debugPrint("name : ${phoneController.text}");
        // debugPrint("Phone : ${phoneController.text}");
        // debugPrint("Email : ${emailController.text}");
        // debugPrint("Password : ${passwordController.text}");

        final registeruseremail = registeruseremailController.text.trim();
        final registeruserpass = registeruserpasswordController.text.trim();

        if(countryCode != null){
          ScaffoldMessenger
              .of(context)
              .showSnackBar(SnackBar(content: Text("${countryCode?.dialCode}-${phoneNumberController.text.trim()}")
          ));
        }
        else{
          ScaffoldMessenger
              .of(context)
              .showSnackBar(SnackBar(content: Text("Please select the country code")
          ));
        }

        try {
          UserCredential registeruserCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: registeruseremail, password: registeruserpass );

          if (registeruserCredential.user != null) {
            // Registration was successful
            // print('Email: ${registeruseremailController.text}');
            // print('Password: ${registeruserpasswordController.text}');
            // print(email);
            // print(pass);
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => UserHomePage(), ),  );
          }

        }

        on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {  print('The password provided is too weak.');  }
          else if (e.code == 'email-already-in-use') {  print('The account already exists for that email.');  }
        }

        catch (e) {
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


