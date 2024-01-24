import 'package:cheapest_item_ninja/pages/Home.dart';
import 'package:cheapest_item_ninja/pages/TestBarcodeScanner.dart';
import 'package:flutter/material.dart';
import 'pages/login.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp
      (
      home: HomeScreen(),
    );
  }
}
