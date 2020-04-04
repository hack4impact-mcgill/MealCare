import 'package:flutter/material.dart';

AppBar Header(
    {bool isAppTitle = false, String text, GlobalKey<ScaffoldState> s = null}) {
  return AppBar(
    actions: <Widget>[
      IconButton(
          onPressed: () {
            s != null ? s.currentState.openEndDrawer() : null;
          },
          icon: Icon(
            Icons.dehaze,
            color: Colors.green,
            size: 28.0,
          ))
    ],
    backgroundColor: Colors.transparent,
    bottomOpacity: 0.0,
    elevation: 0.0,
    // Add Logout
    leading: new Text(""),
    centerTitle: true,
    title: Column(
      children: <Widget>[
        Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.green, fontSize: 25),
        ),
        Text(
          isAppTitle ? "Volunteer" : "",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.green, fontSize: 12, letterSpacing: 3),
        )
      ],
    ),
  );
}
