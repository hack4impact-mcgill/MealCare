import 'package:flutter/material.dart';
import 'package:frontend/pages/login_page.dart';
import 'package:frontend/widgets/abstract_button.dart';
import 'package:frontend/widgets/custom_raised_button.dart';

class FoodItemPage extends StatefulWidget {
  static String routeName = "/foodItem";

  @override
  _FoodItemPageState createState() => _FoodItemPageState();
}

class _FoodItemPageState extends State<FoodItemPage> {
  var _ScaffoldKey = new GlobalKey<ScaffoldState>();

  void logout() {
      // Note this Push Replacement is only if this foodItemPage is the parent of all the next pages.
      print("Log out pressed");
      Navigator.pushReplacementNamed(context, LoginPage.routeName);
  }   

  void goToCurrentSession() {
    Navigator.pushNamed(
      context,
      "/currentSession",
    );
  }

  void goToWidgets() {
    Navigator.pushNamed(
      context,
      "/widgets",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          "Food Item Page",
          style: TextStyle(color: Theme.of(context).accentColor, fontSize: 40),
        ),
        Center(
          child: CRButton(goToCurrentSession,
              title: "Check Current Session!",
              width: 300.0,
              borderType: BorderType.rounded,
              margin: EdgeInsets.all(20)),
        ),
      ],
    ));
  }
}
