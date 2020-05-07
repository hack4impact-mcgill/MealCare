import 'package:flutter/material.dart';
import 'package:frontend/widgets/abstract_button.dart';
import 'package:frontend/widgets/selectable_buttons/selectable_buttons.dart';

class SButton extends AbstractButton {

  final bool selected;

  SButton(
      handler,
      this.selected,
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
        opacity: 1.0,
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
      borderWidth: borderWidth,
      opacity: opacity,
    );

  @override
  _SButtonState createState() {
    return new _SButtonState();
  }
}

class _SButtonState extends State<SButton> {  
  
  bool highlighted = false;

  void setHighlighting(bool isHighlighted) {
    setState(() {
      this.highlighted = isHighlighted;
    });
  }

  Color get textColor {
    if(widget.selected) {
      return highlighted ? widget.textColor : widget.highlightTextColor;
    }
    return highlighted ? widget.highlightTextColor : widget.textColor;
  }

  Color get borderColor {
    if(widget.selected) {
      return highlighted ? widget.borderColor : widget.highlightBorderColor;
    }
    return highlighted ? widget.highlightBorderColor : widget.borderColor;
  }

  @override
  Widget build(BuildContext context) {
    Color selectedBorderColor = borderColor;
    Color selectedBackgroundColor = widget.selected ? widget.highlightBackgroundColor : widget.backgroundColor;
    Color selectedTextColor =  textColor;
  
    var selectableButton =  new Container(
        margin: widget.margin,
        width: widget.width,
        height: widget.height,
        child: FlatButton(
          color: selectedBackgroundColor,
          shape:
              RoundedRectangleBorder(
                borderRadius: widget.borderRadius(), 
                side: BorderSide(
                  color:  selectedBorderColor,
                  width: widget.borderWidth,
                )
              ),
          onPressed: widget.handler,
          onHighlightChanged: (isHighlighted) {
            this.setHighlighting(isHighlighted);
          },
          highlightColor: widget.highlightBackgroundColor,
          textColor: selectedTextColor,
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
    return Opacity(opacity: widget.opacity, child: selectableButton);
  }
}
