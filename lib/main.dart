import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tv_test/handlers/color_handler.dart';
import 'package:tv_test/handlers/scroll_glow_handler.dart';
import 'package:tv_test/managers/route_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var page = 'bottomNavigator';
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool pin = prefs.getBool('pinActive');

  if (pin == true) {
    page = 'pinPage';
  }

  runApp(MyApp(page));
}

class MyApp extends StatelessWidget {
  final page;

  MyApp(this.page);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      title: 'Flutter Demo',
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: ScrollGlowHandler(),
          child: child,
        );
      },
      theme: ThemeData(
          backgroundColor: colors["dark_background"], fontFamily: 'OpenSans'),
      debugShowCheckedModeBanner: false,
      routes: routes,
      initialRoute: page,
    );
  }
}
