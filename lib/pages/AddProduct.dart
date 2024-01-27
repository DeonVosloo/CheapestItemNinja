import 'package:cheapest_item_ninja/classes/Categories.dart';
import 'package:cheapest_item_ninja/classes/UnitsOfMeasurement.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:path/path.dart';

import '../classes/Users.dart';

List<Categories> categories=[];
List<UnitsOfMeasurement> unitsOfMeasurement=[];

class AddProduct extends StatefulWidget {
  final List<Barcode>? barcodesData;
  final Users? user;
  const AddProduct({super.key, required this.barcodesData, required this.user});

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
    setCategories();
    setUnitsOfMeasurement();

    Categories? selectedCategory;
    UnitsOfMeasurement selectedUoM;

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
                            width:  MediaQuery.of(context).size.width*0.001,
                          style: BorderStyle.solid,
                          color: Colors.black
                        ),
                        borderRadius: const BorderRadius.all(Radius.circular(0.2)),
                        color: Colors.white
                      ),
                      child: Column
                        (
                        children: [
                          SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                          DropdownMenu
                            (
                            //width: MediaQuery.of(context).size.width *0.0984,
                            controller: categoriesController,
                            onSelected: (Categories? category)
                            {
                              setState(()
                              {
                                selectedCategory = category;
                              });
                            },
                            // enableFilter: true,
                            // requestFocusOnTap: true,
                            enabled: true,
                            width: MediaQuery.of(context).size.width * 0.74,
                            label:  Text("Select Product Category",style: GoogleFonts.ubuntu(fontSize: 16, color: Colors.black),),
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
                                    labelStyle: GoogleFonts.bebasNeue(fontSize: 24),
                                  ),
                                  style: GoogleFonts.ubuntu
                                    (
                                    fontSize: 24,
                                  ),
                                ),
                              ),

                          SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
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


void setCategories()
async {
  var db = FirebaseFirestore.instance;
  final categoriesDB = db.collection("Categories");
  List<Categories> categoriesFinal=[];

  final ref = categoriesDB.withConverter(fromFirestore: Categories.fromFirestore,
    toFirestore: (Categories categories, _) => categories.toFirestore(),);
  final docSnap = await ref.get();
  final tempCategories = docSnap.docs;
    for (var item in tempCategories)
    {
      categoriesFinal.add(item.data());
    }
  categories = categoriesFinal;
}

Future<List<UnitsOfMeasurement>> setUnitsOfMeasurement()
async {
  var db = FirebaseFirestore.instance;
  final UnitsOfMeasurementDB = db.collection("UnitsOfMeasurement");
  List<UnitsOfMeasurement> uoM=[];

  final ref = UnitsOfMeasurementDB.withConverter(fromFirestore: UnitsOfMeasurement.fromFirestore,
    toFirestore: (UnitsOfMeasurement  unitsOfMeasurement, _) => unitsOfMeasurement.toFirestore(),);
  final docSnap = await ref.get();
  final tempUnitsOfMeasurement = docSnap.docs;
  for (var item in tempUnitsOfMeasurement)
  {
    uoM.add(item.data());
  }
 unitsOfMeasurement = uoM;
  return uoM;
}


