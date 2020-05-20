import 'package:flutter/material.dart';

class CTextField extends StatefulWidget {
  
  final TextEditingController textEditingController;
  final String placeholder;
  final double width;
  final double height;
  final bool secure;
  final Color borderColor;
  final Color textColor;
  final Color focusedBorderColor;
  final EdgeInsets margin;
  final TextStyle hintTextStyle;

  CTextField(
    this.textEditingController, {
      this.placeholder = "",
      this.width = 150,
      this.height = 50,
      this.secure = false,
      this.textColor = Colors.white,
      this.borderColor = Colors.white,
      this.focusedBorderColor = Colors.blue,
      this.margin = EdgeInsets.zero,
      this.hintTextStyle = const TextStyle(fontSize: 20),
      this.keyboard = TextInputType.text,
    }
  );

  final TextEditingController textEditingController;
  final String placeholder;
  final double width;
  final double height;
  final bool secure;
  final Color borderColor;
  final Color textColor;
  final Color focusedBorderColor;
  final EdgeInsets margin;
  final TextStyle hintTextStyle;
  final TextInputType keyboard;

  @override
  _CTextFieldState createState() => _CTextFieldState();
}

class _CTextFieldState extends State<CTextField> {

   @override
  void dispose() {
    if (widget.textEditingController != null)     
    widget.textEditingController.dispose();    

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        margin: widget.margin,
        width: widget.width,
        height: widget.height,
        child: TextField(
          keyboardType: widget.keyboard,
          controller: widget.textEditingController,
          obscureText: widget.secure,
          style: new TextStyle(color: widget.textColor),
          cursorColor: widget.textColor,
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: widget.borderColor),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: widget.focusedBorderColor),
            ),
            hintText: widget.placeholder,
            hintStyle: widget.hintTextStyle
          ),
        ));
  }
}
