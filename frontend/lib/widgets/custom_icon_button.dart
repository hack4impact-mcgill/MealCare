import 'package:flutter/material.dart';
import 'package:frontend/widgets/abstract_button.dart';

class CIButton extends AbstractButton {
    final IconData icon;
    final double size;
    final double iconSize;
    final EdgeInsets padding;

    CIButton(
      handler,
      this.icon,
      {
        this.iconSize = 24,
        this.size = 50,
        backgroundColor = Colors.transparent,
        borderColor = Colors.white,
        textColor = Colors.white,
        highlightBackgroundColor = Colors.white,
        highlightTextColor = Colors.black,
        highlightBorderColor = Colors.white,
        margin: EdgeInsets.zero,
        borderType: BorderType.none,
        borderWidth: 1.0,
        this.padding: EdgeInsets.zero,
        opacity: 1.0,
      }
    ) : super(
      handler,
      width: size,
      height: size,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      highlightBackgroundColor: highlightBackgroundColor,
      textColor: textColor,
      highlightTextColor: highlightTextColor,
      highlightBorderColor: highlightBorderColor,
      margin: margin,
      borderType: BorderType.round,
      borderWidth: borderWidth,
      opacity: opacity
    );

  @override
  _CIButtonState createState() =>  new _CIButtonState();
}

class _CIButtonState extends State<CIButton> {

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

  @override
  Widget build(BuildContext context) {
      return 
      Opacity(opacity: widget.opacity, child:
        Container(child: 
          SizedBox(
            width: widget.size,
            height: widget.size,
            child: RawMaterialButton(
                elevation: 0,
                highlightElevation: 0,
                onPressed: widget.handler,
                child: Icon(
                  widget.icon,
                  size: widget.iconSize,
                  color: textColor
                ),
                fillColor: widget.backgroundColor,
                highlightColor: widget.highlightBackgroundColor,
                onHighlightChanged: (isHighlighted) => setHighlighting(isHighlighted),
                shape: CircleBorder(
                  side: BorderSide(
                    color: borderColor,
                    width: widget.borderWidth,
                  )
              ),
            )  
          ),
          margin: widget.margin,
          padding: widget.padding
        )
      );
  }
}