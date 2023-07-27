import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:warak_admin/HomeScreen.dart';

class addCategorie extends StatefulWidget {
  const addCategorie({super.key});

  @override
  State<addCategorie> createState() => _addCategorieState();
}

class _addCategorieState extends State<addCategorie> {
      final categoryName= TextEditingController();
    final _formKey = GlobalKey<FormState>();


  File? categorieImage;
  UploadTask? uploadTask;

  
   Future pickimage() async {
    try {
      final categorieImage =
          await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 85);
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
  Future addNewCategorie() async {
        var docauth = db.collection("categories").doc();
       final path = 'categories/${docauth.id}';
      final file = File(categorieImage!.path);

      final ref = FirebaseStorage.instance.ref().child(path);
      uploadTask = ref.putFile(file);

      final snapshot = await uploadTask!.whenComplete(() => {});

      final catepic = await snapshot.ref.getDownloadURL();
      print(
          "bookThumnail /////////////////////////////////////////////////////////////////////");
      print(catepic);




    docauth.set({
      "categoryID":docauth.id,
      "categoryName" : categoryName.text,
      "categoryIcon":catepic,
    }).onError((e, _) => print("Error writing document /////////////////////////////////////////////: $e"));
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
        appBar: AppBar(
        elevation: 0,
        title: Text("Add New Category"),
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
                        return 'Please enter the Categorie Name';
                      }
                      return null;
                    },
                    controller: categoryName,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter the Categorie Name",
                    ),
                  ),
                ),
                
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: ElevatedButton(
                    onPressed: () => pickimage(),
                    child: const Text('Select Picture of the Categorie'),
                  ),
                ),
              

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: ElevatedButton(
                     onPressed: () => {
                      if (_formKey.currentState!.validate()) {addNewCategorie(),
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