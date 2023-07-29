import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warak_admin/HomeScreen.dart';

class Updatesubscription extends StatefulWidget {
  const Updatesubscription({super.key});

  @override
  State<Updatesubscription> createState() => _UpdatesubscriptionState();
}

class _UpdatesubscriptionState extends State<Updatesubscription> {
  final _formKey = GlobalKey<FormState>();
  var subscriptionPrice = TextEditingController();
  var subscriptionNewPromoPrice = TextEditingController();
  var subscriptionText = TextEditingController();

  var subscriptionProsList = TextEditingController();
  var sub = [];
  var subscriptionProsList2 = [];
  var test ;
  // var  subscriptionPrice ;
  var db = FirebaseFirestore.instance;

  Future getPromotion() async {
    var data;
    var doc = db.collection("subscription").doc("subscription");
    doc.get().then(
          (DocumentSnapshot doc) => {
            data = doc.data() as Map<String, dynamic>,
            print(data['subscriptionProsList']),
            setState(() {
              subscriptionPrice.text = data['subscriptionPrice'].toString();
              // subscriptionNewPromoPrice.text =
              //     data['subscriptionNewPromoPrice'].toString();
              sub = data['subscriptionProsList'];
              subscriptionText.text = data['subscriptionText'].toString();
            }),
            print(subscriptionPrice)
          },
          onError: (e) => print("Error getting document: $e"),
        );
  }

  Future updatePromo() async {
    subscriptionProsList2.add(test);
    if (subscriptionNewPromoPrice.text != "") {
      var data; print("first1//////////////////");
      var doc = db.collection("subscription").doc("subscription");
      if (subscriptionProsList2 == [""]) {
        print("first2///////////////////");
        doc.update({
          "subscriptionNewPromoPrice":
              double.parse(subscriptionNewPromoPrice.text),
          "subscriptionPrice": double.parse(subscriptionPrice.text),
          "subscriptionProsList": FieldValue.arrayUnion(subscriptionProsList2),
          "subscriptionText": subscriptionText.text,
        }).onError((e, _) => print(
            "Error writing document /////////////////////////////////////////////: $e"));
      } else {
        print("Second///////////////////");
        doc.update({
          "subscriptionNewPromoPrice":
              double.parse(subscriptionNewPromoPrice.text),
          "subscriptionPrice": double.parse(subscriptionPrice.text),
          // "subscriptionProsList": FieldValue.arrayUnion(subscriptionProsList2),
          "subscriptionText": subscriptionText.text,
        }).onError((e, _) => print(
            "Error writing document /////////////////////////////////////////////: $e"));
      }
    } else {
              print("Second2///////////////////");

      var data;
      var doc = db.collection("subscription").doc("subscription");
      doc.update({
        // "subscriptionNewPromoPrice":
        //     double.parse(subscriptionNewPromoPrice.text),
        "subscriptionPrice": double.parse(subscriptionPrice.text),
        // "subscriptionProsList": FieldValue.arrayUnion(subscriptionProsList2),
        "subscriptionText": subscriptionText.text
      }).onError((e, _) => print(
          "Error writing document /////////////////////////////////////////////: $e"));
    }
  }

  @override
  void initState() {
    super.initState();

    getPromotion();
    // getauthors();
  }

//     docauth.update({
  // "authorID" : docauth.id,
  // "authorName": bookAuthorName.text,
  //   "authorBooks": FieldValue.arrayUnion([doc.id]),
  // }).onError((e, _) => print(
  //     "Error writing document /////////////////////////////////////////////: $e"));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        elevation: 0,
        title: Text("Update The Subscription"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 30),
                    child: TextFormField(
                      // minLines: 3,
                      // maxLines: 8,
                      // keyboardType: TextInputType.multiline,
                      keyboardType: TextInputType.number,
                      controller: subscriptionPrice,
                      // initialValue:subscriptionPrice ,
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(),
                        hintText: "Enter the Subscription Price ",
                        labelText: 'Subscription Price',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 30),
                    child: TextFormField(
                      // minLines: 3,
                      // maxLines: 8,
                      // keyboardType: TextInputType.multiline,
                      keyboardType: TextInputType.number,
                      controller: subscriptionNewPromoPrice,
                      // initialValue:subscriptionPrice ,
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(),
                        hintText:
                            "Enter the New Price of the Subscription Promo",
                        labelText: 'Subscription Promo New Price',
                      ),
                    ),
                  ),
                  // subscriptionProsList

                  // Padding(
                  //     padding: const EdgeInsets.symmetric(
                  //         vertical: 15, horizontal: 30),
                  //     child: Column(
                  //       children: [
                  //         Text("${sub.map(
                  //           (book) => "${book}\n",
                  //         )}"),
                  //       ],
                  //     )),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(
                  //       vertical: 15, horizontal: 30),
                  //   child: TextFormField(
                  //     // minLines: 3,
                  //     // maxLines: 8,
                  //     // keyboardType: TextInputType.multiline,
                  //     controller: subscriptionProsList,
                  //     // initialValue:subscriptionPrice ,
                  //     onChanged: (value) => {
                  //       if (value != "")
                  //         {}
                  //     },
                  //     onSaved: (newValue) => {
                  //       setState(() {
                  //         test = newValue;
                  //       }),
                  //     },
                  //     decoration: InputDecoration(
                  //       alignLabelWithHint: true,
                  //       border: OutlineInputBorder(),
                  //       hintText: "Enter the Subscription ProsList",
                  //       labelText: 'Subscription ProsList',
                  //     ),
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(
                  //       vertical: 15, horizontal: 30),
                  //   child: TextFormField(
                  //     // minLines: 3,
                  //     // maxLines: 8,
                  //     // keyboardType: TextInputType.multiline,
                  //     controller: subscriptionText,
                  //     // initialValue:subscriptionPrice ,
                  //     decoration: InputDecoration(
                  //       alignLabelWithHint: true,
                  //       border: OutlineInputBorder(),
                  //       hintText: "Enter the Subscription Text",
                  //       labelText: 'Subscription Text',
                  //     ),
                  //   ),
                  // ),
          

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: ElevatedButton(
                       style: ButtonStyle(
                  backgroundColor:  MaterialStateProperty.all(Color.fromRGBO(32, 48, 61, 1))
                  
                  ),
                      onPressed: () {
                        updatePromo();
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                          (Route<dynamic> route) => false,
                        );
                        print(sub);
                      },
                      // ()=>   NewCustomCat(),
                      child: const Text('Submit'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    ;
  }
}
