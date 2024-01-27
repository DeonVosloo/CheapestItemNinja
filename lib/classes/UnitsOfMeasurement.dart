import 'dart:convert';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:encrypt/encrypt.dart';

class UnitsOfMeasurement
{
  String name;


  UnitsOfMeasurement({required this.name,});

  factory UnitsOfMeasurement.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return UnitsOfMeasurement(
      name: data?['name'],

    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
    };
  }


}