import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar
        (
        leading: Container
          (
        ),
        titleTextStyle: GoogleFonts.ubuntu(fontSize: 36),
        title: const Text("Item Price Comparing Ninja"),
        backgroundColor: Colors.lightBlueAccent,
      ),

      body: ListView
        (

      ),
    );
  }
}
