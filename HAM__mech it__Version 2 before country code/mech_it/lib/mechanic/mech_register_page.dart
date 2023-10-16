import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mech_it/mechanic/mech_register_page.dart';
import 'package:mech_it/mechanic/mech_home_page.dart';


class MechRegisterPage extends StatefulWidget {
  const MechRegisterPage({super.key});

  @override
  State<MechRegisterPage> createState() => _MechRegisterPageState();
}

class _MechRegisterPageState extends State<MechRegisterPage> {
  late Color myColor;
  late Size mediaSize;

  TextEditingController registermechnameController = TextEditingController();

  TextEditingController registermechcountryCodeController = TextEditingController();
  TextEditingController registermechphoneController = TextEditingController();

  TextEditingController registermechemailController = TextEditingController();
  TextEditingController registermechpasswordController = TextEditingController();

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
        _buildGreyText("Dear Mechanic, fill details to register yourself"),
        const SizedBox(height: 10), // Reduced spacing
        _buildInputField(
          registermechnameController,
          hintText: "Name",
          prefixIcon: Icon(Icons.person),
        ),

        const SizedBox(height: 10), // Reduced spacing
        _buildInputField(
        registermechcountryCodeController,
        hintText: "Country Code",
        prefixIcon: Icon(Icons.add),
        ),

        const SizedBox(height: 10), // Reduced spacing
        _buildInputField(
        registermechphoneController,
        hintText: "Phone number",
        ),


        const SizedBox(height: 10), // Reduced spacing
        _buildInputField(
          registermechemailController,
          hintText: "Email address",
          prefixIcon: Icon(Icons.email),
        ),

        const SizedBox(height: 10), // Reduced spacing
        _buildInputField(
          registermechpasswordController,
          hintText: "Password",
          prefixIcon: Icon(Icons.lock),
          isPassword: true,
        ),

        const SizedBox(height: 20), // Kept spacing for the Register button
        _buildLoginButton(),
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

  Widget _buildMechPhone(
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




  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: () async {
        // debugPrint("name : ${phoneController.text}");
        // debugPrint("Phone : ${phoneController.text}");
        // debugPrint("Email : ${emailController.text}");
        // debugPrint("Password : ${passwordController.text}");

        final registermechemail = registermechemailController.text.trim();
        final registermechpass = registermechpasswordController.text.trim();

        try {
          UserCredential registermechCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: registermechemail, password: registermechpass );

          if (registermechCredential.user != null) {
            // Registration was successful
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MechHomePage(), ),  );
          }
        }
        on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {  print('The password provided is too weak.');  }
          else if (e.code == 'email-already-in-use') {  print('The account already exists for that email.');  }
        } catch (e) {
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
