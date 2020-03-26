import 'package:flutter/material.dart';
import 'package:frontend/pages/loginPage.dart';

class SideBar extends StatelessWidget {

  final Function logout;
  
  SideBar(this.logout);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: ListView(
        children: <Widget>[
          SizedBox(height: 15),
          FlatButton(
            onPressed: () {
              /*...*/
            },
            child: SizedBox(
              width: double.infinity,
                          child: Text(
                "Home",
                 textAlign: TextAlign.left,
              style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
          ),
          SizedBox(height: 15),
          FlatButton(
            onPressed: () {
              /*...*/
            },
            child: SizedBox(
              width: double.infinity,
                          child: Text(
                "Profile",
                 textAlign: TextAlign.left,
              style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
          ),
          SizedBox(height: 15),
          FlatButton(
            onPressed: () {
              /*...*/
            },
            child: SizedBox(
              width: double.infinity,
                          child: Text(
                "Settings",
                 textAlign: TextAlign.left,
              style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
          ),
          SizedBox(height: 15),
          FlatButton(
            onPressed: () {
              this.logout();
            },
            child: SizedBox(
              width: double.infinity,
                          child: Text(
                "Logout",
                 textAlign: TextAlign.left,
              style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
          )
        ],
      ),
    );
  }
}