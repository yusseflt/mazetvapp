import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tv_test/handlers/color_handler.dart';
import 'package:tv_test/managers/api_manager.dart';

class SettingsBloc {
  PublishSubject<Map> _settingsSubject;
  ApiManager _api = ApiManager();

  Stream<Map> get settingsObservable => _settingsSubject.stream;

  bool activatePin = false;

  TextEditingController _pinPutController = TextEditingController();
  FocusNode _pinPutFocusNode = FocusNode();

  SettingsBloc() {
    _settingsSubject = new PublishSubject<Map>();
  }

  Future initialize() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      if (prefs.getBool('pinActive') == true) {
        activatePin = true;
        _settingsSubject.sink.add({"pinActive": activatePin});
      } else {
        _settingsSubject.sink.add({"pinActive": activatePin});
      }
    } catch (e) {
      print(e);
    }
  }

  submit(pin, ctx) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (activatePin == true) {
      await prefs.setString('pin', sha1.convert(utf8.encode(pin)).toString());

      _pinPutFocusNode.unfocus();
      Navigator.pop(ctx);
      prefs.setBool('pinActive', true);
      _pinPutController.text = '';

      _settingsSubject.sink.add({"pinActive": activatePin});
    } else {
      if (sha1.convert(utf8.encode(pin)).toString() == prefs.getString('pin')) {
        await prefs.clear();

        await prefs.setBool('pinActive', false);
        _pinPutFocusNode.unfocus();

        Navigator.pop(ctx);

        _pinPutController.text = '';
        activatePin = false;
        _settingsSubject.sink.add({"pinActive": activatePin});
      } else {
        _pinPutController.text = '';
      }
    }
  }

  void pinActivation(value, context) async {
    activatePin = value;
    _pinPutController = TextEditingController();
    _pinPutFocusNode = FocusNode();

    showDialog(
      context: context,
      builder: (ctx) => SimpleDialog(
        shape: RoundedRectangleBorder(),
        backgroundColor: colors['dark_primary'],
        children: <Widget>[
          Center(
            child: Text(
              'Digite um PIN',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          PinPut(
            eachFieldConstraints: BoxConstraints(minHeight: 20, minWidth: 30),
            textStyle: TextStyle(color: Colors.white),
            fieldsCount: 4,
            onSubmit: (pin) => submit(pin, ctx),
            focusNode: _pinPutFocusNode,
            controller: _pinPutController,
            obscureText: '*',
            eachFieldPadding: EdgeInsets.all(4),
            fieldsAlignment: MainAxisAlignment.spaceEvenly,
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
            ),
          )
        ],
      ),
    );
  }
}
