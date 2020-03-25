import 'package:flutter/material.dart';
import 'package:frontend/pages/formPage.dart';
import 'package:frontend/widgets/customTextField.dart';

import '../widgets/customButton.dart';
import '../widgets/customTextField.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    var assetImage = new AssetImage("assets/logo.png");

    void login() {
      print("login Pressed");
    }

    void signUp() {
      print("signUp Pressed");
    }

    void signInGoogle() {
      print("signInGoogle");
    }

    void toForm() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FormPage()),
      );
    }

    var logo = new Container(
        width: 250.0,
        height: 250.0,
        margin: EdgeInsets.only(top: 25.0),
        decoration: new BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 20.0, // has the effect of softening the shadow
              spreadRadius: 2.0, // has the effect of extending the shadow
              offset: Offset(
                5.0, // horizontal, move right 10
                5.0, // vertical, move down 10
              ),
            )
          ],
            shape: BoxShape.circle,
            image: new DecorationImage(fit: BoxFit.fill, image: assetImage)));

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Center(
            child: logo,
            heightFactor: 1.2,
          ),
          Center(
            child: CTextField(placeholder: "Email",width: 300, height: 50),
          ),
          Center(
            child: CTextField(placeholder: "Password",width: 300, height: 50),
          ),
          Center(
            child: CButton(login, title:"Log In", width: 300, height:50),
          ),
          Center(
            child: CButton(signUp, title:"Sign Up", width: 300, height:50),
          ),
          Center (
            child: CButton(login),
          ),
          Center(
            child: CButton(signInGoogle, width: 50),
          ),
          Center(
            child: CButton(toForm, title: "Form"),
          )
        ],
      ),
    );
  }
}


