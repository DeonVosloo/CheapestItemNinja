import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget
{
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();


}

class _LoginState extends State<Login>
{
  TextEditingController usernameTextFieldController = TextEditingController();

  TextEditingController passwordTextFieldController = TextEditingController();

  @override
  Widget build(BuildContext context)
  {
    return Scaffold
      (
      body: ListView
        (
        children:
        [
          Padding
            (
            padding: const EdgeInsets.fromLTRB(1, 50, 1, 1),
            child: Column
              (
              mainAxisAlignment: MainAxisAlignment.center,
              children:
              [
                const Center
                  (
                  child: CircleAvatar
                    (
                    backgroundColor: Colors.transparent,
                    radius: 90.0,
                    backgroundImage: AssetImage('assets/thinkninjas.png'),
                  ),
                ),
                const SizedBox(height: 8,),

                Text("Item Price Comparing Ninja", style: GoogleFonts.bebasNeue(fontSize: 48, color: Colors.black,),),

                Padding
                  (
                  padding: const EdgeInsets.fromLTRB(45,1,45,1),
                  child: TextField
                    (
                    controller: usernameTextFieldController,
                    decoration: InputDecoration
                      (

                      labelText: "Enter username",
                      labelStyle: GoogleFonts.bebasNeue(fontSize: 24),
                    ),
                    style: GoogleFonts.ubuntu
                      (
                      fontSize: 24,
                    ),
                  ),
                ),

                Padding
                  (
                  padding: const EdgeInsets.fromLTRB(45,1,45,1),
                  child: TextField
                    (
                    controller: passwordTextFieldController,
                    obscureText: true,
                    decoration: InputDecoration
                      (
                      labelText: "Enter Password",
                      labelStyle: GoogleFonts.bebasNeue(fontSize: 24),
                    ),
                    style: GoogleFonts.ubuntu
                      (
                      fontSize: 24,
                    ),
                  ),
                ),

                Row
                  (
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                  [
                    Padding
                      (
                      //padding: EdgeInsets.all(1),
                      padding: const EdgeInsets.fromLTRB(15,22,15,0),
                      child: ElevatedButton
                        (
                        style: ElevatedButton.styleFrom(minimumSize: const Size(90, 30)),
                        child: Text("Login", style: GoogleFonts.ubuntu(fontSize: 20),),
                        onPressed: ()
                        {

                        },
                      ),
                    ),

                    Padding
                      (
                      //padding: EdgeInsets.all(1),
                      padding: const EdgeInsets.fromLTRB(15,22,15,0),
                      child: ElevatedButton
                        (
                        style: ElevatedButton.styleFrom(minimumSize: const Size(90, 30)),
                        child:  Text("Sign Up", style: GoogleFonts.ubuntu(fontSize: 20)),
                        onPressed: ()
                        {

                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}




