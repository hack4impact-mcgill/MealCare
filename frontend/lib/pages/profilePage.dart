import 'package:flutter/material.dart';
import 'package:frontend/widgets/header.dart';

class ProfilePage extends StatefulWidget {


  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(isAppTitle: false, text: "Profile"),
    );
  }
}