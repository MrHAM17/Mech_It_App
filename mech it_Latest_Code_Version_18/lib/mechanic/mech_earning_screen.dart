import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MechEarningScreen(),
    );
  }
}

class MechEarningScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Earnings'),
      ),
      body: Center(
        child: Text(
          'Your Earnings will be displayed here.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
