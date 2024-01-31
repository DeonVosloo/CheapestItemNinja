import 'package:cheapest_item_ninja/pages/Home.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../classes/Users.dart';
import 'RegisterUser.dart';

bool validLogin= false;
String doc="";

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();

}

class _LoginState extends State<Login> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {


    return Scaffold
      (
      appBar:AppBar
        (
        //titleTextStyle: GoogleFonts.bebasNeue(fontSize: 36),
        title: FittedBox
          (
          fit: BoxFit.scaleDown,
          child: Text("Login",style: GoogleFonts.bebasNeue(fontSize: 36, color: Colors.black),),
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
                            "user Login",
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
                            controller: passwordController,
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

                        SizedBox(height: MediaQuery.of(context).size.height * 0.04,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox
                              (
                              width: MediaQuery.of(context).size.width * 0.25,
                              child: ElevatedButton
                                (
                                onPressed: (){
                                  Users user = Users(id: "", username: usernameController.text
                                      , email: "", password: passwordController.text);

                                  loginUser(user);

                                  Future.delayed(const Duration(seconds: 2), () {
                                    if(validLogin == true)
                                    {
                                      user = getCurrentUser(user.username, user.password);
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> HomeScreen(user: user,)));
                                    }
                                    else if(validLogin == false)
                                    {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text("Error"),
                                            content: const Text("Please check username or password or try again"),
                                            actions: [
                                              TextButton(
                                                child: const Text("OK"),
                                                onPressed: () {Navigator.pop(context);},
                                              )
                                            ],
                                          );
                                        },
                                      );
                                    }
                                  });
                                },

                                style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.greenAccent),),
                                child:
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text("Login",
                                    style: GoogleFonts.bebasNeue(fontSize: 36, color: Colors.black),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox
                              (
                              width: MediaQuery.of(context).size.width * 0.25,
                              child: ElevatedButton
                                (
                                onPressed: (){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const RegisterUser()));
                                },

                                style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.greenAccent),),
                                child:
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text("Register",
                                    style: GoogleFonts.bebasNeue(fontSize: 36, color: Colors.black),
                                  ),
                                ),
                              ),
                            ),

                          ],
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

void loginUser
    (Users user) async
{
  user.password = user.encryptPassword(user.password);

  var db = FirebaseFirestore.instance;
  final userRef = db.collection('Users');
  final userQuery = userRef.where("username", isEqualTo: user.username).where("password", isEqualTo: user.password).limit(1);
  String? userDocID;


  try
  {
    userDocID = await userQuery.get().then((value) => value.docs.firstOrNull?.id);
    doc= userDocID!;
    final ref = db.collection("Users").doc(userDocID).withConverter(
      fromFirestore: Users.fromFirestore,
      toFirestore: (Users user, _) => user.toFirestore(),
    );
    final docSnap = await ref.get();
    final userTemp = docSnap.data(); //converts to users object
    if (userTemp != null)
    {
      if(user.username == userTemp.username && user.password == userTemp.password)
        {
          doc= userDocID;
          validLogin= true;
        }
      else
        {
          validLogin=false;
        }
    }
    else
    {
      validLogin=false;
    }
  }
  catch(e){}
}

Users getCurrentUser(String username, String password)
{
  Users currentUser = Users(id: doc, username: username, email: "", password: password);
  currentUser.password = currentUser.encryptPassword(password);
  return currentUser;
}