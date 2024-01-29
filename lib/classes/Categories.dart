import 'package:cloud_firestore/cloud_firestore.dart';

class Categories
{
  String name;
  String unitOfMeasurement;


  Categories({required this.name, required this.unitOfMeasurement});

  factory Categories.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return Categories(
      name: data?['name'],
      unitOfMeasurement: data?['unitOfMeasurement']

    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "name": name,
      "unitOfMeasurement": unitOfMeasurement,
    };
  }


}
