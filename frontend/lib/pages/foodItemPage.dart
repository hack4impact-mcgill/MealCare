import 'package:flutter/material.dart';
import 'package:frontend/pages/loginPage.dart';
import './currentSessionPage.dart';
import '../widgets/sidebar.dart';

class FoodItemPage extends StatefulWidget {
  // Missing Logout Logic
  @override
  _FoodItemPageState createState() => _FoodItemPageState();
}

class _FoodItemPageState extends State<FoodItemPage> {
  var _ScaffoldKey = new GlobalKey<ScaffoldState>();

  void logout() {
      // Note this Push Replacement is only if this foodItemPage is the parent of all the next pages.
      print("Log out pressed");
      Route route = MaterialPageRoute(builder: (context) => LoginPage());
      Navigator.pushReplacement(context, route);
  }   

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _ScaffoldKey,
      endDrawer: Drawer(
        child: SideBar(this.logout),
      ),
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              onPressed: () {
                _ScaffoldKey.currentState.openEndDrawer();
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
              "MealCare",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.green, fontSize: 25),
            ),
            Text(
              "Volunteer",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.green, fontSize: 12, letterSpacing: 3),
            )
          ],
        ),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CurrentSessionPage()),
            );
          },
          child: Text('Check Current Session!'),
        ),
      ),
    );
  }
}
