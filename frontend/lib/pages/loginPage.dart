import 'package:flutter/material.dart';

import '../widgets/customButton.dart';

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

    var email = new Container(
        margin: EdgeInsets.all(10),
        width: 300,
        height: 50,
        child: TextField(
          decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              hintText: 'Email'),
        ));

    var password = new Container(
        margin: EdgeInsets.all(10),
        width: 300,
        height: 50,
        child: TextField(
          obscureText: true,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              hintText: 'Password'),
        ));

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
            child: email,
          ),
          Center(
            child: password,
          ),
          Center(
            child: CButton(login, "Log in"),
          ),
          Center(
            child: CButton(signUp, "Sign Up"),
          ),
        ],
      ),
    );
  }
}


