import 'package:flutter/material.dart';
import 'package:warak_admin/Home.dart';
import 'package:warak_admin/screens/OrderSubs.dart';
import 'package:warak_admin/screens/OrderWaraqi.dart';
import 'package:warak_admin/screens/OrdersElectrinoque.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      'Index 3: Subscription',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final screens =[
    Home(),
    OrdersElectronique(),
       
     OrderWaraqi(),
 OrderSubs(),
   
  ];
  static const IconData subscriptions = IconData(0xe618, fontFamily: 'MaterialIcons');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        // selectedIconTheme:  IconThemeData(
        //   color:  Color.fromRGBO(32, 48, 61, 1),
                  
                
        // ),

        // unselectedIconTheme: IconThemeData(
        //   color:  Colors.blackS
                  
                
        // ),
        // selectedIconTheme: IconThemeData(color: Colors.red),
        items: const <BottomNavigationBarItem>[
          
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            // backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Electronic Orders',
            // backgroundColor: Colors.green,
          ),
         BottomNavigationBarItem(
             icon: Icon(Icons.business_center_outlined),
            label: 'Waraqi Orders',
            // backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            // icon: Icon(Icons.settings),
            // label: 'Settings',
             icon: Icon(subscriptions),
            label: 'Subscription',
            // backgroundColor: Colors.pink,
          ),
           
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
      body: screens[_selectedIndex],
    );
  }
}