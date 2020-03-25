import 'package:flutter/material.dart';

class CTextField extends StatefulWidget {
  const CTextField({this.placeholder = "", this.width = 150, this.height = 50});

  final String placeholder;
  final double width;
  final double height;

  @override
  _CTextFieldState createState() => _CTextFieldState();
}

class _CTextFieldState extends State<CTextField> {
  
  final textEditingController = TextEditingController();

   @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        margin: EdgeInsets.all(10),
        width: widget.width,
        height: widget.height,
        child: TextField(
          controller: textEditingController,
          obscureText: true,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular( widget.width / 2)
                  )
              ),
              hintText: widget.placeholder,
              contentPadding: const EdgeInsets.all(20.0)
          ),
        )
      );
  }
}
