import 'package:cheapest_item_ninja/pages/AddProduct.dart';
import 'package:cheapest_item_ninja/pages/Home.dart';
import 'package:cheapest_item_ninja/pages/TestPage.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp
      (
        home: HomeScreen()
    );
  }
}
