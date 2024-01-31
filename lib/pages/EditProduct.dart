import 'package:cheapest_item_ninja/classes/Categories.dart';
import 'package:cheapest_item_ninja/classes/Products.dart';
import 'package:cheapest_item_ninja/pages/ViewAllProducts.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../classes/Users.dart';


double convertedUnits=0;
String? selectedCategory ="not selected";
String? selectUnitOfMeasurement;
TextEditingController unitOfMeasurementController = TextEditingController();

class EditProduct extends StatefulWidget {
  final String? barcode;
  final Users currentUser;
  final Products product;
  const EditProduct({super.key, required this.barcode, required this.currentUser,required this.product});

  @override
  State<EditProduct> createState() => _EditProductState();

}

class _EditProductState extends State<EditProduct> {
  @override
  Widget build(BuildContext context) {



    TextEditingController productNameController = TextEditingController();
    TextEditingController unitOfMeasurementController = TextEditingController();
    TextEditingController unitsController = TextEditingController();
    TextEditingController priceController = TextEditingController();

    productNameController.text = widget.product.name;
    unitsController.text = "${widget.product.units}";
    priceController.text = "${widget.product.price}";
    unitOfMeasurementController.text = widget.product.unitOfMeasurement;



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
          child: Text("Add Product Details",style: GoogleFonts.bebasNeue(fontSize: 36, color: Colors.black),),
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
                  SizedBox(height: MediaQuery.of(context).size.height * 0.08,),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: MediaQuery.of(context).size.height * 0.04,),
                        FittedBox
                          (
                          fit: BoxFit.contain,
                          child: Text(
                            "Update Product",
                            style: GoogleFonts.bebasNeue(
                                fontSize: 32,
                                color: Colors.black),),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.002,),

                        SizedBox(height: MediaQuery.of(context).size.height * 0.001,),

                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width *0.08,
                              0,
                              MediaQuery.of(context).size.width *0.08,
                              0),
                          child: TextField
                            (
                            controller: productNameController,
                            decoration: InputDecoration
                              (

                              labelText: "Enter Product Name",
                              labelStyle: GoogleFonts.ubuntu(fontSize: 24),
                            ),
                            style: GoogleFonts.ubuntu
                              (
                              fontSize: 24,
                            ),
                          ),
                        ),

                        SizedBox(height: MediaQuery.of(context).size.height * 0.01,),

                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width *0.08,
                              0,
                              MediaQuery.of(context).size.width *0.08,
                              0),
                          child: TextField
                            (
                            inputFormatters: <TextInputFormatter>
                            [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))],
                            controller: unitsController,
                            decoration: InputDecoration
                              (

                              labelText: "Enter Product Units/weight",
                              labelStyle: GoogleFonts.ubuntu(fontSize: 24),
                            ),
                            style: GoogleFonts.ubuntu
                              (
                              fontSize: 24,
                            ),

                          ),
                        ),

                        SizedBox(height: MediaQuery.of(context).size.height * 0.01,),

                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width *0.08,
                              0,
                              MediaQuery.of(context).size.width *0.08,
                              0),
                          child: TextField
                            (
                            controller: unitOfMeasurementController,
                            enabled: true,
                            readOnly: true,
                            decoration: InputDecoration
                              (

                              labelText: "Product unit of measurement",
                              labelStyle: GoogleFonts.ubuntu(fontSize: 24),
                            ),
                            style: GoogleFonts.ubuntu
                              (
                              fontSize: 24,
                            ),
                          ),
                        ),

                        SizedBox(height: MediaQuery.of(context).size.height * 0.03,),


                        SizedBox(height: MediaQuery.of(context).size.height * 0.01,),

                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width *0.08,
                              0,
                              MediaQuery.of(context).size.width *0.08,
                              0),
                          child: TextField
                            (
                            inputFormatters: <TextInputFormatter>
                            [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))],
                            controller: priceController,
                            enabled: true,
                            decoration: InputDecoration
                              (

                              labelText: "Price of product",
                              labelStyle: GoogleFonts.ubuntu(fontSize: 24),
                            ),
                            style: GoogleFonts.ubuntu
                              (
                              fontSize: 24,
                            ),
                          ),
                        ),



                        SizedBox(height: MediaQuery.of(context).size.height * 0.04,),

                        SizedBox
                          (
                          width: MediaQuery.of(context).size.width * 0.55,
                          child: ElevatedButton
                            (
                            onPressed: (){updateProduct(productNameController.text, double.parse(unitsController.text), double.parse(priceController.text)
                                , widget.currentUser.id, widget.product);

                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>  ViewAllProducts(currentUser: widget.currentUser)));

                            },

                            style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.greenAccent),),
                            child:
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text("Update Product",
                                style: GoogleFonts.bebasNeue(fontSize: 36, color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.08,),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.08,),

                ],
              ),
            ],
          )
      ),

    );
  }
}

void linkSelectedCategoryToUoM(Categories? category, TextEditingController controller)
{
  unitOfMeasurementController = controller;
  unitOfMeasurementController.text = category!.unitOfMeasurement;
  selectedCategory = category.name;

}

void updateProduct(
    String productName,
    double units,
    double price,
    String userID, Products productTemp) async
{
  var db = FirebaseFirestore.instance;
  final productsRef = db.collection('Products');
  final productsQuery = productsRef.where("barcode", isEqualTo: productTemp.barcode).limit(1);
  String? productDocID;
  final pricePerUoM = calculatePricePerUoM(units,
      price, productTemp.unitOfMeasurement);

  final Products product = Products(price: price,
      pricePerUnitOfMeasurement: pricePerUoM,
      category: productTemp.category, name: productName,
      units: units, unitOfMeasurement: productTemp.unitOfMeasurement,
      barcode: productTemp.barcode);

  //try and catch blocks was added to prevent no element exception when finding document ID and there is no elements
  try//try catch is to check if there is an element in products otherwise if no such product exist the code will nothing
      {
    productDocID = await productsQuery.get().then((value) => value.docs.firstOrNull?.id);
    productsRef.doc(productDocID).set(product.toFirestore());
  }
  catch(e)
  {
    print(e);
  }

}

double calculatePricePerUoM(double units,
    double price, String unitOfMeasurement)
{
  if(unitOfMeasurement.toLowerCase() == "g")
  {
    selectUnitOfMeasurement ="kg";
    convertedUnits = units /1000;
    return price / convertedUnits;
  }
  else if(unitOfMeasurement.toLowerCase() == "kg")
  {
    selectUnitOfMeasurement ="kg";
    convertedUnits = units;
    return price / units;
  }
  else if(unitOfMeasurement.toLowerCase() == "l")
  {
    selectUnitOfMeasurement ="l";
    convertedUnits = units;
    return price / units;
  }
  else if(unitOfMeasurement.toLowerCase() == "ea")
  {
    selectUnitOfMeasurement ="ea";
    convertedUnits = units;
    return price / units;
  }
  return 0;
}