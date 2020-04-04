import 'package:flutter/material.dart';

Widget SideBar(Function onPresss, Function logout) {
  return Padding(
    padding: const EdgeInsets.only(left: 15),
    child: ListView(
      children: <Widget>[
        SizedBox(height: 15),
        FlatButton(
          onPressed: () {
            onPresss(0);
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
            onPresss(1);
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
            onPresss(2);
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
            logout();
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
      // ),
    ),
  );
}
