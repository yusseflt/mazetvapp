import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:tv_test/blocs/favorites_bloc.dart';
import 'package:tv_test/handlers/color_handler.dart';
import 'package:tv_test/pages/favorites.dart';
import 'package:tv_test/pages/home.dart';
import 'package:tv_test/pages/search.dart';

class BottomNavigator extends StatefulWidget {
  @override
  _BottomNavigatorState createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  final FavoritesBloc bloc = FavoritesBloc();
  int page = 1;

  changePage(index) {
    if (index == 2) {
      bloc.getFavorites();
    }
    setState(() {
      page = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: page,
        children: <Widget>[
          SearchPage(),
          HomePage(),
          FavoritesPage(bloc),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: colors["dark_background"],
        color: colors["dark_primary"],
        height: 56,
        index: page,
        buttonBackgroundColor: colors["red_primary"],
        animationDuration: Duration(milliseconds: 300),
        items: <Widget>[
          Icon(Icons.search, size: 30, color: Colors.white),
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.favorite, size: 30, color: Colors.white),
        ],
        onTap: (index) {
          changePage(index);
        },
      ),
    );
  }
}
