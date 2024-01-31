import 'package:cheapest_item_ninja/classes/ActiveProduct.dart';
import 'package:cheapest_item_ninja/classes/Categories.dart';
import 'package:cheapest_item_ninja/classes/Products.dart';
import 'package:cheapest_item_ninja/pages/Home.dart';
import 'package:cheapest_item_ninja/pages/PriceCheckProducts.dart';
import 'package:cheapest_item_ninja/pages/ViewAllProducts.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../classes/Users.dart';

List<Categories> categories=[];
double convertedUnits=0;
String? selectedCategory ="not selected";
String? selectUnitOfMeasurement;
TextEditingController unitOfMeasurementController = TextEditingController();

class AddProduct extends StatefulWidget {
  final String? barcode;
  final Users currentUser;
  final List<Categories> categoriesReceived;
  const AddProduct({super.key, required this.barcode, required this.currentUser,required this.categoriesReceived});

  @override
  State<AddProduct> createState() => _AddProductState();

}

class _AddProductState extends State<AddProduct> {

  TextEditingController productNameController = TextEditingController();
  TextEditingController categoriesController = TextEditingController();
  TextEditingController unitsController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    categories = widget.categoriesReceived;

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
                        "Price comparison",
                        style: GoogleFonts.bebasNeue(
                            fontSize: 32,
                            color: Colors.black),),
                    ),
                  ),
                  PopupMenuItem(
                    value: 2,
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
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> HomeScreen(
                      user: widget.currentUser)));
                }
                else if(value == 1)
                {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> PriceCheckProducts(
                      currentUser: widget.currentUser)));
                }
                else if(value == 2)
                  {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ViewAllProducts(
                        currentUser: widget.currentUser)));
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
                              "Add Product",
                              style: GoogleFonts.bebasNeue(
                                  fontSize: 32,
                                  color: Colors.black),),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.002,),
                          DropdownMenu
                            (
                            //width: MediaQuery.of(context).size.width *0.0984,
                            //controller: categoriesController,
                            onSelected: (Categories? category)
                            {
                              setState(()
                              {
                                linkSelectedCategoryToUoM(category,categoriesController);
                              });
                            },
                            // enableFilter: true,
                            // requestFocusOnTap: true,
                            enabled: true,
                            width: MediaQuery.of(context).size.width * 0.74,
                            label:  Text("Select Product Category",style: GoogleFonts.ubuntu(fontSize: 24, color: Colors.black),),
                            textStyle: GoogleFonts.ubuntu(fontSize: 24, color: Colors.black),
                            dropdownMenuEntries:
                            categories.map<DropdownMenuEntry<Categories>>(
                                  (Categories category) {
                                return DropdownMenuEntry<Categories>(
                                  value: category,
                                  label: category.name,
                                );
                              },
                            ).toList(),
                          ),

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

                          SizedBox(height: MediaQuery.of(context).size.height * 0.03,),

                          Padding(
                            padding: EdgeInsets.fromLTRB(
                                MediaQuery.of(context).size.width *0.08,
                                0,
                                MediaQuery.of(context).size.width *0.08,
                                0),
                            child: TextField
                              (
                              controller: unitOfMeasurementController,
                              readOnly: true,
                              decoration: InputDecoration
                                (

                                labelText: "Product Unit of Measurement",
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
                              onPressed: (){addProductToDB(widget.barcode, selectedCategory as String,
                                productNameController.text, double.parse(unitsController.text), double.parse(priceController.text)
                                , widget.currentUser.id);

                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> PriceCheckProducts(currentUser: widget.currentUser)));

                              },

                              style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.greenAccent),),
                              child:
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text("Add Product",
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

void linkSelectedCategoryToUoM(Categories? categories, TextEditingController controller)
{
  unitOfMeasurementController = controller;
  unitOfMeasurementController.text = categories!.unitOfMeasurement;
  selectedCategory = categories.name;

}

void addProductToDB(String? barcode,
    String category,
    String productName,
    double units,
    double price,
    String userID) async
{

  bool productPassed = false;
  bool activeProductPassed = false;
  var db = FirebaseFirestore.instance;
  final productsRef = db.collection('Products');
  final productsQuery = productsRef.where("barcode", isEqualTo: barcode).limit(1);
  String? productDocID;
  final activeProductsRef = db.collection('ActiveProducts');
  final activeProductsQuery = activeProductsRef.where("barcode", isEqualTo: barcode).where("userID", isEqualTo: userID).limit(1);
  String? activeProductsDocID;
  final pricePerUoM = calculatePricePerUoM(units,
      price, unitOfMeasurementController.text);

  final Products product = Products(price: price,
      pricePerUnitOfMeasurement: pricePerUoM,
      category: category, name: productName,
      units: units, unitOfMeasurement: selectUnitOfMeasurement as String,
      barcode: barcode as String);

  final ActiveProduct activeProduct = ActiveProduct(price: price,
      pricePerUnitOfMeasurement: pricePerUoM,
      category: category, name: productName,
      units: units, unitOfMeasurement: selectUnitOfMeasurement as String,
      barcode: barcode, userID: userID, isActive: true);

  //try and catch blocks was added to prevent no element exception when finding document ID and there is no elements
  try// first try catch is to check if there is an element in products
  {
    productDocID = await productsQuery.get().then((value) => value.docs.firstOrNull?.id);
    productsRef.doc(productDocID).set(product.toFirestore());
    productPassed = true;

    try //second try catch is to check if there is an element in activeProducts that matches as activeProducts is linked to an specific user
    {
      activeProductsDocID = await activeProductsQuery.get().then((value) => value.docs.firstOrNull?.id );
      activeProductsRef.doc(activeProductsDocID).set(activeProduct.toFirestore());
      activeProductPassed = true;
      return;
    }
    catch(e)
    {
      print(e);
    }

  }
  catch(e)
  {
    print(e);
  }

  if(productPassed == false && activeProductPassed == false)
    {
      productsRef.doc().set(product.toFirestore());
      activeProductsRef.doc().set(activeProduct.toFirestore());
    }
  else if(productPassed == true && activeProductPassed == false)
    {
      activeProductsRef.doc().set(activeProduct.toFirestore());
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



