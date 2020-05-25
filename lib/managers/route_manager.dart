import 'package:flutter/material.dart';
import 'package:tv_test/pages/details.dart';
import 'package:tv_test/pages/person_details.dart';
import 'package:tv_test/pages/pin.dart';
import 'package:tv_test/pages/settings.dart';
import 'package:tv_test/widgets/common/bottom_navigator.dart';

final routes = {
  'pinPage': (context) => PinPage(),
  'bottomNavigator': (context) => BottomNavigator(),
  'settings': (context) => SettingsPage(),
  'personDetails': (context) =>
      PersonDetails(ModalRoute.of(context).settings.arguments),
  'details': (context) =>
      DetailsPage(ModalRoute.of(context).settings.arguments),
};
