import 'package:cheapest_item_ninja/classes/Users.dart';
import 'package:cheapest_item_ninja/pages/PriceCheckProducts.dart';
import 'package:cheapest_item_ninja/pages/ViewAllProducts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
final Users user;
   const HomeScreen({super.key, required this.user});


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar
          (
          centerTitle: true,
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
                        "Price comparison",
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
                        "View All Products",
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
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> PriceCheckProducts(
                      currentUser: widget.user)));
                }
                else if(value == 1)
                {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ViewAllProducts(
                      currentUser: widget.user)));
                }

              },
            ),
          ],

          title: FittedBox
            (
            fit: BoxFit.scaleDown,
            child: Text("Price Check Products",style: GoogleFonts.bebasNeue(fontSize: 36, color: Colors.black),),
          ),
          backgroundColor: Colors.greenAccent[400],
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
                    child: ElevatedButton(onPressed: ()
                    {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> PriceCheckProducts(
                          currentUser: widget.user)));
                      },
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.greenAccent),),
                      child:
                      FittedBox(
                        fit: BoxFit.cover,
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
                    child: ElevatedButton(onPressed: ()
                    {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ViewAllProducts(
                        currentUser: widget.user,)));
                    },
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.greenAccent),),
                      child:
                      FittedBox(
                        fit: BoxFit.cover,
                        child: Text("view all products",
                          style: GoogleFonts.bebasNeue(fontSize: 36, color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )
      )
    );
  }
}


