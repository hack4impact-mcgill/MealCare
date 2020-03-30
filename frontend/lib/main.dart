import 'package:flutter/material.dart';
import 'package:frontend/pages/CurrentSessionPage.dart';
import 'package:frontend/pages/FoodItemPage.dart';
import 'package:frontend/pages/WidgetsPage.dart';

import './pages/LoginPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/':(context) => LoginPage(),
        '/currentSession': (context) => CurrentSessionPage(),
        '/widgets': (context) => WidgetsPage(),
        '/foodItem': (context) => FoodItemPage()
      },
      title: 'Welcome to MealCare'
    );
  }
}