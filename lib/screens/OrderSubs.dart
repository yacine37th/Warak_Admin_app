import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:warak_admin/screens/OrderElectronicDetails.dart';
import 'package:warak_admin/screens/OrderSubsDetails.dart';
import 'package:warak_admin/screens/OrdersElectrinoque.dart';

class OrderSubs extends StatefulWidget {
  const OrderSubs({super.key});

  @override
  State<OrderSubs> createState() => _OrderSubsState();
}

class _OrderSubsState extends State<OrderSubs> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('orderMaxSubscriptions')
      .where('orderPayed?', isEqualTo: false)
      // .orderBy('orderDate',descending: true)
      // .orderBy("orderDate",descending: true)
      // .orderBy("orderID")
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Subscription Orders"),
      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
            stream: _usersStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      backgroundColor: const Color.fromARGB(255, 0, 68, 124),
                    )
                  ],
                );
                // Text('${snapshot.connectionState}');
              }

              if (!snapshot.hasData) {
                return Center(child: Text('No Order',style: TextStyle(fontSize: 25),));
              }
              return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: ListTile(
                        trailing: Icon(Icons.keyboard_arrow_right),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      OrderSubsDetails(detail: data)));
                        },
                        title: Text(data['orderClientEmail']),
                        subtitle: Text(data['orderPhoneNumber']),
                      ),
                    ),
                  );
                }).toList(),
              );
            }),
      ),
    );
  }
}
