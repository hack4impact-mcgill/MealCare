import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        "Settings CONTENT...",
        style: TextStyle(color: Colors.black, fontSize: 40),
        textAlign: TextAlign.center,
      ),
    );
  }
}
