import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mech_it/user/user_register_page.dart';
import 'package:mech_it/mechanic/mech_register_page.dart';

import 'package:mech_it/common/login_page.dart';

class SpalshScreen extends StatefulWidget
{
  @override
  State<SpalshScreen> createState() => _SpalshScreenState();
}

class _SpalshScreenState extends State<SpalshScreen>
{
  @override
  void initState()
  {
    super.initState();
    Timer(Duration(seconds: 1), ()
    {
      Navigator.pushReplacement
        (context,
          MaterialPageRoute(
                              builder: (context) => LoginPage(),
                           )
        ) ;
    });
  }


  @override
  Widget build(BuildContext context)
  {
    return Scaffold
    (
      body: Container
      (
        color: Colors.purple.shade800,
        child: Center(child: Text('Mech !t',
                                  style: TextStyle
                                         (fontSize: 34,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white
                                         ),
                                  )
                      ),
      ),
    );

  }



}
//