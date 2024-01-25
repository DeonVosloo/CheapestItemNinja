import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class TestingPage extends StatefulWidget {
  const TestingPage({super.key});

  @override
  State<TestingPage> createState() => _TestingPageState();
}

class _TestingPageState extends State<TestingPage> {
  final TextEditingController _textController1 = TextEditingController();
  final TextEditingController _textController2 = TextEditingController();
  final TextEditingController _textController3 = TextEditingController();
  //List<Row> testList = [];
  @override
  Widget build(BuildContext context) {
     var db = FirebaseFirestore.instance;
    // final docRef = db.collection("test").doc("8dPYnFecIBSQqgWSJHDU");
    // docRef.snapshots().listen(
    //       (event) => print("current data: ${event.data()}"),
    //   onError: (error) => print("Listen failed: $error"),
    // );

    final cities = db.collection('cities');
     final data1 = <String, dynamic>{
       "name": "San Francisco",
       "state": "CA",
       "country": "USA",
       "capital": false,
       "population": 860000,
       "regions": ["west_coast", "norcal"]
     };
     cities.doc("SF").set(data1);

     final data2 = <String, dynamic>{
       "name": "Los Angeles",
       "state": "CA",
       "country": "USA",
       "capital": false,
       "population": 3900000,
       "regions": ["west_coast", "socal"],
     };
     cities.doc("LA").set(data2);

     final data3 = <String, dynamic>{
       "name": "Washington D.C.",
       "state": null,
       "country": "USA",
       "capital": true,
       "population": 680000,
       "regions": ["east_coast"]
     };
     cities.doc("DC").set(data3);

     final data4 = <String, dynamic>{
       "name": "Tokyo",
       "state": null,
       "country": "Japan",
       "capital": true,
       "population": 9000000,
       "regions": ["kanto", "honshu"]
     };
     cities.doc("TOK").set(data4);

     final data5 = <String, dynamic>{
       "name": "Beijing",
       "state": null,
       "country": "China",
       "capital": true,
       "population": 21500000,
       "regions": ["jingjinji", "hebei"],
     };
     cities.doc("BJ").set(data5);


    return Scaffold
      (
      appBar: AppBar(title: Text("Testing Firebase"),
      backgroundColor: Colors.blueAccent,),
      body: ListView
        (
        children: [
          TextFormField
            (
            controller: _textController1,
            decoration: const InputDecoration(hintText: "Testing data"),
          ),

          ElevatedButton(onPressed: ()
          {
            final docRef = db.collection("cities").doc("VSKGTEA6X1UOpEJFY0YZ ");
            docRef.get().then(
                  (DocumentSnapshot doc) {
                final data = doc.data() as Map<String, dynamic>;
                // ...
              },
              onError: (e) => print("Error getting document: $e"),
            );
          },
              child: const Text("Add test data"))




          // StreamBuilder<QuerySnapshot>
          //   (
          //     stream: FirebaseFirestore.instance.collection('test').snapshots(),
          //     builder: (context,snapshot)
          //     {
          //       List<Row> clientWidgets =[];
          //
          //       if(snapshot.hasData)
          //         {
          //           final clients = snapshot.data?.docs.reversed.toList();
          //           for(var client in clients!)
          //             {
          //               final clientWidget = Row
          //                 (
          //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                 children: [
          //                   Text(client['testing'])
          //                 ],
          //               );
          //               clientWidgets.add(clientWidget);
          //             }
          //         }
          //
          //       return Expanded
          //         (
          //           child: ListView
          //             (
          //             children: clientWidgets,
          //           )
          //       );
          //     }
          // )
        ],
      ),
    );
  }
}


