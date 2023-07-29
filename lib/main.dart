import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warak_admin/HomeScreen.dart';
import 'package:warak_admin/firebase_options.dart';
import 'package:warak_admin/model/user_model.dart';
import 'package:warak_admin/screens/AddAuthor.dart';
import 'package:warak_admin/screens/AddBooks.dart';
import 'package:warak_admin/screens/AddCategorie.dart';
import 'package:warak_admin/screens/AddCustomCategory.dart';
import 'package:warak_admin/screens/AddNewBookcarousel.dart';
import 'package:warak_admin/screens/OrderSubs.dart';
import 'package:warak_admin/screens/OrderWaraqi.dart';
import 'package:warak_admin/screens/OrdersElectrinoque.dart';
import 'package:warak_admin/screens/Updatesubscription.dart';
import 'package:warak_admin/Home.dart';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


User? currentUser = FirebaseAuth.instance.currentUser;
UserModel currentUserInfos = UserModel(
  uID: "",
  email: "",
  firstName: " ",
  lastName: " ",
  imageURL: "",
  coverImageURL: "",
  autherBooks: [],
  favoriteBooks: [],
  myBooks: [],
);
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Warak',
      debugShowCheckedModeBanner: false,
      // defaultTransition: Transition.cupertino,
      // theme: Themes.customLightTheme,
      // textDirection: MainFunctions.textDirection,
      // home: SignIn(),
      getPages: [
       
        GetPage(
          name: "/addbook",
          page: () => const addBooks(),
        ),
         GetPage(
          name: "/addauthor",
          page: () => const addAuthor(),
        ),
         GetPage(
          name: "/addcategorie",
          page: () => const addCategorie(),
        ),
          GetPage(
          name: "/addnewcar",
          page: () => const AddNewBookcarousel(),
        ),
          GetPage(
          name: "/addcusomcaegory",
          page: () => const addCustomCategory(),
        ),
         GetPage(
          name: "/updatesubs",
          page: () => const Updatesubscription(),
        ),
        //  GetPage(
        //   name: "/ad",
        //   page: () => const addWilayat(),
        // ),
         GetPage(
          name: "/Home",
          page: () => const HomeScreen(),
        ),
        GetPage(
          name: "/orders",
          page: () => const OrdersElectronique(),
        ),
          GetPage(
          name: "/ordes",
          page: () => const OrderWaraqi(),  
        ),
           GetPage(
          name: "/de",
          page: () => const OrderSubs(),  
        ),
      ],
      initialRoute: "/Home",
    );
  }
}


