import 'dart:typed_data';
import 'package:cheapest_item_ninja/classes/Users.dart';
import 'package:cheapest_item_ninja/pages/AddProduct.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:flutter/material.dart';

import '../classes/Categories.dart';

List<Categories> categories= [];
class BarcodeScanner extends StatefulWidget {
  final Users user;
   const BarcodeScanner({super.key, required this.user});

  @override
  State<BarcodeScanner> createState() => _BarcodeScannerState();
}

class _BarcodeScannerState extends State<BarcodeScanner> {
  MobileScannerController cameraController = MobileScannerController();


   @override
   Widget build(BuildContext context) {
     setCategories();
     return Scaffold(
       appBar: AppBar(title: const Text('Mobile Scanner')),
       body: MobileScanner(
         fit: BoxFit.contain,
         controller: MobileScannerController(

            facing: CameraFacing.back,
            torchEnabled: false,
           returnImage: true,
           detectionSpeed: DetectionSpeed.noDuplicates,
         ),
         onDetect: (capture) {
           final List<Barcode> barcodes = capture.barcodes;
           final Uint8List? image = capture.image;
           for (final barcode in barcodes) {
             debugPrint('Barcode found! ${barcode.rawValue}');

           }
           if (image != null) {
             showDialog(
               context: context,
               barrierLabel: "Barcode found: ${barcodes.first.rawValue}",
               barrierColor: Colors.red,
               builder: (context) =>
                   Image(image: MemoryImage(image)),
             );
             Future.delayed(const Duration(seconds: 1), () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> AddProduct(barcode: barcodes.first.rawValue,
                currentUser: widget.user,
                categoriesReceived: categories,)));
             });
           }
         },
       ),
     );
   }
}

void setCategories()
async {
  var db = FirebaseFirestore.instance;
  final categoriesDB = db.collection("Categories");
  List<Categories> categoriesFinal=[];
  List<String> categoryNamesTemp=[];
  List<String> categoryUoMTemp=[];

  final ref = categoriesDB.withConverter(fromFirestore: Categories.fromFirestore,
    toFirestore: (Categories categories, _) => categories.toFirestore(),);
  final docSnap = await ref.get();
  final tempCategories = docSnap.docs;
  for (var item in tempCategories)
  {
    categoriesFinal.add(item.data());
    categoryNamesTemp.add(item.data().name);
    categoryUoMTemp.add(item.data().unitOfMeasurement);
  }
  categories = categoriesFinal;
}