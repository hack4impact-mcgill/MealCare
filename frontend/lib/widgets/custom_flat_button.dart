import 'package:flutter/material.dart';

class CButton extends StatelessWidget {
  final Function handler;
  final String text;

  CButton(this.handler, this.text);

  @override
  Widget build(BuildContext context) {
    var loginButton = new Container(
        margin: EdgeInsets.all(10),
        width: 200,
        height: 50,
        child: FlatButton(
          
          shape:
              OutlineInputBorder(borderRadius: BorderRadius.circular(15),borderSide: BorderSide(color: Colors.white) ),
          onPressed: handler,

          textColor: Colors.white,
          child: Text(
            text,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ));
    return Container(child: loginButton);
  }
}