import 'package:flutter/material.dart';
import 'package:frontend/pages/profilePage.dart';
import 'package:frontend/pages/settingsPage.dart';
import 'package:frontend/widgets/customInput.dart';
import 'package:frontend/widgets/header.dart';
import 'package:frontend/widgets/sidebar.dart';

import '../widgets/customButton.dart';

import './foodItemPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final emailInput = TextEditingController();
  final passwordInput = TextEditingController();
  bool isAuth = false;
  PageController pageController;
  int pageIndex = 0;
  var currentPage = ["MealCare", "Profile", "Settings"];
  var assetImage = new AssetImage("assets/logo.png");

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  void login(username, password) {
    // here goes the function for login button
    print("login Pressed");
    print(username + " " + password);
    setState(() {
      isAuth = true;
    });
  }

  void logout() {
    setState(() {
      isAuth = false;
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  changePage(int pageIndex) {
    pageController.animateToPage(pageIndex,
        duration: Duration(milliseconds: 200), curve: Curves.ease);
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  Widget buildAuthScreen() {
    var _ScaffoldKey = new GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _ScaffoldKey,
      appBar: Header(
          isAppTitle: true, text: currentPage[pageIndex], s: _ScaffoldKey),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        children: <Widget>[
          FoodItemPage(),
          ProfilePage(),
          SettingsPage(),
        ],
      ),
      endDrawer: Drawer(child: SideBar(changePage, logout)),
    );
  }

// --------------------> UnAuthPage
  Widget buildUnAuthScreen() {
    return Center(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            width: 900,
            height: 900,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/bpic.png"),
                    fit: BoxFit.fitHeight)),
            child: Column(
              children: <Widget>[
                Container(
                  child: Text(
                    "mealcare",
                    style: TextStyle(
                        color: Colors.white, fontSize: 50, letterSpacing: 0),
                  ),
                  padding: EdgeInsets.fromLTRB(20, 150, 20, 0),
                ),
                Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 60),
                    child: Text("Volunteer",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            letterSpacing: 6))),
                CustomInput(
                    controller: emailInput,
                    isPassword: false,
                    hintText: "Email"),
                CustomInput(
                    controller: passwordInput,
                    isPassword: true,
                    hintText: "Password"),
                CButton(
                    () => login(emailInput.text, passwordInput.text), "Log in"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // UnAuthPage <--------------------
  @override
  Widget build(BuildContext context) {
    return isAuth ? buildAuthScreen() : buildUnAuthScreen();
  }
}
