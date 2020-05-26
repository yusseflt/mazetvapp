import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mazetvapp/handlers/color_handler.dart';
import 'package:local_auth/local_auth.dart';

class SettingsBloc {
  PublishSubject<Map> _settingsSubject;

  Stream<Map> get settingsObservable => _settingsSubject.stream;

  bool activatePin = false;
  bool activateFingerprint = false;
  bool canCheckBiometrics = false;

  TextEditingController _pinPutController = TextEditingController();
  FocusNode _pinPutFocusNode = FocusNode();

  SettingsBloc() {
    _settingsSubject = new PublishSubject<Map>();
  }

  Future initialize() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      LocalAuthentication localAuth = LocalAuthentication();

      canCheckBiometrics = await localAuth.canCheckBiometrics;

      if (prefs.getBool('pinActive') == true) {
        activatePin = true;
        if (canCheckBiometrics == true) {
          if (prefs.getBool('fingerprintActive') == true) {
            activateFingerprint = true;
          }
        }
        _settingsSubject.sink.add({
          "pinActive": activatePin,
          "fingerprintActive": activateFingerprint,
          "canCheckBiometrics": canCheckBiometrics
        });
      } else {
        _settingsSubject.sink.add({
          "pinActive": activatePin,
          "fingerprintActive": activateFingerprint,
          "canCheckBiometrics": canCheckBiometrics
        });
      }
    } catch (e) {
      print(e);
    }
  }

  void submit(pin, ctx) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (activatePin == true) {
      await prefs.setString('pin', sha1.convert(utf8.encode(pin)).toString());

      _pinPutFocusNode.unfocus();
      Navigator.pop(ctx);
      prefs.setBool('pinActive', true);
      _pinPutController.text = '';
      _settingsSubject.sink.add({
        "pinActive": activatePin,
        "fingerprintActive": activateFingerprint,
        "canCheckBiometrics": canCheckBiometrics
      });
    } else {
      if (sha1.convert(utf8.encode(pin)).toString() == prefs.getString('pin')) {
        await prefs.clear();

        await prefs.setBool('pinActive', false);

        await prefs.setBool('fingerprintActive', false);
        _pinPutFocusNode.unfocus();

        Navigator.pop(ctx);

        _pinPutController.text = '';

        activateFingerprint = false;
        activatePin = false;

        _settingsSubject.sink.add({
          "pinActive": activatePin,
          "fingerprintActive": activateFingerprint,
          "canCheckBiometrics": canCheckBiometrics
        });
      } else {
        _pinPutController.text = '';
      }
    }
  }

  void fingerprintActivation(value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    activateFingerprint = value;

    prefs.setBool('fingerprintActive', value);

    _settingsSubject.sink.add({
      "pinActive": activatePin,
      "fingerprintActive": activateFingerprint,
      "canCheckBiometrics": canCheckBiometrics
    });
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
