import 'package:flutter/material.dart';
import 'package:frontend/pages/current_session_page.dart';
import 'package:frontend/pages/entry_page.dart';
import 'package:frontend/pages/food_item_page.dart';
import 'package:frontend/pages/location_page.dart';
import 'package:frontend/pages/vendors_page.dart';
import 'package:frontend/pages/home_page.dart';
import 'package:frontend/pages/widgets_page.dart';
import 'package:frontend/pages/login_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: "Muli", primaryColor: Color(0xffffffff), accentColor: Color(0xff4AA35B), iconTheme: IconThemeData(color: Color.fromRGBO(84, 84, 84, 1))),
      initialRoute: LoginPage.routeName,
      routes: {
        HomePage.routeName: (context) => HomePage(),
        VendorsPage.routeName: (context) => VendorsPage(),
        LoginPage.routeName:(context) => LoginPage(),
        LocationPage.routeName: (context) => LocationPage(),
        CurrentSessionPage.routeName: (context) => CurrentSessionPage(),
        WidgetsPage.routeName: (context) => WidgetsPage(),
        FoodItemPage.routeName: (context) => FoodItemPage(),
        EntryPage.routeName: (context) => EntryPage()
      },
      title: 'Welcome to MealCare'
    );
  }
}
