import 'package:flutter/material.dart';

abstract class AbstractButton extends StatelessWidget{
  final Function handler;
  final String title;
  final TextStyle titleStyle;
  final double width;
  final double height;
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
  final Color highlightColor;
  final EdgeInsets margin;
  final BorderType borderType;

   AbstractButton(
    this.handler,
    { 
      this.title = "", 
      this.titleStyle = const TextStyle(fontSize: 20, fontStyle: FontStyle.normal),
      this.width = 150.0,
      this.height = 50.0, 
      this.backgroundColor = Colors.grey,
      this.borderColor = Colors.white,
      this.textColor = Colors.white,
      this.highlightColor = Colors.white,
      this.margin = EdgeInsets.zero,
      this.borderType = BorderType.rounded,
    }
  );  

  BorderRadius borderRadius() {
      switch(this.borderType) {
        case BorderType.none:
          return BorderRadius.zero;
        case BorderType.round:
          return BorderRadius.circular(this.height / 2);
        case BorderType.rounded:
          return BorderRadius.circular(10);
        default: 
          return BorderRadius.zero;
      }
  }
}

enum BorderType {
  rounded,
  round,
  none
}