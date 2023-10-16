import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

import 'package:mech_it/common/login_page.dart';
import 'package:mech_it/common/login_page.dart';
import 'package:mech_it/common/spalsh_screen.dart';
import 'package:mech_it/user/break_downs_services_page.dart';
import 'package:mech_it/user/car_details.dart';
import 'package:mech_it/user/mechanic_services_page.dart';
import 'package:mech_it/user/routine_maintenance_services_page.dart';
import 'package:mech_it/user/user_register_page.dart';
import 'package:mech_it/mechanic/mech_register_page.dart';
import 'package:mech_it/user/user_home_page.dart';
import 'package:mech_it/mechanic/mech_home_page.dart';


import 'package:mech_it/user/my_cars_screen.dart'; // Import the MyCarsScreen
import 'package:mech_it/user/winch_services_page.dart';

import 'package:mech_it/user/selected_services_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.deepPurple      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      home: LoginPage(context: context,),

// ***

      // initialRoute: 'LoginPage',

      routes: {
        // 'LoginPage': (context) => LoginPage(),
        'UserRegisterPage': (context) => UserRegisterPage(),
        'MechRegisterPage': (context) => MechRegisterPage(),
        'UserHomePage': (context) => UserHomePage(),
        'MechHomePage': (context) => MechHomePage(),
        'my_cars_screen': (context) => MyCarsScreen(),
        // 'MechanicServisesPage': (context) =>  MechanicServicesPage(),
        'WinchiServisesPage': (context) =>  WinchServicesPage(),
        'BreakDownsServicesPage': (context) => BreakDownsServicesPage(),
        'RoutineMaintenanceServicesPage': (context) => RoutineMaintenanceServicesPage(),
        // 'SelectedServicePage': (context) => SelectedServicePage(),

        // 'LoginPage': (context) => LoginPage(),
        // 'LoginPage': (context) => MechRegisterPage(),
      },

///////   OR  ////////

//        home: LoginPage(), );

///////   OR  ////////

//       home: SpalshScreen(),
//       debugShowCheckedModeBanner: false, );

///////   OR  ////////

      // home: AnimatedSplashScreen(
      // splash: "assets/mechanic images/real_splash_screen.png", splashIconSize: 700,
      // splashTransition: SplashTransition.scaleTransition,
      // backgroundColor: Colors.purple.shade800,
      // duration: 0500,
      //   nextScreen: LoginPage(), ),
      // debugShowCheckedModeBanner: false, );


// *** //

    );

  }
}




















// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:animated_splash_screen/animated_splash_screen.dart';
//
// import 'package:mech_it/common/login_page.dart';
// import 'package:mech_it/common/spalsh_screen.dart';
// import 'package:mech_it/user/user_register_page.dart';
// import 'package:mech_it/mechanic/mech_register_page.dart';
// import 'package:mech_it/user/user_home_page.dart';
// import 'package:mech_it/mechanic/mech_home_page.dart';
// import 'package:mech_it/user/my_cars_screen.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(primarySwatch: Colors.deepPurple),
//       home: Builder(
//         builder: (context) => SplashScreen(), // Wrap MaterialApp with Builder
//       ),
//       routes: {
//         'UserRegisterPage': (context) => UserRegisterPage(),
//         'MechRegisterPage': (context) => MechRegisterPage(),
//         'UserHomePage': (context) => UserHomePage(),
//         'MechHomePage': (context) => MechHomePage(),
//         'my_cars': (context) => MyCarsScreen(),
//       },
//     );
//   }
// }
