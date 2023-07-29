import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:warak_admin/screens/OrdersElectrinoque.dart';

class OrderElectronicDetails extends StatelessWidget {
  var test;
  OrderElectronicDetails({super.key, @required this.test});

  // const OrderDetails({super.key});

  var db = FirebaseFirestore.instance;
  // Timestamp  date =  test['orderDate'];
  // DateTime myDateTime = DateTime.parse(test['orderDate'].toDate().toString());

  var bookCategory = TextEditingController();

  bool confirm = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Electronique Details'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Title : ${test['orderBookTitle']}",
                  style: TextStyle(fontSize: 18)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  'Order Client First Name : ${test['orderClientFirstName']}',
                  style: TextStyle(fontSize: 18)),
            ),
            // Text(test['orderDate']),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  'Order Client Last Name : ${test['orderClientLastName']}',
                  style: TextStyle(fontSize: 18)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Order Client Email : ${test['orderClientEmail']}',
                  style: TextStyle(fontSize: 18)),
            ),

            Padding(
                padding: EdgeInsets.symmetric(vertical: 18),
                child: Center(
                  child: Text(
                      'Order Date : ${DateTime.parse(test['orderDate'].toDate().toString())}',
                      style: TextStyle(fontSize: 18)),
                )
                // Image.network(test['orderProofImageURL'] , ),
                ),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 18),
                child: Center(
                  child: Text('Price: ${test['orderPrice']}',
                      style: TextStyle(fontSize: 18)),
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Order Phone Number : ${test['orderPhoneNumber']}',
                  style: TextStyle(fontSize: 18)),
            ),

            // Padding(
            //     padding: EdgeInsets.symmetric(vertical: 18),
            //     child: Center(
            //       child: Image.network('${test['orderProofImageURL']}'),
            //     )),

            Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Center(
                  child: Image.network('${test['orderProofImageURL']}',
                      width: 300,
                      height: 300, errorBuilder: (BuildContext context,
                          Object exception, StackTrace? stackTrace) {
                    return Image.network(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRxFLlzVp2jEn2Kx38_HsZiHYKtBJtQxxTg810DIpZS&s");
                  }),
                )
                // Image.network(detail['orderProofImageURL'] , ),
                ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 18),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromRGBO(32, 48, 61, 1))),
                    onPressed: () {
                      print("object");
                      print("object//////////////////////////");

                      print(test['orderID']);

                      var docauth = db
                          .collection("ordersElectronic")
                          .doc(test['orderID']);
                      confirm = true;
                      docauth.update({
                        // "authorID" : docauth.id,
                        // "authorName": bookAuthorName.text,
                        "orderPayed?": confirm,
                      }).onError((e, _) => print(
                          "Error writing document /////////////////////////////////////////////: $e"));

                      var doc =
                          db.collection("users").doc(test['orderClientID']);
                      doc.update({
                        // "authorID" : docauth.id,
                        // "authorName": bookAuthorName.text,
                        "userMaktabati":
                            FieldValue.arrayUnion([test["orderBookID"]]),
                      }).onError((e, _) => print(
                          "Error writing document /////////////////////////////////////////////: $e"));
                      doc.update({
                        // "authorID" : docauth.id,
                        // "authorName": bookAuthorName.text,
                        "userOrdersElectronicBooks":
                            FieldValue.arrayRemove([test["orderBookID"]]),
                      }).onError((e, _) => print(
                          "Error writing document /////////////////////////////////////////////: $e"));
                      // Navigator.pushAndRemoveUntil(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => OrdersElectronique()),
                      //   (Route<dynamic> route) => false,
                      // );
                      Navigator.of(context).pop();
                    },
                    child: Text('Confirmm'),
                  ),
                ),
                // SizedBox(
                //   width: 25.0,
                // ),
                // Padding(
                //   padding: EdgeInsets.symmetric(vertical: 18),
                //   child: ElevatedButton(
                //     style: ButtonStyle(
                //       backgroundColor: MaterialStateProperty.all(Colors.red),
                //     ),
                //     onPressed: () {
                //       print("object");
                //       print("object//////////////////////////");

                //       print(test['orderID']);

                //       var docauth = db
                //           .collection("ordersElectronic")
                //           .doc(test['orderID']);

                //       docauth.delete().onError((e, _) => print(
                //           "Error writing document /////////////////////////////////////////////: $e"));

                //       // Navigator.pushAndRemoveUntil(
                //       //   context,
                //       //   MaterialPageRoute(
                //       //       builder: (context) => OrdersElectronique()),
                //       //   (Route<dynamic> route) => false,
                //       // );
                //       Navigator.of(context).pop();
                //     },
                //     child: Text('Delete'),
                //   ),
                // ),
           
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
