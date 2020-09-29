import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

import 'entry_page.dart';

class CurrentSessionPage extends StatelessWidget {
  static String routeName = "/currentSession";

  @override
  Widget build(BuildContext context) {
    final CurrentSessionArgument arguments =
        ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        // App bar need to be edited
        backgroundColor: Theme.of(context).accentColor,
        title: Column(
          children: [
            Text(arguments?.vendor?.name ?? ""),
            Text(formatDate(DateTime.parse(arguments.foodCollect.pickup_time),
                [M, ' ', dd, ', ', yyyy]))
          ],
        ),
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
