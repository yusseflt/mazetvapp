import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:tv_test/handlers/color_handler.dart';
import 'package:tv_test/pages/home.dart';

class BottomNavigator extends StatefulWidget {
  @override
  _BottomNavigatorState createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  int page = 0;
  List pages = [
    HomePage(),
  ];

  changePage(index) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[page],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: colors["dark_background"],
        color: colors["dark_primary"],
        height: 56,
        buttonBackgroundColor: colors["red_primary"],
        animationDuration: Duration(milliseconds: 300),
        items: <Widget>[
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.search, size: 30, color: Colors.white),
          Icon(Icons.favorite, size: 30, color: Colors.white),
        ],
        onTap: (index) {
          changePage(index);
        },
      ),
    );
  }
}
