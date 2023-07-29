import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:warak_admin/HomeScreen.dart';

class AddNewBookcarousel extends StatefulWidget {
  const AddNewBookcarousel({super.key});

  @override
  State<AddNewBookcarousel> createState() => _AddNewBookcarouselState();
}

class _AddNewBookcarouselState extends State<AddNewBookcarousel> {
  final authorName = TextEditingController();
  final authorAboutMe = TextEditingController();
  final carouselUrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool shouldDisplay2 = false;
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
  Future addNewCarousel() async {
    var catepic = "";
      var test = db.collection("carousel").doc();
   
  
    if (categorieImage != null) {
      final path = 'carousel/${test.id}';
      final file = File(categorieImage!.path);

      final ref = FirebaseStorage.instance.ref().child(path);
      uploadTask = ref.putFile(file);

      final snapshot = await uploadTask!.whenComplete(() => {});

      catepic = await snapshot.ref.getDownloadURL();
      print(
          "bookThumnail /////////////////////////////////////////////////////////////////////");
      print(catepic);
    }

    if (shouldDisplay2 == true) {
       var docauth = db.collection("carousel").doc(
      _selectedValue["id"]
      );
      docauth.set({
        "carouselIsBook": shouldDisplay2,
        "bookID": _selectedValue["id"],
        "carouselThumbnail": catepic,
      }).onError((e, _) => print(
          "Error writing document /////////////////////////////////////////////: $e"));
    } else if(shouldDisplay2 == false) {
      print("z///////////////////////////////////////////////////////yacine");
      test.set({
        "carouselIsBook": shouldDisplay2,
        "carouselThumbnail": catepic,
        "carouselUrl": carouselUrl.text,
      }).onError((e, _) => print(
          "Error writing document /////////////////////////////////////////////: $e"));
    }
  }

  static List<String> selectedOptions = [];
  List<CheckboxListTile>? bhkOptions;
  //  bool shouldDisplay = false;

  String text = '';
  bool shouldDisplay = false;

  List booklist = [];
  var _selectedValue;
  Future getBooks() async {
    await FirebaseFirestore.instance
        .collection("books")
        .get()
        .then((value) async {
      for (int index = 0; index < value.docs.length; index++) {
        setState(() {
          booklist.add({
            "title": value.docs[index]["bookTitle"],
            "id": value.docs[index].id,
          });
        });
      }
    });
    print(booklist);
  }

  @override
  void initState() {
    super.initState();
    selectedOptions = [];
    getBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Add New Carousel Book"),
      ),
      body: SafeArea(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: CheckboxListTile(
                    title: Text('Book Or Picture'),
                    value: selectedOptions.contains('Book Or Picture'),
                    onChanged: (bool? value) {
                      setState(() {
                        if (value!) {
                          selectedOptions.add('Book Or Picture');
                          shouldDisplay2 = true;
                        } else {
                          selectedOptions.remove('Book Or Picture');
                          shouldDisplay2 = false;
                        }
                      });
                    },
                  ),
                ),
                shouldDisplay2
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: DropdownButtonFormField(
                            value: _selectedValue,
                            hint: Text('Choose the Book'),
                            isExpanded: true,
                            validator: (value) =>
                                value == null ? 'Select the book' : null,
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
                            items: booklist.map((category) {
                              return DropdownMenuItem(
                                child: Text(category["title"]),
                                value: category,
                              );
                            }).toList()))
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 30),
                        child: TextFormField(
                          // minLines: 3,
                          // maxLines: 8,
                          // keyboardType: TextInputType.multiline,
                          controller: carouselUrl,
                          // validator: (value) {
                          //   if (value == null || value.isEmpty) {
                          //     return 'Please enter the URL of the picture';
                          //   }
                          //   return null;
                          // },
                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            border: OutlineInputBorder(),
                            hintText: "Enter URL of the picture",
                            labelText: 'Enter URL of the picture',
                          ),
                        ),
                      ),

                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  child: ElevatedButton(
                     style: ButtonStyle(
                  backgroundColor:  MaterialStateProperty.all(Color.fromRGBO(32, 48, 61, 1))
                  
                  ),
                    onPressed: () => pickimage(),
                    child: const Text('Select Picture of the book'),
                  ),
                ),
                //       children: [
                //         // Padding(
                //         //   padding:
                //         //       const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                //         //   child: TextFormField(
                //         //     validator: (value) {
                //         //       if (value == null || value.isEmpty) {
                //         //         return 'Please enter some text';
                //         //       }
                //         //       return null;
                //         //     },
                //         //     controller: authorName,
                //         //     decoration: InputDecoration(
                //         //       border: OutlineInputBorder(),
                //         //       hintText: "Enter the name of the author",
                //         //     ),
                //         //   ),
                //         // ),
                //         // Padding(
                //         //   padding:
                //         //       const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                //         //   child: TextFormField(
                //         //     validator: (value) {
                //         //       if (value == null || value.isEmpty) {
                //         //         return 'Please enter some text';
                //         //       }
                //         //       return null;
                //         //     },
                //         //     controller: authorAboutMe,
                //         //     decoration: InputDecoration(
                //         //       border: OutlineInputBorder(),
                //         //       hintText: "Enter the description of the author",
                //         //     ),
                //         //   ),
                // //         // ),
                // // Row(
                // //       children: <Widget>[
                // //         Expanded(child: text),
                // //         Checkbox(
                // //           value: value,
                // //           onChanged: (bool? newValue) {
                // //             onChanged(newValue!);
                // //           },
                // //         ),
                // //       ],
                // //     ),

                //          Padding(
                //           padding: const EdgeInsets.symmetric(horizontal: 30),
                //           child: ElevatedButton(
                //             onPressed: () => pickimage(),
                //             child: const Text('Select Picture of the author'),
                //           ),
                //         ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: ElevatedButton(
                     style: ButtonStyle(
                  backgroundColor:  MaterialStateProperty.all(Color.fromRGBO(32, 48, 61, 1))
                  
                  ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        addNewCarousel();
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                          (Route<dynamic> route) => false,
                        );
                      } 
                    },
                    // onPressed:()=>   addNewCarousel(),
                    child: const Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    ;
  }
}
