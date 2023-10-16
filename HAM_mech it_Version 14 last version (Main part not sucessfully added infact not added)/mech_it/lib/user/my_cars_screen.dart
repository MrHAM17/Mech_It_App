import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../common/login_page.dart';

import 'car_details.dart';

class MyCarsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Cars'),
      ),
      body: Center(
        child: Text('My Cars Screen Content Goes Here'),
      ),
    );
  }
}
