import 'package:cloud_firestore/cloud_firestore.dart';

class Products
{
  String? id;
  String category;
  String name;
  double units;
  String unitOfMeasurement;
  double price;
  double pricePerUnitOfMeasurement;
  String barcode;
  String userID;

  Products({required this.id,  required this.price, required  this.pricePerUnitOfMeasurement, required this.category, required this.name,
    required this.units, required this.unitOfMeasurement, required this.barcode, required this.userID});

  factory Products.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return Products(
      id: data?['id'],
      category: data?['category'],
      name: data?['name'],
      units: data?['units'],
      unitOfMeasurement: data?['unitOfMeasurement'],
      price: data?['price'],
      pricePerUnitOfMeasurement: data?['pricePerUnitOfMeasurement'],
      barcode: data?['barcode'],
      userID: data?['userID'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (id != null) "id": id,
      "category": category,
      "name": name,
      "units": units,
      "unitOfMeasurement": unitOfMeasurement,
      "price": price,
      "pricePerUnitOfMeasurement": pricePerUnitOfMeasurement,
      "barcode": barcode,
      "userID": userID,
    };
  }

}