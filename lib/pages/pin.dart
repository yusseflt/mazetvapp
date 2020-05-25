import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tv_test/handlers/color_handler.dart';

class PinPage extends StatefulWidget {
  @override
  _PinPageState createState() => _PinPageState();
}

class _PinPageState extends State<PinPage> {
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();

  validate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (sha1.convert(utf8.encode(_pinPutController.text)).toString() ==
        prefs.getString('pin')) {
      Navigator.pushNamedAndRemoveUntil(
          context, 'bottomNavigator', (a) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    _pinPutFocusNode.requestFocus();
    return Scaffold(
      backgroundColor: colors["dark_background"],
      body: Builder(
        builder: (context) {
          return Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(16.0),
                    child: Center(
                      child: Text(
                        'Digite seu PIN',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(16),
                    padding: EdgeInsets.all(16),
                    child: PinPut(
                        textStyle: TextStyle(color: Colors.white),
                        fieldsCount: 4,
                        onSubmit: (String pin) => validate(),
                        focusNode: _pinPutFocusNode,
                        controller: _pinPutController,
                        obscureText: '*',
                        submittedFieldDecoration: BoxDecoration(
                          border: Border.all(color: colors["red_secondary"]),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        selectedFieldDecoration: BoxDecoration(
                          border: Border.all(color: colors["red_secondary"]),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        followingFieldDecoration: BoxDecoration(
                          border: Border.all(color: colors["red_primary"]),
                          borderRadius: BorderRadius.circular(5),
                        )),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
