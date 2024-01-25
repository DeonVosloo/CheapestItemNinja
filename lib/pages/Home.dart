import 'package:cheapest_item_ninja/pages/BarcodeScanner/BarcodeScannerView.dart';
import 'package:cheapest_item_ninja/pages/TestBarcodeScanner.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class HomeScreen extends StatefulWidget {
  List<Barcode> barcodesData;
   HomeScreen({super.key, required this.barcodesData});


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
            children: [
              //CustomCard("Barcode Scanning", BarcodeScannerView()),
              CustomCard("Barcode Scanning Test", TestBarcodeScanner()),
              //Text("Barcode data first barcode raw value: ${widget.barcodesData.first.rawValue}"),


            ],
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final String _label;
  final Widget _viewPage;
  final bool featureCompleted;

  const CustomCard(this._label, this._viewPage, {this.featureCompleted = true});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.only(bottom: 10),
      child: ListTile(
        tileColor: Theme.of(context).primaryColor,
        title: Text(
          _label,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        onTap: () {
          if (!featureCompleted) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content:
                const Text('This feature has not been implemented yet')));
          } else {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => _viewPage));
          }
        },
      ),
    );
  }
}

