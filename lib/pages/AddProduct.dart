import 'package:cheapest_item_ninja/classes/ActiveProduct.dart';
import 'package:cheapest_item_ninja/classes/Categories.dart';
import 'package:cheapest_item_ninja/classes/Products.dart';
import 'package:cheapest_item_ninja/pages/Home.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../classes/Users.dart';

List<Categories> categories=[];
double convertedUnits=0;
TextEditingController unitOfMeasurementController = TextEditingController();

class AddProduct extends StatefulWidget {
  final String? barcode;
  final Users user;
  final List<Categories> categoriesReceived;
  const AddProduct({super.key, required this.barcode, required this.user,required this.categoriesReceived});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  @override
  Widget build(BuildContext context) {

    TextEditingController productNameController = TextEditingController();
    TextEditingController categoriesController = TextEditingController();
    TextEditingController unitsController = TextEditingController();
    TextEditingController priceController = TextEditingController();

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
                              onPressed: (){addProductToDB(widget.barcode, categoriesController.text,
                                productNameController.text, double.parse(unitsController.text), double.parse(priceController.text)
                                , widget.user.id);

                              Future.delayed(const Duration(seconds: 5), () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const HomeScreen()));
                              });

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

}

void addProductToDB(String? barcode,
    String category,
    String productName,
    double units,
    double price,
    String userID) async
{

  var db = FirebaseFirestore.instance;
  final products = db.collection('Products');
  final activeProducts = db.collection('ActiveProducts');
  final PricePerUoM = calculatePricePerUoM(units,
      price, unitOfMeasurementController.text);

  final Products product = Products(id: "", price: price,
      pricePerUnitOfMeasurement: PricePerUoM,
      category: category, name: productName,
      units: units, unitOfMeasurement: unitOfMeasurementController.text,
      barcode: barcode as String, userID: userID);

  final ActiveProduct activeProduct = ActiveProduct(id: "", price: price,
      pricePerUnitOfMeasurement: PricePerUoM,
      category: category, name: productName,
      units: units, unitOfMeasurement: unitOfMeasurementController.text,
      barcode: barcode, userID: userID, isActive: true);

  // final productDataSet = <String, dynamic>{
  //   "id": product.id,
  //   "category": product.category,
  //   "name": product.name,
  //   "units": product.units,
  //   "unitOfMeasurement": product.unitOfMeasurement,
  //   "price": product.price,
  //   "pricePerUnitOfMeasurement": product.pricePerUnitOfMeasurement,
  //   "barcode": product.barcode,
  //   "userID": product.userID,
  // };
  // final activeProductDataSet = <String, dynamic>{
  //   "id": activeProduct.id,
  //   "category": activeProduct.category,
  //   "name": activeProduct.name,
  //   "units": activeProduct.units,
  //   "unitOfMeasurement": activeProduct.unitOfMeasurement,
  //   "price": activeProduct.price,
  //   "pricePerUnitOfMeasurement": activeProduct.pricePerUnitOfMeasurement,
  //   "barcode": activeProduct.barcode,
  //   "userID": activeProduct.userID,
  //   "isActive": activeProduct.isActive,
  //
  // };

  final testProduct = db.collection('Products');
  Products testproduct = Products
    (id: "", price: 50,
      pricePerUnitOfMeasurement: 100,
      category: "cheese", name: "Gouda", units: 500,
      unitOfMeasurement: "g", barcode: "6001051003884",
      userID: "testing");

  final data = testproduct.toFirestore();
  testProduct.doc().set(data);

  products.doc().set(product.toFirestore());
  activeProducts.doc().set(activeProduct.toFirestore());
}

double calculatePricePerUoM(double units,
    double price, String unitOfMeasurement)
{
  if(unitOfMeasurement.toLowerCase() == "g")
  {
    convertedUnits = units /1000;
    return price / convertedUnits;
  }
  else if(unitOfMeasurement.toLowerCase() == "kg")
  {
    convertedUnits = units;
    return price / units;
  }
  else if(unitOfMeasurement.toLowerCase() == "l")
  {
    convertedUnits = units;
    return price / units;
  }
  else if(unitOfMeasurement.toLowerCase() == "ea")
  {
    convertedUnits = units;
    return price / units;
  }
  return 0;
}



