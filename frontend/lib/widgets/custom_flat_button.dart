import 'package:flutter/material.dart';
import 'package:frontend/widgets/abstract_button.dart';

class CFButton extends AbstractButton {

  CFButton(
      handler,
      { 
        title = "", 
        titleStyle = const TextStyle(fontSize: 20, fontStyle: FontStyle.normal),
        width = 150.0,
        height = 50.0, 
        backgroundColor = Colors.transparent,
        borderColor = Colors.white,
        textColor = Colors.white,
        highlightColor = Colors.white,
        margin: EdgeInsets.zero,
        borderType: BorderType.none
      } 
    ) : super(
      handler,
      title: title, 
      titleStyle: titleStyle,
      width: width, 
      height: height,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      textColor: textColor,
      highlightColor: highlightColor,
      margin: margin,
      borderType: borderType,
    );  

  @override
  Widget build(BuildContext context) {
    var flatButton = new Container(
        margin: margin,
        width: width,
        height: height,
        child: FlatButton(
          shape:
              OutlineInputBorder(borderRadius: borderRadius(), borderSide: BorderSide(color: this.borderColor) ),
          onPressed: handler,
          highlightColor: this.highlightColor,
          textColor: textColor,
          child: Text(
            title,
            style: titleStyle,
          ),
        ));
    return Container(child: flatButton);
  }
}