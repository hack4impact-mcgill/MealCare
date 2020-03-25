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
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(24.0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: CButton(navigateBack, width: 50)
              )
            )
          ],),
    );
  }

}