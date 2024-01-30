import 'package:cheapest_item_ninja/classes/Products.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

late String docID;

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

    // final products = db.collection('products');
    // Products product = Products
    //   (id: "", price: 50,
    //     pricePerUnitOfMeasurement: 100,
    //     category: "cheese", name: "Gouda", units: 500,
    //     unitOfMeasurement: "g", barcode: "6001051003884");
    //
    // final data = product.toFirestore();
    // products.doc().set(data);

    final productsRef = db.collection('Products');
    final productsQuery = productsRef.where("barcode", isEqualTo: 6001051003884).limit(1);




    return Scaffold
      (
      appBar: AppBar(title: const Text("Testing Firebase"), backgroundColor: Colors.blueAccent,),
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
            showDialog
              (
                context: context,
                builder: (BuildContext context){
                  return AlertDialog
                    (
                    title: Text("Testing"),
                    content: Text("Document ID: ${docID}"),
                  );
                }
            );
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


