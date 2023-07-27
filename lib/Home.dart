import 'package:flutter/material.dart';
import 'package:warak_admin/screens/AddAuthor.dart';
import 'package:warak_admin/screens/AddBooks.dart';
import 'package:warak_admin/screens/AddCategorie.dart';
import 'package:warak_admin/screens/AddCustomCategory.dart';
import 'package:warak_admin/screens/AddNewBookcarousel.dart';
import 'package:warak_admin/screens/OrderSubs.dart';
import 'package:warak_admin/screens/OrderWaraqi.dart';
import 'package:warak_admin/screens/OrdersElectrinoque.dart';
import 'package:warak_admin/screens/Updatesubscription.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
    Text(
      'Index 3: Settings',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final screens = [
    Home(),
    OrdersElectronique(),
    OrderSubs(),
    OrderWaraqi(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Home"),
      ),

      // bottomNavigationBar: BottomNavigationBar(
      //   type: BottomNavigationBarType.fixed,
      //   // selectedIconTheme: IconThemeData(color: Colors.red),
      //   items: const <BottomNavigationBarItem>[

      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Home',
      //       // backgroundColor: Colors.blue,
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.business),
      //       label: 'Business',
      //       // backgroundColor: Colors.green,
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.school),
      //       label: 'School',
      //       // backgroundColor: Colors.purple,
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.settings),
      //       label: 'Settings',
      //       // backgroundColor: Colors.pink,
      //     ),
      //   ],
      //   currentIndex: _selectedIndex,
      //   selectedItemColor: Colors.blue,
      //   onTap: _onItemTapped,
      // ),

      // //  / bottomNavigationBar: ,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
               style: ButtonStyle(
                  backgroundColor:  MaterialStateProperty.all(Color.fromRGBO(32, 48, 61, 1))
                  
                  ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const addBooks()));
                },
                child: Text('Add New Book')),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const addAuthor()));
              },
              child: Text('Add New Author'),
              style: ButtonStyle(
                  backgroundColor:  MaterialStateProperty.all(Color.fromRGBO(32, 48, 61, 1))
                  
                  ), // <-- Does not work
            ),
            ElevatedButton(
               style: ButtonStyle(
                  backgroundColor:  MaterialStateProperty.all(Color.fromRGBO(32, 48, 61, 1))
                  
                  ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const addCategorie()));
                },
                child: Text('Add New Category')),
            ElevatedButton(
               style: ButtonStyle(
                  backgroundColor:  MaterialStateProperty.all(Color.fromRGBO(32, 48, 61, 1))
                  
                  ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const addCustomCategory()));
                },
                child: Text('Add New Custom Category')),
            ElevatedButton(
               style: ButtonStyle(
                  backgroundColor:  MaterialStateProperty.all(Color.fromRGBO(32, 48, 61, 1))
                  
                  ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddNewBookcarousel()));
                },
                child: Text('Add New Carousel')),
            ElevatedButton(
               style: ButtonStyle(
                  backgroundColor:  MaterialStateProperty.all(Color.fromRGBO(32, 48, 61, 1))
                  
                  ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Updatesubscription()));
                },
                child: Text('Update The subscription')),
          ],
        ),
      ),
    );
  }
}
