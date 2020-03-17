import 'package:flutter/material.dart';

class CButton extends StatelessWidget {
  final Function handler;
  final String text;
  final double height;
  final double width;

  CButton(this.handler, this.text, this.height, this.width);

  @override
  Widget build(BuildContext context) {
    var customButton = new Container(
        decoration: new BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 20.0, // has the effect of softening the shadow
              spreadRadius: 2.0, // has the effect of extending the shadow
              offset: Offset(
                5.0, // horizontal, move right 10
                5.0, // vertical, move down 10
              ),
            )
          ],
        ),
        margin: EdgeInsets.all(10),
        width: width,
        height: height,
        child: RaisedButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          onPressed: handler,
          color: Color(0xff4AA35B),
          textColor: Colors.white,
          child: Text(
            text,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ));
    return Container(child: customButton);
  }
}