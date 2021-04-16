import 'package:crwordapp/AdminHome.dart';

import 'algorithm.dart';
import 'Register.dart';
import 'Find.dart' ;
import 'Radmin.dart';
import 'package:geolocator/geolocator.dart';
import 'login.dart';
import 'package:flutter/material.dart';

import 'login1.dart';
import 'Menu.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const PrimaryColor = const Color(0xff4db8ac);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: PrimaryColor,
      ),

      home: login(),



    );
  }
}
