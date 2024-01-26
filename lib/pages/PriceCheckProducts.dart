import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PriceCheckProducts extends StatefulWidget {
  const PriceCheckProducts({super.key});

  @override
  State<PriceCheckProducts> createState() => _PriceCheckProductsState();
}

class _PriceCheckProductsState extends State<PriceCheckProducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold
      (
      appBar:AppBar
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

                ],
              ),
            ],
          )
      )
    );
  }
}
