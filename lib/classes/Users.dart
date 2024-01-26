import 'dart:convert';
import 'dart:math';
import 'package:encrypt/encrypt.dart';

class Users
{
  int? id;
  String username;
  String password;
  String email;


  Users(this.id,{required this.username, required this.email, required this.password});



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