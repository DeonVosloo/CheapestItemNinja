import 'package:cheapest_item_ninja/pages/BarcodeScanner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../classes/ActiveProduct.dart';
import '../classes/Users.dart';
import 'Home.dart';

late final Users user;
class ViewAllProducts extends StatefulWidget {
  final Users currentUser;
  const ViewAllProducts({super.key, required this.currentUser});

  @override
  State<ViewAllProducts> createState() => _PriceCheckProductsState();
}

class _PriceCheckProductsState extends State<ViewAllProducts> {

  final Stream<QuerySnapshot> activeProductsStream =
  FirebaseFirestore.instance.collection('ActiveProducts').snapshots();

  @override
  Widget build(BuildContext context) {

    getUser(widget.currentUser);

    // ActiveProduct prod = ActiveProduct(price: 97,
    //     pricePerUnitOfMeasurement: 2.69, category: "Eggs", name: "Egga eggs", units: 36, unitOfMeasurement: "ea", barcode: "6001509812228", isActive: true, userID: "testing");
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
              //SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
              StreamBuilder<QuerySnapshot>(
                stream: activeProductsStream,
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text("Loading");
                  }

                  return ListView(
                    shrinkWrap: true,
                    physics : const NeverScrollableScrollPhysics(),
                    children: snapshot.data!.docs
                        .map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                      return Column(
                        children: [
                          SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                      Container(
                      width: MediaQuery.of(context).size.width * 0.90,
                      decoration: BoxDecoration
                      (
                      border: Border.all
                      (
                      width:  MediaQuery.of(context).size.width*0.002,
                      style: BorderStyle.solid,
                      color: Colors.greenAccent
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(25)),
                      color: Colors.white
                      ),
                      child: Column
                      (

                      children: [
                      SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                      FittedBox
                      (
                      alignment: Alignment.center,
                      fit: BoxFit.contain,
                      child: Text(
                      "${data['name']}",
                      style: GoogleFonts.bebasNeue(
                      fontSize: 32,
                      color: Colors.black),),
                      ),
                      Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                      Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      FittedBox
                      (
                        fit: BoxFit.cover,
                        child: Text(
                        "Product Name: ",
                        style: GoogleFonts.bebasNeue(
                        fontSize: 24,
                        color: Colors.black),),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.002,),
                      FittedBox
                      (
                        fit: BoxFit.cover,
                        child: Text(
                        "Product Category: ",
                        style: GoogleFonts.bebasNeue(
                        fontSize: 24,
                        color: Colors.black),),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.002,),
                      FittedBox
                      (
                        fit: BoxFit.cover,
                        child: Text(
                        "Product Units: ",
                        style: GoogleFonts.bebasNeue(
                        fontSize: 24,
                        color: Colors.black),),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.002,),
                      FittedBox
                      (
                        fit: BoxFit.cover,
                        child: Text(
                        "Product UoM: ",
                        style: GoogleFonts.bebasNeue(
                        fontSize: 24,
                        color: Colors.black),),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.002,),
                      FittedBox
                      (
                        fit: BoxFit.cover,
                        child: Text(
                        "Product Price: ",
                        style: GoogleFonts.bebasNeue(
                        fontSize: 24,
                        color: Colors.black),),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.002,),
                      FittedBox
                      (
                        fit: BoxFit.cover,
                        child: Text(
                        "R per UoM: ",
                        style: GoogleFonts.bebasNeue(
                        fontSize: 24,
                        color: Colors.black),),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.002,),
                      ],
                      ),
                      Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      FittedBox
                      (
                        fit: BoxFit.cover,
                        child: Text(
                        "${data['name']}",
                        style: GoogleFonts.bebasNeue(
                        fontSize: 24,
                        color: Colors.black),),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.002,),
                      FittedBox
                      (
                        fit: BoxFit.cover,
                        child: Text(
                        "${data['category']}",
                        style: GoogleFonts.bebasNeue(
                        fontSize: 24,
                        color: Colors.black),),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.002,),
                      FittedBox
                      (
                        fit: BoxFit.cover,
                        child: Text(
                        "${data['units']}",
                        style: GoogleFonts.bebasNeue(
                        fontSize: 24,
                        color: Colors.black),),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.002,),
                      FittedBox
                      (
                        fit: BoxFit.cover,
                        child: Text(
                        "${data['unitOfMeasurement']}",
                        style: GoogleFonts.bebasNeue(
                        fontSize: 24,
                        color: Colors.black),),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.002,),
                      FittedBox
                      (
                        fit: BoxFit.cover,
                        child: Text(
                        "${data['price']}",
                        style: GoogleFonts.bebasNeue(
                        fontSize: 24,
                        color: Colors.black),),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.002,),
                      FittedBox
                      (
                        fit: BoxFit.cover,
                        child: Text(
                        "R${ double.parse((data['pricePerUnitOfMeasurement']).toStringAsFixed(2))}/${data['unitOfMeasurement']}",
                        style: GoogleFonts.bebasNeue(
                        fontSize: 24,
                        color: Colors.black),),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.002,),
                      ],
                      ),
                      ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                        SizedBox
                          (
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: ElevatedButton(onPressed: ()
                          {
                            // Navigator.of(context).push(MaterialPageRoute(builder: (context)=> PriceCheckProducts(
                            //   currentUser: Users(id: "testing",email: "",password: "", username: "" ),)));
                          },
                            style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.greenAccent),),
                            child:
                            FittedBox(
                              fit: BoxFit.cover,
                              child: Text("Edit Product",
                                style: GoogleFonts.bebasNeue(fontSize: 36, color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                      ],
                      ),
                      ),

                        ],
                      );

                    })
                        .toList()
                        .cast(),
                  );
                },
              ),
            ],
          )
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: ()
        {
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> TestBarcodeScanner()));
        },
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


void getUser(Users currentUser)
{
  user = currentUser;
}