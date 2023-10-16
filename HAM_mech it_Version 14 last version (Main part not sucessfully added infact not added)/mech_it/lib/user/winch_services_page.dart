import 'package:flutter/material.dart';

class WinchServicesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Winch Services'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'coming soon...',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            // Add your mechanic services content here
            // For example, you can display a list of available services
            // or other relevant information.
          ],
        ),
      ),
    );
  }
}
