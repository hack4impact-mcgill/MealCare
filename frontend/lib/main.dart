import 'package:flutter/material.dart';

import './pages/HomePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to MealCare',
      theme: ThemeData(
          accentColor: Colors.green, primaryColor: Colors.white),
      home: HomePage(),
    );
  }
}
