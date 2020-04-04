import 'package:flutter/material.dart';

Container CustomInput({bool isPassword = false, TextEditingController controller, String hintText}){
  return Container(margin: EdgeInsets.all(10),
        width: 300,
        height: 50,
        child: TextField(
          controller: controller,
          obscureText: isPassword,
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
            ),
            hintText: hintText,
            hintStyle: TextStyle(fontSize: 22.0, color: Colors.white),
          ),
        ));
}