import 'package:flutter/material.dart';
import 'package:frontend/helpers/arguments/user_arguments.dart';
import 'package:frontend/pages/food_item_page.dart';
import 'package:frontend/pages/home_page.dart';
import 'package:frontend/widgets/abstract_button.dart';
import 'package:frontend/widgets/custom_icon_button.dart';
import 'package:frontend/widgets/selectable_buttons/selectable_buttons.dart';

class LocationPage extends StatefulWidget {
  static String routeName = "/location";

  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  Map<String, bool> locations = {"MONTREAL" : false, "OTTAWA": false, "GUELPH": false};
  String chosenLocation;

  void toHome(name, location) {
    if(location != null) {
      Navigator.pushReplacementNamed(
        context,
        HomePage.routeName,
        arguments: UserArguments(name, location: location)
      );
    }
  }

  void setLocation(String location) {
    if(chosenLocation == location) {
      chosenLocation = null;
      locations[location] = false;
    } else {
      locations.forEach((loc, sel) {
        if(loc == location) {
            locations[loc] = true;
            chosenLocation = loc;
        } else {
          locations[loc] = false;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    UserArguments args = ModalRoute.of(context).settings.arguments;

    bool enableHomeButton = chosenLocation != null;

    SButtons buttons = SButtons(
      locations,
      setLocation,
      width: 205.0,
      textColor: Theme.of(context).primaryColor,
      highlightTextColor: Theme.of(context).accentColor,
      backgroundColor: Colors.transparent,
      highlightBackgroundColor: Theme.of(context).primaryColor,
      titleStyle: TextStyle(fontWeight: FontWeight.bold),
      borderType: BorderType.rounded,
      margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
      borderWidth: 2.0,
    );

    return new Scaffold(
        body: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/bpic.png"),
                      fit: BoxFit.cover)
              ),
              child: Column(children: <Widget>[
                      Container(
                        child: Text(
                          "Select Your Location",
                          style: TextStyle(
                              color: Colors.white, fontSize: 30, letterSpacing: 0),
                        ),
                        padding: EdgeInsets.fromLTRB(20, 150, 20, 20),
                      ),
                      buttons,
                      CIButton(
                        () => toHome(args.name, chosenLocation),
                        Icons.arrow_forward,
                        backgroundColor: Colors.transparent,
                        size: 55,
                        iconSize: 24,
                        borderWidth: 2.0,
                        textColor: Theme.of(context).primaryColor,
                        highlightTextColor: Theme.of(context).accentColor,
                        margin: EdgeInsets.fromLTRB(20, 15, 20, 20),
                        highlightBackgroundColor: Theme.of(context).primaryColor,
                        padding: EdgeInsets.fromLTRB(175, 0, 0, 0),
                        opacity: 1.0
                      )
                    ],
                  ),
              ),
          ),
      );
  }
}