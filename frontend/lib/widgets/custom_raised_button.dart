import 'package:flutter/material.dart';
import 'package:frontend/widgets/abstract_button.dart';

class CRButton extends AbstractButton {

  CRButton(
      handler,
      { 
        title = "", 
        titleStyle = const TextStyle(fontSize: 20, fontStyle: FontStyle.normal),
        width = 150.0,
        height = 50.0, 
        backgroundColor = Colors.grey,
        borderColor = Colors.transparent,
        textColor = Colors.black,
        highlightColor: Colors.blueGrey,
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
    var customButton = new Container(
        decoration: new BoxDecoration(
          borderRadius: borderRadius(),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 2.0, // has the effect of softening the shadow
              spreadRadius: 0.5,// has the effect of extending the shadow
              offset: Offset(
                2.0, // horizontal, move right 10
                2.0, // vertical, move down 10
              ),
            )
          ],
        ),
        margin: this.margin,
        width: this.width,
        height: this.height,
        child: RaisedButton(
          shape:
            RoundedRectangleBorder(borderRadius: borderRadius()),
          onPressed: handler,
          color: this.backgroundColor,
          textColor: this.textColor,
          child: Text(
            this.title,
            style: this.titleStyle,
          ),
        ));
    return Container(child: customButton);
  }
}