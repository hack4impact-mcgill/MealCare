import 'package:flutter/material.dart';

class CRButton extends StatelessWidget {
  final Function handler;
  final String title;
  final double width;
  final double height;
  final Color color;
  final Color textColor;

  CRButton(
      this.handler,
    { 
      this.title = "", 
      this.width = 150,
      this.height = 50, 
      this.color = const Color(0xff4AA35B),
      this.textColor = Colors.white
    }
  );

  @override
  Widget build(BuildContext context) {
    var customButton = new Container(
        decoration: new BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 5.0, // has the effect of softening the shadow
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
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(height / 2)),
          onPressed: handler,
          color: this.color,
          textColor: this.textColor,
          child: Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ));
    return Container(child: customButton);
  }
}