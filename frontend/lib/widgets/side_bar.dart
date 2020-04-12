import 'package:flutter/material.dart';

class SideBar extends StatelessWidget {
  final Function logout;
  final Function changePage;

  SideBar(this.changePage, this.logout);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: ListView(
        children: <Widget>[
          SizedBox(height: 15),
          FlatButton(
            onPressed: () {
              this.changePage(0);
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
              this.changePage(1);
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
              this.changePage(2);
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
              this.changePage(3);
            },
            child: SizedBox(
              width: double.infinity,
              child: Text(
                "Widget Page",
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
      ),
    );
  }
}
