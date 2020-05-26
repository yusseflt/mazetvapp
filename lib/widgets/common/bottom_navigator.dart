import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:mazetvapp/blocs/favorites_bloc.dart';
import 'package:mazetvapp/handlers/color_handler.dart';
import 'package:mazetvapp/pages/favorites.dart';
import 'package:mazetvapp/pages/home.dart';
import 'package:mazetvapp/pages/people.dart';

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
          PeoplePage(),
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
          Icon(Icons.people, size: 30, color: Colors.white),
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
