import 'package:cheapest_item_ninja/pages/Home.dart';
import 'package:cheapest_item_ninja/pages/login.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../classes/Users.dart';

bool validNewUser= false;
String doc="";

class RegisterUser extends StatefulWidget {
  const RegisterUser({super.key});

  @override
  State<RegisterUser> createState() => _RegisterUserState();

}

class _RegisterUserState extends State<RegisterUser> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController1 = TextEditingController();
  TextEditingController passwordController2 = TextEditingController();
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

                                if(passwordController1.text == passwordController2.text)
                                  {
                                    Users user = Users(id: "", username: usernameController.text
                                        , email: emailController.text, password: passwordController1.text);
                                    if(user.checkValidEmail(user.email) == true)
                                      {
                                        registerNewUser(user);

                                        Future.delayed(const Duration(seconds: 3), () {
                                          if(validNewUser == true)
                                          {
                                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const Login()));
                                          }
                                          else if(validNewUser == false)
                                          {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: const Text("Error"),
                                                  content: const Text("Email or username already taken"),
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
                                                onPressed: () {Navigator.pop(context);},
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
                                          onPressed: () {Navigator.pop(context);},
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
                                child: Text("Register User",
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
  String? usernameDocID;
  String? emailDocID;

  try
  {
    usernameDocID = await userQueryUsername.get().then((value) => value.docs.firstOrNull?.id);
    emailDocID = await userQueryEmail.get().then((value) => value.docs.firstOrNull?.id);
    //doc= userDocID!;
    final usernameRef = db.collection("Users").doc(usernameDocID).withConverter(
      fromFirestore: Users.fromFirestore,
      toFirestore: (Users user, _) => user.toFirestore(),
    );

    final emailRef = db.collection("Users").doc(emailDocID).withConverter(
      fromFirestore: Users.fromFirestore,
      toFirestore: (Users user, _) => user.toFirestore(),
    );

    final usernameDocSnap = await usernameRef.get();
    final emailDocSnap = await emailRef.get();
    final userTemp1 = usernameDocSnap.data();
    final userTemp2 = emailDocSnap.data();
    if (userTemp1 != null || userTemp2 !=null)
    {
      if(user.username == userTemp1!.username || user.email == userTemp2!.email)
      {
        validNewUser= false;
      }
      else
      {
        validNewUser=true;
        userRef.doc().set(user.toFirestore());
      }
    }
    else
    {
      validNewUser=true;
      userRef.doc().set(user.toFirestore());
    }
  }
  catch(e){}


}




