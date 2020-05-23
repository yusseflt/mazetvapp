import 'package:flutter/material.dart';
import 'package:tv_test/handlers/color_handler.dart';
import 'package:tv_test/handlers/scroll_glow_handler.dart';
import 'package:tv_test/widgets/common/bottom_navigator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: ScrollGlowHandler(),
          child: child,
        );
      },
      theme: ThemeData(
          primarySwatch: Colors.blue,
          backgroundColor: colors["dark_background"],
          fontFamily: 'OpenSans'),
      home: BottomNavigator(),
    );
  }
}
