import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:warak_admin/HomeScreen.dart';
import 'package:warak_admin/screens/OrderWaraqi.dart';

class OrderWaraqiDetails extends StatelessWidget {
  var test;
  OrderWaraqiDetails({super.key, @required this.test});

  // const OrderDetails({super.key});

  var db = FirebaseFirestore.instance;
  bool confirm = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Waraqi Details '),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical:25.0),
            child: Column(children: [
              Text('Book Title : ${test['orderBookTitle']}', style: TextStyle(fontSize: 18),),
              // order3onwan
                  Text("First Name : ${test['orderClientFirstName']}", style: TextStyle(fontSize: 18)),
              Text("Last Name : ${test['orderClientLastName']}", style: TextStyle(fontSize: 18)),
                 Text("Email : ${test['orderClientEmail']}", style: TextStyle(fontSize: 18)),
        
                 Text("Wilaya : ${test['orderWilaya']}", style: TextStyle(fontSize: 18)),
                  Text("Baladiya : ${test['orderBaladiya']}", style: TextStyle(fontSize: 18)),
          
                      Text("Address : ${test['order3onwan']}", style: TextStyle(fontSize: 18)),
                            Text("Price : ${test['orderPrice']}", style: TextStyle(fontSize: 18)),
              Text("Phone : ${test['orderPhoneNumber']}", style: TextStyle(fontSize: 18)), 
               Text(
                      'Order Date : ${DateTime.parse(test['orderDate'].toDate().toString())}', style: TextStyle(fontSize: 18),),
              // Text(test['orderID']),
              // orderDate
           
              // Text(test['orderDate']),
        
              // Padding(
              //     padding: EdgeInsets.symmetric(vertical: 15),
              //     child: Center(
              //       child: Image.network('${test['orderProofImageURL']}'),
              //     )
              //     // Image.network(test['orderProofImageURL'] , ),
              //     ),

                    Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Center(
                  child: Image.network('${test['orderProofImageURL']}',
                      width: 300,
                      height: 300,
                       errorBuilder: (BuildContext context,
                          Object exception, StackTrace? stackTrace) {
                    return Image.network(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRxFLlzVp2jEn2Kx38_HsZiHYKtBJtQxxTg810DIpZS&s");
                  }),
                )
                // Image.network(detail['orderProofImageURL'] , ),
                ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: ElevatedButton(
                  onPressed: () {
                    print("object");
                    print("object//////////////////////////");
        
                    print(test['orderID']);
        
                    var docauth =
                        db.collection("ordersPhysical").doc(test['orderID']);
                    confirm = true;
                    docauth.update({
                      // "authorID" : docauth.id,
                      // "authorName": bookAuthorName.text,
                      "orderPayed?": confirm,
                    }).onError((e, _) => print(
                        "Error writing document /////////////////////////////////////////////: $e"));
                    //     Navigator.pushAndRemoveUntil(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => HomeScreen()),
                    //   (Route<dynamic> route) => false,
                    // );
                     
    Navigator.of(context).pop();
                  },
                  child: Text('Confirmm'),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
