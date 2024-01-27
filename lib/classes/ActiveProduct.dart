import 'package:cheapest_item_ninja/classes/Products.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ActiveProduct extends Products {
  bool isActive;

  ActiveProduct({required super.id, required super.price,
    required super.pricePerUnitOfMeasurement,
    required super.category, required super.name,
    required super.units, required super.unitOfMeasurement,
    required super.barcode, required this.isActive,
    required super.userID});

  factory ActiveProduct.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,) {
    final data = snapshot.data();
    return ActiveProduct(
      id: data?['id'],
      category: data?['category'],
      name: data?['name'],
      units: data?['units'],
      unitOfMeasurement: data?['unitOfMeasurement'],
      price: data?['price'],
      pricePerUnitOfMeasurement: data?['pricePerUnitOfMeasurement'],
      barcode: data?['barcode'],
      userID: data?['userID'],
      isActive: data?['isActive'],
    );
  }

  @override
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
      "isActive": isActive,
    };
  }
}