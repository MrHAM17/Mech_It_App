import 'package:flutter/material.dart';
import 'package:mech_it/user/break_downs_services_page.dart';
import 'package:mech_it/user/routine_maintenance_services_page.dart';
import 'package:mech_it/user/user_home_page.dart';

class MechanicServicesPage extends StatefulWidget {
  final VoidCallback clearListsCallback;

  MechanicServicesPage({required this.clearListsCallback});

  @override
  _MechanicServicesPageState createState() => _MechanicServicesPageState();
}

class _MechanicServicesPageState extends State<MechanicServicesPage> {
  // Existing code...

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          // Call the clearLists function when navigating back to the UserHomePage
          widget.clearListsCallback();
          Navigator.pop(context); // Navigate back to the UserHomePage
          return true;
        },
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 50),
              child: Image.asset(
                'assets/user images/mechanic_services.png',
              ),
            ),
            Container(
              color: Color.fromRGBO(0, 0, 250, 0.3),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.only(bottom: 100),
                child: Text(
                  'Services',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Add your mechanic services content here
                ],
              ),
            ),
            Positioned(
              bottom: 2,
              left: 4,
              right: 4,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.7,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Select One Of Yours Vehicle',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: CustomPaint(
                              size: Size(10, 10),
                              painter: TrianglePainter(),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Expanded(
                            child: Card(
                              elevation: 10,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          BreakDownsServicesPage(),
                                    ),
                                  );
                                },
                                child: SizedBox(
                                  width: 100,
                                  height: 150,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset('assets/user images/breakdown.png',
                                          width: 100, height: 100),
                                      Text('Breakdowns'),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Card(
                              elevation: 10,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          RoutineMaintenanceServicesPage(),
                                    ),
                                  );
                                },
                                child: SizedBox(
                                  width: 100,
                                  height: 150,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset('assets/user images/maintenance.png',
                                          width: 100, height: 100),
                                      Text('Maintenance'),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Card(
                            elevation: 10,
                            child: InkWell(
                              onTap: () {
                                // Navigate to Need Help screen
                              },
                              child: SizedBox(
                                width: 166,
                                height: 150,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset('assets/user images/need_help.png',
                                        width: 100, height: 100),
                                    Text('Need Help'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 50),
                      Text(
                        'Popular Services',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Handle Popular Service 1 button tap
                            },
                            child: Text(
                              'Popular Service 1',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Handle Popular Service 2 button tap
                            },
                            child: Text(
                              'Popular Service 2',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey[800]!
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(size.width / 2, size.height);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

// This also worked while coding for clearing lists but still comment it
// void main() {
//   runApp(MaterialApp(
//     home: UserHomePage(),
//   ));
// }




void main() {
  runApp(MaterialApp(
    home: MechanicServicesPage(clearListsCallback: () {  },),
  ));
}
