import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:warak_admin/HomeScreen.dart';
import 'package:warak_admin/model/category_model.dart';

class addBooks extends StatefulWidget {
  const addBooks({super.key});

  @override
  State<addBooks> createState() => _addBooksState();
}

class _addBooksState extends State<addBooks> {
  final authorName = TextEditingController();
  final bookTitle = TextEditingController();
  final bookCategory = TextEditingController();
  final bookAbout = TextEditingController();
  var bookPrice = TextEditingController();
  final bookPublishingHouse = TextEditingController();
  final bookAuthorName = TextEditingController();
  var category;
  var bookauthorID;
  var bookauhorName;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    authorName.dispose();
    bookTitle.dispose();
    bookCategory.dispose();
    bookAbout.dispose();
    bookPrice.dispose();
    bookPublishingHouse.dispose();
    bookAuthorName.dispose();
    super.dispose();
  }

  PlatformFile? pickFile;
  UploadTask? uploadTask;
  UploadTask? uploadTask2;
  File? categorieImage;
  File? bookImage;
  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    setState(() {
      pickFile = result.files.first;
    });
  }

  Future uploadFile() async {
    try {
      final path = 'test/${pickFile!.name}';
      final file = File(pickFile!.path!);

      final ref = FirebaseStorage.instance.ref().child(path);
      uploadTask = ref.putFile(file);

      final snapshot = await uploadTask!.whenComplete(() => {});

      final bookURL = await snapshot.ref.getDownloadURL();
      print(
          "bookURL /////////////////////////////////////////////////////////////////////");
      print(bookURL);
      return bookURL;
    } on PlatformException catch (e) {
      print(e);
    }
  }

  Future pickimage() async {
    try {
      final bookImage = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 85);
      if (bookImage == null) return;
      final imageTemp = File(bookImage.path);
      setState(() {
        this.bookImage = imageTemp;
      });
      print("//////////////////image/////////////////");
      print(bookImage.name);
    } on PlatformException catch (e) {
      print(e);
    }
  }

  Future pickimage2() async {
    try {
      final categorieImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (categorieImage == null) return;
      final imageTemp = File(categorieImage.path);
      setState(() {
        this.bookImage = imageTemp;
      });
      print("//////////////////image/////////////////");
      print(categorieImage.name);
    } on PlatformException catch (e) {
      print(e);
    }
  }

  Future uploadImage() async {
    try {
      final path = 'test/BookPicture';
      final file = File(bookImage!.path);

      final ref = FirebaseStorage.instance.ref().child(path);
      uploadTask = ref.putFile(file);

      final snapshot = await uploadTask!.whenComplete(() => {});

      final bookThumnail = await snapshot.ref.getDownloadURL();
      print(
          "bookThumnail /////////////////////////////////////////////////////////////////////");
      print(bookThumnail);
    } on PlatformException catch (e) {
      print(e);
    }
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

  var db = FirebaseFirestore.instance;
  Future createBook(
      //   {
      //   required String authorName,
      //   required String bookTitle,
      //   required String bookCategory,
      //   required String bookAbout,
      // }
      ) async {
    // Upload Book url
    var doc = db.collection("books").doc();
    var docauth = db.collection("authors").doc(_selectedValueAuth['id']);

    final path = 'books/${pickFile!.name}';
    final file = File(pickFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file);

    final snapshot = await uploadTask!.whenComplete(() => {});

    final bookURL = await snapshot.ref.getDownloadURL();
    print(
        "urlDowload /////////////////////////////////////////////////////////////////////");
    print(bookURL);
    // final bookURL = uploadFile();
    // ///////////////////////////////
    // ///upload book image
    final path2 = 'books/${doc.id}';
    final file2 = File(bookImage!.path);

    final ref2 = FirebaseStorage.instance.ref().child(path2);
    uploadTask2 = ref2.putFile(file2);

    final snapshot2 = await uploadTask2!.whenComplete(() => {});

    final bookThumnail = await snapshot2.ref.getDownloadURL();
    print(
        "bookThumnail /////////////////////////////////////////////////////////////////////");
    print(bookThumnail);

    print("///////////////////////befor////////////////////////////////");
    print("edede");

    // var carousel =  db.collection("carousel").doc();
    doc.set({
      "bookKeyWords": keyWordsMaker(bookTitle.text),
      "bookAuthorName": _selectedValueAuth['name'],
      "bookDateAdded": FieldValue.serverTimestamp(),
      "bookCategoryID": _selectedValue['id'],
      "bookId": doc.id,
      "bookAuthorID": _selectedValueAuth['id'],
      "bookAbout": bookAbout.text,
      "bookPrice": double.parse(bookPrice.text),
      "bookTitle": bookTitle.text,
      "bookURL": bookURL,
      "bookThumnail": bookThumnail,
      "bookCategory": _selectedValue['name'],
      "bookRatings": 0,
      "bookReads": 0,
      "bookPublishingHouse": bookPublishingHouse.text,
    }).onError((e, _) => print(
        "Error writing document /////////////////////////////////////////////: $e"));

    docauth.update({
      // "authorID" : docauth.id,
      // "authorName": bookAuthorName.text,
      "authorBooks": FieldValue.arrayUnion([doc.id]),
    }).onError((e, _) => print(
        "Error writing document /////////////////////////////////////////////: $e"));
  }

// static test fromJson (Map<String , dynamic> json ) =>test (
//   categoryName : json["categoryName"],
// )

//   Stream<List<test>> readCategories ()=> FirebaseFirestore.instance.collection("categories").snapshots().map(
//     (snap) => snap.docs.map((doc) => doc.data()).toList()
//     );

  Map<String, CategoryModel> categories = {};

  List categorieList = [];
  Future getCate() async {
    await FirebaseFirestore.instance
        .collection("categories")
        .get()
        .then((value) async {
      for (int index = 0; index < value.docs.length; index++) {
        setState(() {
          categorieList.add({
            "name": value.docs[index]["categoryName"],
            "id": value.docs[index].id,
          });
        });
      }
    });
  }

  List authorList = [];
  Future getauthors() async {
    await FirebaseFirestore.instance
        .collection("authors")
        .get()
        .then((value) async {
      for (int index = 0; index < value.docs.length; index++) {
        setState(() {
          authorList.add({
            "name": value.docs[index]["authorName"],
            "id": value.docs[index].id,
          });
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();

    getCate();
    getauthors();
  }

  var _selectedValue;

  var _selectedValueAuth;
  List<String> listOfValue = ['1', '2', '3', '4', '5'];
  List listUserType = [
    {'name': 'Individual', 'value': 'individual'},
    {'name': 'Company', 'value': 'company'}
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Add New Book"),
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
                          vertical: 10, horizontal: 30),
                      child: DropdownButtonFormField(
                          value: _selectedValue,
                          hint: Text('choose the Category of the book'),
                          isExpanded: true,
                          onChanged: (value) {
                            setState(() {
                              _selectedValue = value;
                            });
                          },
                          onSaved: (value) {
                            setState(() {
                              _selectedValue = value;
                            });
                          },
                          validator: (value) =>
                              value == null ? 'Select the Category of the book' : null,
                          items: categorieList.map((category) {
                            return DropdownMenuItem(
                              child: Text(category["name"]),
                              value: category,
                            );
                          }).toList())),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 30),
                    child: TextFormField(
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the Title of the Book';
                        }
                        return null;
                      },
                      controller: bookTitle,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter the Title of the Book",
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 30),
                      child: DropdownButtonFormField(
                          value: _selectedValueAuth,
                          hint: Text('choose the Author of the book'),
                          isExpanded: true,
                           validator: (value) =>
                              value == null ? 'Select the Author of the book' : null,
                          onChanged: (value) {
                            setState(() {
                              _selectedValueAuth = value;
                            });
                          },
                          onSaved: (value) {
                            setState(() {
                              _selectedValueAuth = value;
                            });
                          },
                          items: authorList.map((category) {
                            return DropdownMenuItem(
                              child: Text(category["name"]),
                              value: category,
                            );
                          }).toList())),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 30),
                    child: TextFormField(
                      minLines: 3,
                      maxLines: 8,
                      keyboardType: TextInputType.multiline,
                      controller: bookAbout,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the Descrption of the Book';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(),
                        hintText: "Enter the Descrption of the Book",
                        // labelText: 'Enter text',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 30),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the Price of the Book';
                        }
                        return null;
                      },
                      controller: bookPrice,
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(),
                        hintText: "Enter the Price of the Book",
                        // labelText: 'Enter text',
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the publisher house';
                        }
                        return null;
                      },
                      controller: bookPublishingHouse,
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(),
                        hintText: "Enter the publisher house",
                        // labelText: 'Enter text',
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: ElevatedButton(
                       style: ButtonStyle(
                  backgroundColor:  MaterialStateProperty.all(Color.fromRGBO(32, 48, 61, 1))
                  
                  ),
                      onPressed: () => pickimage(),
                      child: const Text('Select Picture of the book'),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: ElevatedButton(
                       style: ButtonStyle(
                  backgroundColor:  MaterialStateProperty.all(Color.fromRGBO(32, 48, 61, 1))
                  
                  ),
                      onPressed: selectFile,
                      child: const Text('Select File'),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: ElevatedButton(
                       style: ButtonStyle(
                  backgroundColor:  MaterialStateProperty.all(Color.fromRGBO(32, 48, 61, 1))
                  
                  ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          createBook();
                           Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                    (Route<dynamic> route) => false,
                  );
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
      ),
    );
  }
}
