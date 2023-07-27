import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:warak_admin/HomeScreen.dart';

class addAuthor extends StatefulWidget {
  const addAuthor({super.key});

  @override
  State<addAuthor> createState() => _addAuthorState();
}

class _addAuthorState extends State<addAuthor> {
  final authorName = TextEditingController();
  final authorAboutMe = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    authorName.dispose();
    authorAboutMe.dispose();
    super.dispose();
  }

  List keyWordsMaker(String text) {
    List<String> keyWordsList = [];
    String temp = "";
    for (var i = 0; i < text.length; i++) {
      if (text[i] == " ") {
        temp = "";
      } else {
        temp = temp + text[i];
        keyWordsList.add(temp);
      }
    }
    return keyWordsList;
  }

  File? categorieImage;
  UploadTask? uploadTask;

  Future pickimage() async {
    try {
      final categorieImage = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 85);
      if (categorieImage == null) return;
      final imageTemp = File(categorieImage.path);
      setState(() {
        this.categorieImage = imageTemp;
      });
      print("//////////////////image/////////////////");
      print(categorieImage.name);
    } on PlatformException catch (e) {
      print(e);
    }
  }

  var db = FirebaseFirestore.instance;
  Future addNewAuthor() async {
    var catepic = "";
        var docauth = db.collection("authors").doc();

    if (categorieImage != null) {

      final path = 'authors/${docauth.id}';
      final file = File(categorieImage!.path);

      final ref = FirebaseStorage.instance.ref().child(path);
      uploadTask = ref.putFile(file);

      final snapshot = await uploadTask!.whenComplete(() => {});

      catepic = await snapshot.ref.getDownloadURL();
      print(
          "bookThumnail /////////////////////////////////////////////////////////////////////");
      print(catepic);
    }

    docauth.set({
      "authorID": docauth.id,
      "authorName": authorName.text,
      "authorKeyWords": keyWordsMaker(authorName.text),
      "authorAboutMe": authorAboutMe.text,
      "authorImageURL": catepic,
      "authorBooks": [],
    }).onError((e, _) => print(
        "Error writing document /////////////////////////////////////////////: $e"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Add New Author"),
        // backgroundColor:  Color.fromRGBO(32, 48, 61, 1),
      ),
      body: SafeArea(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the name of the author';
                      }
                      return null;
                    },
                    controller: authorName,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter the name of the author",
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    controller: authorAboutMe,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter the description of the author",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: ElevatedButton(
                    onPressed: () => pickimage(),
                    child: const Text('Select Picture of the author'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: ElevatedButton(
                    onPressed: () => {
                      if (_formKey.currentState!.validate()) {addNewAuthor(),
                        Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                    (Route<dynamic> route) => false,
                  )
                      
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
