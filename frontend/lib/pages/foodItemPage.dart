import 'package:flutter/material.dart';
import 'package:frontend/pages/loginPage.dart';
import './currentSessionPage.dart';

class FoodItemPage extends StatelessWidget {
  // Missing Logout Logic
  void logout(context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              onPressed: () {
                logout(context);
              },
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.white,
                size: 28.0,
              ))
        ],
        backgroundColor: Color(0xff4AA35B),
        // Add Logout
        leading: new Text(""),
        title: Text("Food Item Page"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CurrentSessionPage()),
            );
          },
          child: Text('Check Current Session!'),
        ),
      ),
    );
  }
}
