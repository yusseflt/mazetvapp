import 'package:flutter/material.dart';
import 'package:mazetvapp/blocs/settings_bloc.dart';
import 'package:mazetvapp/handlers/color_handler.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  SettingsBloc bloc = SettingsBloc();

  @override
  void initState() {
    super.initState();
    bloc.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors["dark_background"],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SafeArea(
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Text(
                  "Settings",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            ),
          ),
          StreamBuilder(
              stream: bloc.settingsObservable,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Expanded(
                  child: ListView(
                    physics: NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      Theme(
                        data: ThemeData(
                            unselectedWidgetColor: colors["red_primary"]),
                        child: CheckboxListTile(
                          title: Text(
                            'Activate Pin Verification',
                            style: TextStyle(color: Colors.white),
                          ),
                          activeColor: colors["red_primary"],
                          onChanged: (value) {
                            bloc.pinActivation(value, context);
                          },
                          value: snapshot.data["pinActive"],
                        ),
                      ),
                      snapshot.data["canCheckBiometrics"] == true
                          ? Theme(
                              data: ThemeData(
                                  unselectedWidgetColor: colors["red_primary"]),
                              child: CheckboxListTile(
                                title: Text(
                                  'Activate Fingerprint',
                                  style: TextStyle(color: Colors.white),
                                ),
                                activeColor: colors["red_primary"],
                                onChanged: (value) {
                                  bloc.fingerprintActivation(value);
                                },
                                value: snapshot.data["fingerprintActive"],
                              ),
                            )
                          : Container(),
                    ],
                  ),
                );
              }),
        ],
      ),
    );
  }
}
