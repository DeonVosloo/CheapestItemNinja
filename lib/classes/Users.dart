import 'dart:convert';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:encrypt/encrypt.dart';

class Users
{
  String? id;
  String username;
  String password;
  String email;


  Users({required this.id,required this.username, required this.email, required this.password});

  factory Users.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return Users(
      id: data?['id'],
      username: data?['username'],
      password: data?['password'],
      email: data?['email'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (id != null) "id": id,
      if (username != null) "username": username,
      if (password != null) "password": password,
      if (email != null) "email": email,
    };
  }


}

String encryptPassword(String password)
{
  final key = Key.fromUtf8('awdawd245upcvkxadsklklsado777jcs');
  final iv = IV.fromLength(16);

  final encrypter = Encrypter(AES(key));

  final Encrypted encrypted = encrypter.encrypt(password, iv: iv);
  return encrypted.toString();
}

bool checkValidEmail(String email)
{
  final bool emailValid =
  RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
  return emailValid;
}