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
        highlightBackgroundColor: Colors.blueGrey,
        highlightTextColor: Colors.black,
        margin: EdgeInsets.zero,
        borderType: BorderType.none,
        borderWidth: 1.0,
        opacity: 1.0
      } 
    ) : super(
      handler,
      title: title, 
      titleStyle: titleStyle,
      width: width, 
      height: height,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      highlightBackgroundColor: highlightBackgroundColor,
      textColor: textColor,
      highlightTextColor: highlightTextColor,
      margin: margin,
      borderType: borderType,
      borderWidth: borderWidth,
      opacity: opacity
    );

  @override
  _CRButtonState createState() => new _CRButtonState();
}

class _CRButtonState extends AbstractButtonState {
  @override
  Widget build(BuildContext context) {
    var customButton = new Container(
        decoration: new BoxDecoration(
          borderRadius: widget.borderRadius(),
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
        margin: widget.margin,
        width: widget.width,
        height: widget.height,
        child: RaisedButton(
          shape:
            RoundedRectangleBorder(
              borderRadius: widget.borderRadius(),
              side: BorderSide(
                color: super.borderColor,
                width: widget.borderWidth 
              )
            ),
          onPressed: widget.handler,
          onHighlightChanged: (isHighlighted) => super.setHighlighting(isHighlighted),
          highlightColor: widget.highlightBackgroundColor,
          color: widget.backgroundColor,
          textColor: super.textColor,
          child: Text(
            widget.title,
            style: widget.titleStyle,
          ),
        ));
    return Opacity(opacity: widget.opacity, child: customButton);
  }
}