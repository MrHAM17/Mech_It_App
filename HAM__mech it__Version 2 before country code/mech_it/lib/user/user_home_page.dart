import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mech_it/user/user_home_page.dart';



import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_svg/svg.dart';

import 'package:mech_it/user/user_home_page.dart';
import 'package:mech_it/mechanic/mech_home_page.dart';

import 'package:mech_it/user/user_register_page.dart';
import 'package:mech_it/mechanic/mech_register_page.dart';

import 'package:mech_it/ham_consts.dart';


class UserHomePage extends StatelessWidget {
  const UserHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Home'),
      ),
    );

    print('We are in home user page');
  }

}