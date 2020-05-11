import 'package:flutter/material.dart';

class CurrentSessionPage extends StatelessWidget {
  static String routeName = "/currentSession";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // App bar need to be edited
        backgroundColor: Theme.of(context).accentColor,
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
        )
      ]),
    );
  }
}
