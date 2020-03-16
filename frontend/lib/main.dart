import 'package:flutter/material.dart';

import './pages/loginPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to MealCare',
      home: Scaffold(
      body: LoginPage(),
      ),
    );
  }
}