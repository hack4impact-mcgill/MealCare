import 'package:flutter/material.dart';
import 'package:frontend/widgets/customButton.dart';

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  
  void navigateBack() {
    Navigator.pop(context);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: CButton(navigateBack, "", 50, 50)
            )
          ],),
    );
  }

}