import 'package:flutter/material.dart';

class CInput extends StatefulWidget {

  final String text;

  CInput(this.text);

  @override
  CInputState createState() => CInputState();
}

class CInputState extends State<CInput> {
  final myController = TextEditingController();
  String inputText;
  
  @override
  Widget build(BuildContext context) {
    
        return Container(
            margin: EdgeInsets.all(10),
            width: 300,
            height: 50,
            child: TextField(
              onChanged: (value) {
              this.inputText = value;
            },
              controller: myController,
              obscureText: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  hintText: "text"),
        ));
  }
}

