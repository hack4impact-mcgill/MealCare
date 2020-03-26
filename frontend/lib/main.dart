import 'package:flutter/material.dart';
import 'package:frontend/pages/foodItemPage.dart';

import './pages/loginPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/':(context) => LoginPage(),
        '/foodItemPage': (context) => FoodItemPage()
      },
      title: 'Welcome to MealCare'
    );
  }
}