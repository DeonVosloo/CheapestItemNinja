import 'package:cheapest_item_ninja/classes/ActiveProduct.dart';
import 'package:cheapest_item_ninja/classes/Categories.dart';
import 'package:cheapest_item_ninja/classes/Products.dart';
import 'package:cheapest_item_ninja/pages/Home.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../classes/Users.dart';

List<Categories> categories=[];
double convertedUnits=0;
String? selectedCategory ="not selected";
String? selectUnitOfMeasurement;
TextEditingController unitOfMeasurementController = TextEditingController();
bool validNewUser= true;

class RegisterUser extends StatefulWidget {
  const RegisterUser({super.key});

  @override
  State<RegisterUser> createState() => _AddProductState();

}

class _AddProductState extends State<RegisterUser> {
  @override
  Widget build(BuildContext context) {

    TextEditingController usernameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController1 = TextEditingController();
    TextEditingController passwordController2 = TextEditingController();


    return Scaffold
      (
        appBar:AppBar
          (
          //titleTextStyle: GoogleFonts.bebasNeue(fontSize: 36),
          title: FittedBox
            (
            fit: BoxFit.scaleDown,
            child: Text("User Registration",style: GoogleFonts.bebasNeue(fontSize: 36, color: Colors.black),),
          ),
          backgroundColor: Colors.greenAccent[400],
        ),

        body:  Container
          (
            decoration: const BoxDecoration
              (

              image: DecorationImage
                (
                  image:  AssetImage("assets/background.jpg"),
                  fit: BoxFit.fill
              ),
            ),

            child: ListView
              (
              children: [
                Column
                  (

                  children: [
                     SizedBox(height: MediaQuery.of(context).size.height * 0.08,),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.90,
                      decoration: BoxDecoration
                        (
                        border: Border.all
                          (
                            width:  MediaQuery.of(context).size.width*0.002,
                          style: BorderStyle.solid,
                          color: Colors.greenAccent
                        ),
                        borderRadius: const BorderRadius.all(Radius.circular(25)),
                        color: Colors.white
                      ),
                      child: Column
                        (
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: MediaQuery.of(context).size.height * 0.04,),
                          FittedBox
                            (
                            fit: BoxFit.contain,
                            child: Text(
                              "user Registration",
                              style: GoogleFonts.bebasNeue(
                                  fontSize: 32,
                                  color: Colors.black),),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.002,),


                          SizedBox(height: MediaQuery.of(context).size.height * 0.001,),

                              Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      MediaQuery.of(context).size.width *0.08,
                                      0,
                                      MediaQuery.of(context).size.width *0.08,
                                      0),
                                child: TextField
                                  (
                                  controller: usernameController,
                                  decoration: InputDecoration
                                    (
                                    labelText: "Enter username",
                                    labelStyle: GoogleFonts.ubuntu(fontSize: 24),
                                  ),
                                  style: GoogleFonts.ubuntu
                                    (
                                    fontSize: 24,
                                  ),
                                ),
                              ),

                          SizedBox(height: MediaQuery.of(context).size.height * 0.01,),

                          Padding(
                            padding: EdgeInsets.fromLTRB(
                                MediaQuery.of(context).size.width *0.08,
                                0,
                                MediaQuery.of(context).size.width *0.08,
                                0),
                            child: TextField
                              (
                              controller: emailController,
                              decoration: InputDecoration
                                (
                                labelText: "Enter email",
                                labelStyle: GoogleFonts.ubuntu(fontSize: 24),
                              ),
                              style: GoogleFonts.ubuntu
                                (
                                fontSize: 24,
                              ),

                            ),
                          ),

                          SizedBox(height: MediaQuery.of(context).size.height * 0.03,),

                          Padding(
                            padding: EdgeInsets.fromLTRB(
                                MediaQuery.of(context).size.width *0.08,
                                0,
                                MediaQuery.of(context).size.width *0.08,
                                0),
                            child: TextField
                              (
                              obscureText: true,
                              controller: passwordController1,
                              decoration: InputDecoration
                                (
                                labelText: "Enter password",
                                labelStyle: GoogleFonts.ubuntu(fontSize: 24),
                              ),
                              style: GoogleFonts.ubuntu
                                (
                                fontSize: 24,
                              ),
                            ),
                          ),

                          SizedBox(height: MediaQuery.of(context).size.height * 0.01,),

                          Padding(
                            padding: EdgeInsets.fromLTRB(
                                MediaQuery.of(context).size.width *0.08,
                                0,
                                MediaQuery.of(context).size.width *0.08,
                                0),
                            child: TextField
                              (
                              controller: passwordController2,
                              enabled: true,
                              obscureText: true,
                              decoration: InputDecoration
                                (
                                labelText: "Enter password again",
                                labelStyle: GoogleFonts.ubuntu(fontSize: 24),
                              ),
                              style: GoogleFonts.ubuntu
                                (
                                fontSize: 24,
                              ),
                            ),
                          ),

                          SizedBox(height: MediaQuery.of(context).size.height * 0.04,),

                          SizedBox
                            (
                            width: MediaQuery.of(context).size.width * 0.55,
                            child: ElevatedButton
                              (
                              onPressed: (){
                                // addProductToDB(widget.barcode, selectedCategory as String,
                                // productNameController.text, double.parse(unitsController.text), double.parse(priceController.text)
                                // , widget.currentUser.id);

                                if(passwordController1.text == passwordController2.text)
                                  {
                                    Users user = Users(id: "", username: usernameController.text
                                        , email: emailController.text, password: passwordController1.text);
                                    if(user.checkValidEmail(user.email) == true)
                                      {
                                        registerNewUser(user);
                                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> HomeScreen(user: user,)));
                                      }
                                    else
                                    {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text("Error"),
                                            content: const Text("No valid email provided."),
                                            actions: [
                                              TextButton(
                                                child: const Text("OK"),
                                                onPressed: () { },
                                              )
                                            ],
                                          );
                                        },
                                      );
                                    }

                                  }
                                else
                                {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text("Error"),
                                        content: const Text("Passwords do not match."),
                                        actions: [
                                          TextButton(
                                          child: const Text("OK"),
                                          onPressed: () { },
                                          )
                                        ],
                                      );
                                    },
                                  );
                                }

                              },

                              style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.greenAccent),),
                              child:
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text("Add Product",
                                  style: GoogleFonts.bebasNeue(fontSize: 36, color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.08,),
                        ],
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.08,),

                  ],
                ),
              ],
            )
        ),

    );
  }
}

void registerNewUser
    (Users user) async
{

  user.password = user.encryptPassword(user.password);

  var db = FirebaseFirestore.instance;
  final userRef = db.collection('Users');
  final userQueryUsername = userRef.where("username", isEqualTo: user.username).limit(1);
  final userQueryEmail = userRef.where("email", isEqualTo: user.email).limit(1);
  String? userDocID;

  validNewUser=true;
  userRef.doc().set(user.toFirestore());


}




