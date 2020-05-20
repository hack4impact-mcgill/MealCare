import 'package:flutter/material.dart';
import 'package:frontend/helpers/arguments/user_arguments.dart';
import 'package:frontend/pages/location_page.dart';
import 'package:frontend/widgets/abstract_button.dart';
import 'package:frontend/widgets/custom_flat_button.dart';
import 'package:frontend/widgets/custom_text_field.dart';
import 'dart:ui';

class LoginPage extends StatefulWidget {
  static String routeName = "/login";

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailInput = TextEditingController();
  final passwordInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void login(username, password) {
      // here goes the function for login button
      print("login Pressed");
      print(username + " " + password);

      // missing authentication Logic.
      Navigator.pushNamed(context, 
      LocationPage.routeName,
      arguments: UserArguments(
          username
      ));
    }
  
    var email = CTextField(emailInput,
      width: 282,
      height: 32,
      placeholder: "Email",
      margin: EdgeInsets.fromLTRB(10, 10, 10, 31),
      hintTextStyle: TextStyle(fontSize: 22.0, color: Theme.of(context).primaryColor.withAlpha(205))
    );

    var password = CTextField(passwordInput,
      width: 282,
      height: 32,
      placeholder: "Password",
      margin: EdgeInsets.fromLTRB(10, 10, 10, 51),
      secure: true,
      hintTextStyle: TextStyle(fontSize: 22.0, color: Theme.of(context).primaryColor.withAlpha(205))
    );

    return new Scaffold(
        backgroundColor: Colors.transparent,
        body: new GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/bpic.png"), fit: BoxFit.cover)),
              child: Column(
                children: <Widget>[
                  Center(
                      child: Container(
                    child: Text(
                      "mealcare",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor, fontSize: 50, letterSpacing: 0),
                    ),
                    padding: EdgeInsets.fromLTRB(20, 150, 20, 0),
                  )),
                  Center(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                        child: Text("Volunteer",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
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
                          width: 252.0,
                          height: 52.0,
                          title: "LOGIN",
                          margin: EdgeInsets.all(10),
                          borderType: BorderType.round,
                          highlightTextColor: Theme.of(context).accentColor,
                      ),
                    ),
                  ],
                      ),
                ),
            ),
          ),
      );
  }
}
