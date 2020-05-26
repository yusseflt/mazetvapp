import 'package:flutter/material.dart';
import 'package:mazetvapp/pages/details.dart';
import 'package:mazetvapp/pages/person_details.dart';
import 'package:mazetvapp/pages/pin.dart';
import 'package:mazetvapp/pages/settings.dart';
import 'package:mazetvapp/widgets/common/bottom_navigator.dart';

final routes = {
  'pinPage': (context) => PinPage(),
  'bottomNavigator': (context) => BottomNavigator(),
  'settings': (context) => SettingsPage(),
  'personDetails': (context) =>
      PersonDetails(ModalRoute.of(context).settings.arguments),
  'details': (context) =>
      DetailsPage(ModalRoute.of(context).settings.arguments),
};
