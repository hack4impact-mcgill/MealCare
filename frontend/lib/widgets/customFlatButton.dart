import 'package:flutter/material.dart';

class CFButton extends StatelessWidget {
  final Function handler;
  final String title;
  final double width;
  final double height;
  final Color color;
  final Color textColor;

  CFButton(
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
    var flatButton = new Container(
        margin: EdgeInsets.all(10),
        width: 200,
        height: 50,
        child: FlatButton(
          
          shape:
              OutlineInputBorder(borderRadius: BorderRadius.circular(15),borderSide: BorderSide(color: Colors.white) ),
          onPressed: handler,

          textColor: Colors.white,
          child: Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ));
    return Container(child: flatButton);
  }
}