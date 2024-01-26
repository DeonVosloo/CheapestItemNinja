import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Home.dart';

class PriceCheckProducts extends StatefulWidget {
  const PriceCheckProducts({super.key});

  @override
  State<PriceCheckProducts> createState() => _PriceCheckProductsState();
}

class _PriceCheckProductsState extends State<PriceCheckProducts> {

  // final Stream<QuerySnapshot> activeProductsStream =
  // FirebaseFirestore.instance.collection('ActiveProducts').where("isActive",
  //     isEqualTo: true).where("userID", isEqualTo: "").snapshots();


  @override
  Widget build(BuildContext context) {
    return Scaffold
      (
      appBar:AppBar
        (
        centerTitle: true,
        actions: [
        FittedBox
          (
          fit: BoxFit.cover,
          child: PopupMenuButton(
            itemBuilder: (context)
            {
              return[
                PopupMenuItem(
                  value: 0,
                  child: FittedBox
                    (
                    fit: BoxFit.contain,
                    child: Text(
                      "Home",
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
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const HomeScreen()));
              }
              else if(value == 1)
              {

              }

            },
          ),
        )
        ],

        leading: FittedBox
          (
          fit:BoxFit.cover,
          child: IconButton
            (
            onPressed: (){ Navigator.pop(context);},
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        title: FittedBox
        (
        fit: BoxFit.scaleDown,
        child: Text("Price Check Products",style: GoogleFonts.bebasNeue(fontSize: 36, color: Colors.black),),
        ),
        backgroundColor: Colors.greenAccent[400],
        ),

      body:  Container
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
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:
                    [

                    ],
                  )

                ],
              ),
            ],
          )
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){},
        tooltip: 'add product',
        label: FittedBox
          (
          fit: BoxFit.scaleDown,
          child: Text(
            "Add Product",
            style: GoogleFonts.bebasNeue(
                fontSize: 24,
                color: Colors.black),),
        ),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.greenAccent,

      ),
    );
  }
}
