import 'package:flutter/material.dart';
import 'package:frontend/pages/current_session_page.dart';
import 'package:frontend/pages/food_item_page.dart';
import 'package:frontend/pages/widgets_page.dart';
import 'package:frontend/pages/login_page.dart';

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