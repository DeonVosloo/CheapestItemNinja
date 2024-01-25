// import 'dart:developer';
//
// import 'package:camera/camera.dart';
// import 'package:google_ml_kit/google_ml_kit.dart';
// import 'package:flutter/material.dart';
//
// import 'DetectorView.dart';
// import 'painter/BarcodeDetectorPainter.dart';
//
// class BarcodeScannerView extends StatefulWidget {
//   @override
//   State<BarcodeScannerView> createState() => _BarcodeScannerViewState();
// }
//
// class _BarcodeScannerViewState extends State<BarcodeScannerView> {
//   final BarcodeScanner _barcodeScanner = BarcodeScanner();
//   bool _canProcess = true;
//   bool _isBusy = false;
//   CustomPaint? _customPaint;
//   String? _text;
//   var _cameraLensDirection = CameraLensDirection.back;
//
//   @override
//   void dispose() {
//     _canProcess = false;
//     _barcodeScanner.close();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return DetectorView(
//       title: 'Barcode Scanner',
//       customPaint: _customPaint,
//       text: _text,
//       onImage: _processImage,
//       initialCameraLensDirection: _cameraLensDirection,
//       onCameraLensDirectionChanged: (value) => _cameraLensDirection = value,
//     );
//   }
//
//   Future<void> _processImage(InputImage inputImage) async {
//     if (!_canProcess) return;
//     if (_isBusy) return;
//     _isBusy = true;
//     setState(() {
//       _text = '';
//     });
//     final barcodes = await _barcodeScanner.processImage(inputImage);
//     if (inputImage.metadata?.size != null &&
//         inputImage.metadata?.rotation != null) {
//       const AlertDialog
//         (
//         title: Text("Test 123"),
//         content: Text('Scanning image'),
//         actions: [],
//       );
//       final painter = BarcodeDetectorPainter(
//         barcodes,
//         inputImage.metadata!.size,
//         inputImage.metadata!.rotation,
//         _cameraLensDirection,
//
//       );
//       _customPaint = CustomPaint(painter: painter);
//     } else {
//       String text = 'Barcodes found: ${barcodes.length}\n\n';
//       for (final barcode in barcodes) {
//         text += 'Barcode: ${barcode.rawValue}\n\n';
//         AlertDialog
//           (
//           title: Text("Test 123"),
//           content: Text('Barcode found! ${barcode.rawValue}'),
//           actions: [],
//         );
//       }
//       _text = text;
//       // TODO: set _customPaint to draw boundingRect on top of image
//       _customPaint = null;
//     }
//     _isBusy = false;
//     if (mounted) {
//       setState(() {});
//     }
//   }
// }
//
