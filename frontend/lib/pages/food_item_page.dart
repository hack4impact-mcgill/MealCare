import 'package:flutter/material.dart';
import 'package:frontend/pages/current_session_page.dart';
import 'package:frontend/widgets/abstract_button.dart';
import 'package:frontend/widgets/custom_raised_button.dart';

class FoodItemPage extends StatefulWidget {
  static String routeName = "/foodItem";

  @override
  _FoodItemPageState createState() => _FoodItemPageState();
}

class _FoodItemPageState extends State<FoodItemPage> {

  void goToCurrentSession() {
    Navigator.pushNamed(
      context,
      CurrentSessionPage.routeName,
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
