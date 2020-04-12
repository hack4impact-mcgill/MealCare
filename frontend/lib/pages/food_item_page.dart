import 'package:flutter/material.dart';
import 'package:frontend/widgets/abstract_button.dart';
import 'package:frontend/widgets/custom_raised_button.dart';
import 'package:frontend/widgets/side_bar.dart';

class FoodItemPage extends StatefulWidget {
  // Missing Logout Logic
  @override
  _FoodItemPageState createState() => _FoodItemPageState();
}

class _FoodItemPageState extends State<FoodItemPage> {
  var _ScaffoldKey = new GlobalKey<ScaffoldState>();

  void logout() {
    // Note this Push Replacement is only if this foodItemPage is the parent of all the next pages.
    print("Log out pressed");
    Navigator.pushReplacementNamed(context, "/");
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
          style: TextStyle(color: Colors.green, fontSize: 40),
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
