import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:warak_admin/HomeScreen.dart';

class addCustomCategory extends StatefulWidget {
  const addCustomCategory({super.key});

  @override
  State<addCustomCategory> createState() => _addCustomCategoryState();
}

class _addCustomCategoryState extends State<addCustomCategory> {
  final customCategoryName = TextEditingController();

  final _formKey = GlobalKey<FormState>();
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

  var db = FirebaseFirestore.instance;
  Future NewCustomCat(
      //   {
      //   required String authorName,
      //   required String bookTitle,
      //   required String bookCategory,
      //   required String bookAbout,
      // }
      ) async {
    // Upload Book url
    var doc = db.collection("customCategories").doc();

    // var carousel =  db.collection("carousel").doc();
    doc.set({
      "customCategoryName": customCategoryName.text,
      "customCategoryBooksIDs": bookToAddToCustom,
    }).onError((e, _) => print(
        "Error writing document /////////////////////////////////////////////: $e"));
  }

  @override
  void initState() {
    super.initState();
    getBooks();
  }

  List bookToAddToCustom = [];
  List bookToAddToCustom2 = [];
  List bookToAddToCustom3 = [];
  bool added = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
         appBar: AppBar(
        elevation: 0,
        title: Text("Add New Custom Category"),
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
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  child: TextFormField(
                    // minLines: 3,
                    // maxLines: 8,
                    // keyboardType: TextInputType.multiline,
                    controller: customCategoryName,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the custom Category Name';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(),
                      hintText: "Enter the name of the custom Category",
                      labelText: 'Custom Category Name',
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: DropdownButtonFormField(
                        value: _selectedValue,
                        hint: Text('Choose the Book Or The Books'),
                        isExpanded: true,
                         validator: (value) =>
                              value == null ? 'Select the books' : null,
                        onChanged: (value) {
                          setState(() {
                            _selectedValue = value;
                            bookToAddToCustom.add(_selectedValue["id"]);
                            bookToAddToCustom3.add(_selectedValue["title"]);
                            bookToAddToCustom2.add(_selectedValue);
                            added = true;
                          });
                        },
                        onSaved: (value) {
                          setState(() {
                            _selectedValue = value;
                            bookToAddToCustom.add(_selectedValue["id"]);
                            bookToAddToCustom3.add(_selectedValue["title"]);
                            bookToAddToCustom2.add(_selectedValue);
                            added = true;
                          });
                        },
                        items: booklist.map((category) {
                          return DropdownMenuItem(
                            child: Text(category["title"]),
                            value: category,
                          );
                        }).toList())),
                added
                    ? Padding(    padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 30),
                    child: Column(
                      children: [
                             Text(
                          " ${bookToAddToCustom3.map((book) =>
                               "${book}\n",
                             )}"),
                           ],
                    )
                    )
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 30),
                        child: Text('No Books in the list', style: TextStyle(fontSize: 15),)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: ElevatedButton(
                     style: ButtonStyle(
                  backgroundColor:  MaterialStateProperty.all(Color.fromRGBO(32, 48, 61, 1))
                  
                  ),
                    // onPressed: 
                    // ()=>   NewCustomCat(),
                    onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          NewCustomCat();
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
    );
    ;
  }
}
