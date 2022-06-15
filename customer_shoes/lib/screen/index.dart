import 'package:customer_shoes/screen/Notifications.dart';
import 'package:customer_shoes/screen/Profile.dart';
import 'package:customer_shoes/screen/Shopping.dart';
import 'package:flutter/material.dart';
import 'Home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  int _currentIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  static final List<Widget> _tabs = [
    const HomePage(),
    //const ShoppingPage(),
    const NotificationPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.blue,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Trang chủ",
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.shopping_cart),
          //   label: "Shopping",
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_alert),
            label: "Thông báo",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "Cá nhân",
          ),
        ],
        currentIndex: _currentIndex,
        onTap: onItemTapped,
        // selectedItemColor: Colors.blue,
        // unselectedItemColor: Colors.grey,
      ),
      body: _tabs.elementAt(_currentIndex),
    );
  }
}

