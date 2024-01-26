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
        actions: [
          PopupMenuButton(
            itemBuilder: (context)
            {
              return[
                PopupMenuItem(
                  value: 0,
                  child: FittedBox
                    (
                    fit: BoxFit.contain,
                    child: Text(
                      "Check Product Price",
                      style: GoogleFonts.bebasNeue(
                          fontSize: 32,
                          color: Colors.black),),
                  ),
                ),
                PopupMenuItem(
                  value: 1,
                  child: FittedBox
                    (
                    fit: BoxFit.contain,
                    child: Text(
                      "View All products",
                      style: GoogleFonts.bebasNeue(
                          fontSize: 32,
                          color: Colors.black),),
                  ),
                ),
              ];
            },
            onSelected: (value)
            {
              if(value == 0)
              {

              }
              else if(value == 1)
              {

              }

            },
          ),
        ],
        //titleTextStyle: GoogleFonts.bebasNeue(fontSize: 36),
        title: FittedBox
          (
          fit: BoxFit.scaleDown,
          child: Text("Price Check Ninja",style: GoogleFonts.bebasNeue(fontSize: 36, color: Colors.white),),
        ),
        backgroundColor: Colors.lightBlueAccent[400],
      ),

      body: Container
        (
          decoration: const BoxDecoration
            (

            image: DecorationImage
              (
                image:  AssetImage("assets/background.jpg"),
                fit: BoxFit.fill
            ),
          ),

          child: ListView
            (
            children: [
              Column
                (

                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.25,),
                  SizedBox
                    (
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: ElevatedButton(onPressed: (){},
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.greenAccent),),
                      child:
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text("Check price of products",
                          style: GoogleFonts.bebasNeue(fontSize: 36, color: Colors.black),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.02,),

                  SizedBox
                    (
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: ElevatedButton(onPressed: (){},
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.greenAccent),),
                      child:
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text("view all products",
                          style: GoogleFonts.bebasNeue(fontSize: 36, color: Colors.black),
                        ),
                      ),
                    ),
                  ),

                  //CustomCard("Barcode Scanning Test", TestBarcodeScanner()),


                ],
              ),
            ],
          )
      )
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

