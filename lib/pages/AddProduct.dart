import 'package:cheapest_item_ninja/classes/Categories.dart';
import 'package:cheapest_item_ninja/classes/UnitsOfMeasurement.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../classes/Users.dart';

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

    late List<Categories> categories = getCategories() as List<Categories>;
    final List<String> unitOfMeasurement = getUnitsOfMeasurement() as List<String>;
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
                            width:  MediaQuery.of(context).size.width*0.012,
                          style: BorderStyle.solid,
                          color: Colors.black
                        ),
                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                        color: Colors.white70
                      ),
                      child: Column
                        (
                        children: [
                           FittedBox(
                            fit: BoxFit.cover,
                            child: Column
                              (
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                DropdownMenu
                                  (
                                  controller: categoriesController,
                                  onSelected: (Categories? category)
                                    {
                                        setState(()
                                        {
                                          selectedCategory = category;
                                        });
                                    },
                                  enableFilter: true,
                                  requestFocusOnTap: true,
                                  label: FittedBox
                                    (
                                    fit: BoxFit.cover,
                                    child: Text("Select Product Category",style: GoogleFonts.ubuntu(fontSize: 16, color: Colors.black),),
                                  ),
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
                              ],
                            )
                          ),
                          FittedBox
                            (
                            fit: BoxFit.cover,
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


Future<List<Categories>> getCategories ()
async {
  var db = FirebaseFirestore.instance;
  final categoriesDB = db.collection("Categories");
  List<Categories> categoriesFinal=[];

  final ref = categoriesDB.withConverter(fromFirestore: Categories.fromFirestore,
    toFirestore: (Categories categories, _) => categories.toFirestore(),);
  final docSnap = await ref.get();
  final categories = docSnap.docs;
  if(categories != null)
    {
      for (var item in categories)
      {
        categoriesFinal.add(item.data());
      }
    }

  return categoriesFinal;
}

Future<List<String>> getUnitsOfMeasurement()
async {
  var db = FirebaseFirestore.instance;
  final UnitsOfMeasurementDB = db.collection("UnitsOfMeasurement");
  List<String> uoM=[];

  final ref = UnitsOfMeasurementDB.withConverter(fromFirestore: UnitsOfMeasurement.fromFirestore,
    toFirestore: (UnitsOfMeasurement  unitsOfMeasurement, _) => unitsOfMeasurement.toFirestore(),);
  final docSnap = await ref.get();
  final unitsOfMeasurement = docSnap.docs;
  if(unitsOfMeasurement != null)
  {
    for (var item in unitsOfMeasurement)
    {
      uoM.add(item.get("name"));
    }
  }

  return uoM;
}
