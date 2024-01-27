import 'dart:typed_data';
import 'package:cheapest_item_ninja/pages/AddProduct.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:flutter/material.dart';

class TestBarcodeScanner extends StatelessWidget {
   TestBarcodeScanner({super.key});

  MobileScannerController cameraController = MobileScannerController();


   @override
   Widget build(BuildContext context) {
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
             Future.delayed(const Duration(seconds: 3), () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> AddProduct(barcodesData: barcodes, user: null,)));
               //Navigator.pop(context,barcodes);
             });
           }
         },
       ),
     );
   }
}
