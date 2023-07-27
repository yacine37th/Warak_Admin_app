// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // TRY THIS: Try running your application with "flutter run". You'll see
//         // the application has a blue toolbar. Then, without quitting the app,
//         // try changing the seedColor in the colorScheme below to Colors.green
//         // and then invoke "hot reload" (save your changes or press the "hot
//         // reload" button in a Flutter-supported IDE, or press "r" if you used
//         // the command line to start the app).
//         //
//         // Notice that the counter didn't reset back to zero; the application
//         // state is not lost during the reload. To reset the state, use hot
//         // restart instead.
//         //
//         // This works for code too, not just values: Most code changes can be
//         // tested with just a hot reload.
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called a gain, and so nothing would appear to happen.
//       _counter++;
//     });
//   }

//   final myController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   final _myController = TextEditingController();
//   final _my2Controller = TextEditingController();

//   @override
//   void dispose() {
//     // Clean up the controller when the widget is disposed.
//     _myController.dispose();
//     _my2Controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       // appBar: AppBar(
//       //   // TRY THIS: Try changing the color here to a specific color (to
//       //   // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
//       //   // change color while the other colors stay the same.
//       //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//       //   // Here we take the value from the MyHomePage object that was created by
//       //   // the App.build method, and use it to set our appbar title.
//       //   title: Text(widget.title),
//       // ),
      
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
//                 child: TextFormField(
//                   // The validator receives the text that the user has entered.
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter some text';
//                     }
//                     return null;
//                   },
//                     controller: _myController,
//                 ),
//               ),Padding(
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
//                 child: TextFormField(
//                   // The validator receives the text that the user has entered.
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter some text';
//                     }
//                     return null;
//                   },
//                     controller: _my2Controller,
//                 ),
//               ),
//               Padding(
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
//                 child: ElevatedButton(
//                   onPressed: () {
//                     // Validate returns true if the form is valid, or false otherwise.
//                     // if (_formKey.currentState!.validate()) {
//                     //   // If the form is valid, display a snackbar. In the real world,
//                     //   // you'd often call a server or save the information in a database.
//                     //   ScaffoldMessenger.of(context).showSnackBar(
//                     //     const SnackBar(content: Text('Processing Data')),
//                     //   );
//                     // }
//                     print("/////////////////////////////////////////");
//                     print(_myController.text);print(_my2Controller.text);
//                   },
//                   child: const Text('Submit'),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
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


