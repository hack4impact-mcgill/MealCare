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
        highlightBackgroundColor = Colors.white,
        highlightTextColor = Colors.black,
        highlightBorderColor = Colors.white,
        margin: EdgeInsets.zero,
        borderType: BorderType.none,
        borderWidth: 1.0,
        isSelectable: false,
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
      highlightBorderColor: highlightBorderColor,
      margin: margin,
      borderType: borderType,
      borderWidth: borderWidth
    );

  @override
  _CFButtonState createState() {
    return new _CFButtonState();
  }
}

class _CFButtonState extends AbstractButtonState {
   @override
  Widget build(BuildContext context) {
    var flatButton = new Container(
        margin: widget.margin,
        width: widget.width,
        height: widget.height,
        child: FlatButton(
          color: widget.backgroundColor,
          shape:
              RoundedRectangleBorder(
                borderRadius: widget.borderRadius(), 
                side: BorderSide(
                  color: super.borderColor,
                  width: widget.borderWidth,
                )
              ),
          onPressed: widget.handler,
          onHighlightChanged: (isHighlighted) => this.setHighlighting(isHighlighted),
          highlightColor: widget.highlightBackgroundColor,
          textColor: super.textColor,
          child: Stack(children: [
            Positioned(
              child: 
                Text(
                  widget.title,
                  style: widget.titleStyle,
                ),
            ),
          ]),
        ));
    return Container(child: flatButton);
  }
}
