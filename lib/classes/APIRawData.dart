import 'dart:convert';
import 'Products.dart';

APIRawData apiRawDataFromJson(String str) => (json.decode(str).map((x) => APIRawData.fromJson(x)));

class APIRawData
{

  String category;
  String title;
  String description;
  String barcode;
  bool success;
  Map<String,Map<String, dynamic>> metadata;
  String brand;

  APIRawData({ required this.category, required this.title, required this.metadata,
    required this.brand, required this.description, required this.barcode, required this.success});

  Product processAPIDataToProduct ()
  {
    Product product = Product(id, price, pricePerUnitOfMeasurement, category: category, name: name, units: units, unitOfMeasurement: unitOfMeasurement, barcode: barcode)
  }

  factory APIRawData.fromJson(Map<String, dynamic> json) {
    return APIRawData(
      category: json["category"] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      barcode: json['barcode'] as String,
      success: json['success'] as bool,
      metadata: json['metadata'] as Map<String,Map<String, dynamic>>,
      brand: json['brand'] as String,
    );


}
}