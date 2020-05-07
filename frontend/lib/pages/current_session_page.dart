import 'package:flutter/material.dart';
import 'package:frontend/pages/add_food_item_page.dart';
import 'package:frontend/pages/profile_page.dart';

class CurrentSessionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // App bar need to be edited
        backgroundColor: Color(0xff4AA35B),
        title: Text("Current Session Page"),
      ),
      body: Column(children: <Widget>[
        RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go back To Food Item Page!'),
        ),
        Text(
          "This is an example of a push and pop page so it'll have its own appBar",
          textAlign: TextAlign.center,
        ),
        RaisedButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddFoodItemPage()),
            );
          },
          child: Text('Add food item'),
        ),
      ]),
    );
  }
}
