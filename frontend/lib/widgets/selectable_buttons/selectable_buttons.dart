import 'package:flutter/material.dart';
import 'package:frontend/widgets/abstract_button.dart';
import 'package:frontend/widgets/selectable_buttons/selectable_button.dart';

class SButtons extends StatefulWidget {
  
  final Map<String, bool> selections;
  final ValueChanged<String> onButtonSelectedTitle;
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

  SButtons(
    this.selections,
    this.onButtonSelectedTitle,
    {
      this.titleStyle = const TextStyle(fontSize: 20, fontStyle: FontStyle.normal),
      this.width = 150.0,
      this.height = 50.0, 
      this.backgroundColor = Colors.transparent,
      this.borderColor = Colors.white,
      this.textColor = Colors.white,
      this.highlightBackgroundColor = Colors.white,
      this.highlightTextColor = Colors.black,
      this.highlightBorderColor = Colors.white,
      this.margin = EdgeInsets.zero,
      this.borderType =  BorderType.none,
      this.borderWidth =  1.0,
    }
  );

  @override
  State<StatefulWidget> createState() => new _SButtonsState();
}

class _SButtonsState extends State<SButtons> {

  List<Widget> setButtons() {
    List<Widget> buttons = [];
    widget.selections.forEach((title, selected) => {
      buttons.add(
        Center(child: 
          SButton(() => 
            {
              setState(() {
                widget.onButtonSelectedTitle(title);
              })
            },
            selected,
            width: widget.width,
            title: title,
            textColor:widget.textColor,
            borderColor: widget.borderColor,
            backgroundColor: widget.backgroundColor,
            highlightBackgroundColor: widget.highlightBackgroundColor,
            highlightTextColor: widget.highlightTextColor,
            highlightBorderColor: widget.highlightBorderColor,
            titleStyle: widget.titleStyle,
            borderType: widget.borderType,
            margin: widget.margin,
            borderWidth: widget.borderWidth
          ) 
        )
      )
    });
    return buttons;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: setButtons());
  }
}
