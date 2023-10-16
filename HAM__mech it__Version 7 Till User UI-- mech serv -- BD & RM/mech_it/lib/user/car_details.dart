import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mech_it/user/user_home_page.dart';
import 'package:mech_it/user/user_home_page.dart';
import 'package:mech_it/user/user_home_page.dart';
import '../common/login_page.dart';
import 'car_details.dart';
import 'user_home_page.dart';
import 'user_home_page.dart'; // Import the CarDetails class directly from the file

class UserCarDetails extends StatefulWidget {
  // final CarDetails carDetails;
  // final Function onNext;

  // UserCarDetails({required this.carDetails, required this.onNext});

  @override
  _UserCarDetailsState createState() => _UserCarDetailsState();
}


class _UserCarDetailsState extends State<UserCarDetails> {
  final TextEditingController brandController = TextEditingController();
  final TextEditingController modelController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController informationController = TextEditingController();

  @override
  void dispose() {
    brandController.dispose();
    modelController.dispose();
    yearController.dispose();
    informationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Car Detail',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        // Input fields for car details
        TextFormField(
          controller: brandController,
          decoration: InputDecoration(labelText: 'Car Brand'),
        ),
        TextFormField(
          controller: modelController,
          decoration: InputDecoration(labelText: 'Car Model'),
        ),
        TextFormField(
          controller: yearController,
          decoration: InputDecoration(labelText: 'Year of Production'),
        ),
        TextFormField(
          controller: informationController,
          decoration: InputDecoration(labelText: 'Additional Information'),
        ),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            // // Save the entered car details to the carDetails object
            // widget.carDetails.brand = brandController.text;
            // widget.carDetails.model = modelController.text;
            // widget.carDetails.year = yearController.text;
            // widget.carDetails.information = informationController.text;
            //
            // // Call the onNext function to navigate to the next page
            // widget.onNext();
          },
          child: Text('Next'),
        ),
      ],
    );
  }
}
