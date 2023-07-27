import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:warak_admin/HomeScreen.dart';
import 'package:warak_admin/screens/OrderElectronicDetails.dart';
import 'package:warak_admin/screens/OrderSubs.dart';
import 'package:warak_admin/screens/OrdersElectrinoque.dart';

class OrderSubsDetails extends StatelessWidget {
  var detail;
  OrderSubsDetails({super.key, @required this.detail});

  // const OrderDetails({super.key});

  var db = FirebaseFirestore.instance;
  // Timestamp  date =  detail['orderDate'];
  // DateTime myDateTime = DateTime.parse(detail['orderDate'].toDate().toString());

  var bookCategory = TextEditingController();
  // var ed = detail[""];
  bool confirm = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Subscription Details'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(7.0),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'First Name : ${detail['orderClientFirstName']}',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              // Text(detail['orderDate']),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Last Name : ${detail['orderClientLastName']}',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Email : ${detail['orderClientEmail']}',
                  style: TextStyle(fontSize: 18),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Phone Number : ${detail['orderPhoneNumber']}',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Center(
                    child: Text(
                      'Order Date : ${DateTime.parse(detail['orderDate'].toDate().toString())}',
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                  // Image.network(detail['orderProofImageURL'] , ),
                  ),

              Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Center(
                  child: Text(
                    'Order Price : ${detail['orderPrice']}',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                // Image.network(detail['orderProofImageURL'] , ),
              ),

              Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Center(
                    child: Image.network('${detail['orderProofImageURL']}',
                        width: 400,
                        height: 400,
                         errorBuilder: (BuildContext context,
                            Object exception, StackTrace? stackTrace) {
                      return Image.network(
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRxFLlzVp2jEn2Kx38_HsZiHYKtBJtQxxTg810DIpZS&s");
                    }),
                  )
              ),

              Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: ElevatedButton(
                  onPressed: () {
                    print("object");
                    print("object//////////////////////////");

                    print(detail['orderID']);

                    var docauth = db
                        .collection("orderMaxSubscriptions")
                        .doc(detail['orderID']);
                    confirm = true;
                    docauth.update({
                      // "authorID" : docauth.id,
                      // "authorName": bookAuthorName.text,
                      "orderPayed?": confirm,
                    }).onError((e, _) => print(
                        "Error writing document /////////////////////////////////////////////: $e"));

                    var doc =
                        db.collection("users").doc(detail['orderClientID']);
                    doc.update({
                      // "authorID" : docauth.id,
                      // "authorName": bookAuthorName.text,
                      "userIsSubbed": true,
                    }).onError((e, _) => print(
                        "Error writing document /////////////////////////////////////////////: $e"));

                    final DateTime dateTime = new DateTime.now();
                    var newDate = new DateTime(dateTime.year, dateTime.month + 1, dateTime.day);
                    doc.update({
                      "userSubEndingingDay": newDate,
                      "userSubStartingDay": dateTime,
                    }).onError((e, _) => print(
                        "Error writing document /////////////////////////////////////////////: $e"));

                    Navigator.of(context).pop();
                  },
                  child: Text('Confirmm'),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
