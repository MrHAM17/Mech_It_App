import 'dart:async';
import 'package:mech_it/common/login_page.dart'; // Import LoginPage from the correct path

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mech_it/user/user_register_page.dart';
import 'package:mech_it/mechanic/mech_register_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 1), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => LoginPage(context: context), // You don't need to pass context here
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.purple.shade800,
        child: Center(
          child: Text(
            'Mech !t',
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}