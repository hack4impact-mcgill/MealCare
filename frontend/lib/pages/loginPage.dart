import 'package:flutter/material.dart';
import 'package:frontend/pages/formPage.dart';
import 'package:frontend/widgets/customFlatButton.dart';
import 'package:frontend/widgets/customTextField.dart';
import './foodItemPage.dart';
import 'dart:ui';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailInput = TextEditingController();
  final passwordInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var assetImage = new AssetImage("assets/logo.png");

    void login(username, password) {
      // here goes the function for login button
      print("login Pressed");
      print(username + " " + password);

      // missing authentication Logic.
      Route route = MaterialPageRoute(builder: (context) => FoodItemPage());
      Navigator.pushReplacementNamed(context, 'foodItemPage');
    }

    var keyboardIsVisible = MediaQuery.of(context).viewInsets.bottom != 0;

    var email = new Container(
        margin: EdgeInsets.all(10),
        width: 300,
        height: 50,
        child: TextField(
          controller: emailInput,
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
            ),
            hintText: 'Email',
            hintStyle: TextStyle(fontSize: 22.0, color: Colors.white),
          ),
        ));

    var password = new Container(
        margin: EdgeInsets.all(10),
        width: 300,
        height: 50,
        child: TextField(
          controller: passwordInput,
          obscureText: true,
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
            ),
            hintText: "Password",
            hintStyle: TextStyle(fontSize: 22.0, color: Colors.white),
          ),
        ));

    return new Scaffold(
          resizeToAvoidBottomPadding: false,
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: new GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/bpic.png"),
                      fit: BoxFit.cover)
              ),
              child: Stack(
                children: <Widget>[
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 200),
                    top: keyboardIsVisible ? 0 : 150,
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: 
                      Column(children: <Widget>[
                          Center( 
                            child: Container(
                              child: Text(
                                "mealcare",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 50, letterSpacing: 0),
                              ),
                              padding: EdgeInsets.fromLTRB(20, 150, 20, 0),
                            )
                          ),
                          Center(
                            child: Container(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                              child: Text("Volunteer",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      letterSpacing: 6)
                              )
                            )
                          ),
                          Center(
                            child: email,
                          ),
                          Center(
                            child: password,
                          ),
                          Center(
                            child: CFButton(
                                () => login(emailInput.text, passwordInput.text),
                                title: "Log in"),
                          ),
                        ],
                      ),
                  )
                ],
              ),
            ),
          )
      );
  }
}
