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
    final Stream<QuerySnapshot> citiesStream =
    FirebaseFirestore.instance.collection('cities').snapshots();

    var db = FirebaseFirestore.instance;

    final cities = db.collection('cities');
    final data1 = <String, dynamic>{
      "name": "San Francisco",
      "state": "CA",
      "country": "USA",
      "capital": false,
      "population": 860000,
      "regions": ["west_coast", "norcal"]
    };
    cities.doc("VSKGTEA6X1UOpEJFY0YZ").set(data1);


    return Scaffold
      (
      appBar: AppBar(title: Text("Testing Firebase"), backgroundColor: Colors.blueAccent,),
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
            // CollectionReference collReff = FirebaseFirestore.instance.collection('test');
            // collReff.add(
            //     {
            //       'testing': _textController1.text,
            //     }
            // );
          },
              child: const Text("Add test data")),


      StreamBuilder<QuerySnapshot>(
        stream: citiesStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }

          return ListView(
            shrinkWrap: true,
            children: snapshot.data!.docs
                .map((DocumentSnapshot document) {
              Map<String, dynamic> data =
              document.data()! as Map<String, dynamic>;
              return ListTile(
                title: Text(data['name']),
                subtitle: Text(data['country']),
              );
            })
                .toList()
                .cast(),
          );
        },
      ),
        ],
      ),
    );
  }
}


