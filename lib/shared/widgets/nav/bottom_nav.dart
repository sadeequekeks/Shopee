import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shopee/module/screens/shopee_cart/cart_screen.dart';
import 'package:shopee/module/screens/shopee_category/category_screen.dart';
import 'package:shopee/module/screens/shopee_home/shop_home.dart';
import 'package:shopee/module/screens/shopee_profile/profile_screen.dart';

class BootomNav extends StatefulWidget {
  const BootomNav({Key? key}) : super(key: key);

  @override
  State<BootomNav> createState() => _BootomNavState();
}

class _BootomNavState extends State<BootomNav> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    ShopeeHome(),
    CategoryScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.rss),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.cartShopping),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
