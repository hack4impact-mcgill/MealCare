import 'package:flutter/material.dart';

abstract class AbstractButton extends StatefulWidget {
  final Function handler;
  final String title;
  final TextStyle titleStyle;
  final double width;
  final double height;
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
  final Color highlightBackgroundColor;
  final Color highlightTextColor;
  final Color highlightBorderColor;
  final EdgeInsets margin;
  final double borderWidth;
  final BorderType borderType;
  final double opacity;

  AbstractButton(
    this.handler,
    { 
      this.title = "", 
      this.titleStyle = const TextStyle(fontSize: 20, fontStyle: FontStyle.normal),
      this.width = 150.0,
      this.height = 50.0, 
      this.backgroundColor = Colors.transparent,
      this.borderColor = Colors.white,
      this.highlightBackgroundColor = Colors.white,
      this.margin = EdgeInsets.zero,
      this.borderType = BorderType.rounded,
      this.borderWidth = 0,
      this.textColor = Colors.white,
      this.highlightTextColor = Colors.white,
      this.highlightBorderColor = Colors.white,
      this.opacity = 1.0
    }
  );

  BorderRadius borderRadius() {
      switch(this.borderType) {
        case BorderType.none:
          return BorderRadius.zero;
        case BorderType.round:
          return BorderRadius.circular(this.height / 2);
        case BorderType.rounded:
          return BorderRadius.circular(8);
        default: 
          return BorderRadius.zero;
      }
  }
}

abstract class AbstractButtonState extends State<AbstractButton> {
  bool highlighted = false;

  void setHighlighting(bool isHighlighted) {
    setState(() {
      this.highlighted = isHighlighted;
    });
  }

  Color get textColor {
    return highlighted ? widget.highlightTextColor : widget.textColor;
  }

  Color get borderColor {
    return highlighted ? widget.highlightBorderColor : widget.borderColor;
  }
}

enum BorderType {
  rounded,
  round,
  none
}