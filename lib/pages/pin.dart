import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
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
  final LocalAuthentication auth = LocalAuthentication();

  List<BiometricType> _availableBiometrics;

  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;

  validate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (sha1.convert(utf8.encode(_pinPutController.text)).toString() ==
        prefs.getString('pin')) {
      Navigator.pushNamedAndRemoveUntil(
          context, 'bottomNavigator', (a) => false);
    }
  }

  Future<void> _getAvailableBiometrics() async {
    List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } catch (e) {
      print(e);
    }
    if (!mounted) return;

    setState(() {
      _availableBiometrics = availableBiometrics;
    });
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticateWithBiometrics(
          localizedReason: 'Scan your fingerprint to authenticate',
          useErrorDialogs: true,
          stickyAuth: true);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Authenticating';
      });
    } catch (e) {
      print("\n\n\n\n\n Errp aqui? $e");
    }
    if (!mounted) return;

    if (authenticated == true) {
      Navigator.pushNamedAndRemoveUntil(
          context, 'bottomNavigator', (a) => false);
    }

    final String message = authenticated ? 'Authorized' : 'Not Authorized';
    setState(() {
      _authorized = message;
    });
  }

  void _cancelAuthentication() {
    auth.stopAuthentication();
  }

  verifyFingerprint() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('fingerprintActive') == true) {
      await _getAvailableBiometrics();

      if (_availableBiometrics.isNotEmpty) {
        _authenticate();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    verifyFingerprint();
  }

  @override
  Widget build(BuildContext context) {
    if (_availableBiometrics != null && _availableBiometrics.isEmpty) {
      _pinPutFocusNode.requestFocus();
    }
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
