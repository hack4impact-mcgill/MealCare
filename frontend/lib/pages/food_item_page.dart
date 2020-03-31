import 'package:flutter/material.dart';
import 'package:frontend/widgets/abstract_button.dart';
import 'package:frontend/widgets/custom_raised_button.dart';
import 'package:frontend/widgets/side_bar.dart';

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
      Navigator.pushReplacementNamed(context, "/");
  }   

  void goToCurrentSession() {
      Navigator.pushNamed(
              context,
              "/currentSession",
      );
  }

  void goToWidgets() {
      Navigator.pushNamed(
        context,
        "/widgets",
      );
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
      body:
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(child:
                  CRButton(
                    goToCurrentSession, 
                    title: "Check Current Session!",
                    width: 300.0,
                    borderType: BorderType.rounded,
                    margin: EdgeInsets.all(20)
                  ),
              ),
                Center(child:
                  CRButton(
                    goToWidgets,
                    title: "Go see Widgets!",
                    width: 200.0,
                    borderType: BorderType.round,
                    margin: EdgeInsets.all(20)
                  ),
              )
          ],
          )
    );
  }
}
