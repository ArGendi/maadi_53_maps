// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:maadi_53_maps/screens/map_screen.dart';

//AIzaSyAsgg8XAEz9Ixd0eTdE2WrUIcKTuclB9Z8

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MapScreen(),
    );
  }
}
