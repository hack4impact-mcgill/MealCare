import 'package:flutter/material.dart';
import 'package:frontend/widgets/abstract_button.dart';
import 'package:frontend/widgets/custom_flat_button.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: CircleAvatar(
              radius: 80.0,
              backgroundColor: Theme.of(context).accentColor,
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 30),
            child: Column(
              children: <Widget>[
                Text(
                  "George Kandalaft", // Place Holder
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Theme.of(context).accentColor),
                ),
                Text(
                  "McGill Chapter", // Place Holder
                  style: TextStyle(
                      fontSize: 20, color: Theme.of(context).accentColor),
                )
              ],
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(top: 80, left: 20),
            child: Text(
              "ACCOUNT DETAILS",
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.black.withOpacity(0.4),
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(top: 20, left: 40),
            child: Row(
              children: <Widget>[
                Text(
                  "Email: ",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "george.kandalaft@gmail.com",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(top: 20, left: 40),
            child: Row(
              children: <Widget>[
                Text(
                  "Joined: ",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "2nd April, 2020",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 50,bottom: 20),
            child: CFButton(
              () => print("object"),
              title: "Contact Manager",
              margin: EdgeInsets.all(10),
              width: 200.0,
              borderType: BorderType.round,
              borderColor: Theme.of(context).accentColor,
              textColor: Theme.of(context).accentColor,
            ),
          )
        ]));
  }
}
