import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        "Profile CONTENT...",
        style: TextStyle(color: Colors.black, fontSize: 40),
        textAlign: TextAlign.center,
      ),
    );
  }
}
