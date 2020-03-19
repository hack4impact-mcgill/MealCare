import 'package:flutter/material.dart';

class CurrentSessionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff4AA35B),
        title: Text("Current Session Page"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go back To Food Item Page!'),
        ),
      ),
    );
  }
}
