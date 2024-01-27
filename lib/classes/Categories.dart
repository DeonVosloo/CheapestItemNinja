import 'dart:convert';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:encrypt/encrypt.dart';

class Categories
{
  String name;


  Categories({required this.name,});

  factory Categories.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return Categories(
      name: data?['name'],

    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
    };
  }


}
