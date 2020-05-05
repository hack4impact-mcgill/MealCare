import 'package:flutter/material.dart';
import 'package:frontend/pages/current_session_page.dart';
import 'package:frontend/pages/food_item_page.dart';
import 'package:frontend/pages/home_page.dart';
import 'package:frontend/pages/widgets_page.dart';
import 'package:frontend/pages/login_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primaryColor: Color(0xffffffff), accentColor: Color(0xff4AA35B)),
        initialRoute: '/',
        routes: {
          '/': (context) => LoginPage(),
          '/currentSession': (context) => CurrentSessionPage(),
          '/widgets': (context) => WidgetsPage(),
          '/foodItem': (context) => FoodItemPage(),
          '/home': (context) => HomePage()
        },
        title: 'Welcome to MealCare');
  }
}
