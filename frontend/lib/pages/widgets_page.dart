import 'package:flutter/material.dart';
import 'package:frontend/widgets/abstract_button.dart';
import 'package:frontend/widgets/custom_flat_button.dart';
import 'package:frontend/widgets/custom_icon_button.dart';
import 'package:frontend/widgets/custom_raised_button.dart';
import 'package:frontend/widgets/custom_text_field.dart';

class WidgetsPage extends StatefulWidget {
  static String routeName = "/widgets";
  
  @override
  _WidgetsPageState createState() => _WidgetsPageState();
}

class _WidgetsPageState extends State<WidgetsPage> {
  void navigateBack() {
    print("go back");
    //Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: new GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: new Container(
              height: MediaQuery.of(context).size.height,
              child: ListView(
                // List View to enable the GestureDetector
                children: <Widget>[
                  Center(
                    child: Padding(
                        padding: EdgeInsets.all(24.0),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: CIButton(
                                      navigateBack,
                                      Icons.arrow_back,
                                      size: 50.0,
                                      textColor: Colors.black,
                                      borderType: BorderType.round,
                                    )
                        )
                      ),
                    ),
                    Center(child: 
                      Text(
                        "This is a page to display/play with widgets! \n Feel free to test out widgets here!", 
                        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)
                      ),
                    ),
                    Center(child: 
                      CRButton(() => {
                          // Necessary to activate button
                          print("Round Raised Button")
                        }, 
                        title: "Round",
                        margin: EdgeInsets.all(20),
                        borderType: BorderType.round,
                        textColor: Colors.white,
                      )
                    ),
                    Center(child: 
                      CRButton(() => {
                          // Necessary to activate button
                          print("Rounded Raised Button")
                        }, 
                        title: "Rounded",
                        margin: EdgeInsets.all(20),
                        borderType: BorderType.rounded,
                        textColor: Colors.white,
                        highlightTextColor: Colors.black,  
                      ),
                    ),
                    Center(child: 
                      CFButton(() => {
                            // Necessary to activate button
                            print("Round Flat Button")
                          }, 
                          title: "Round",
                          margin:  EdgeInsets.all(20),
                          backgroundColor: Colors.red,
                          textColor: Colors.black,
                          borderColor: Colors.black,
                          borderType: BorderType.round,
                          highlightTextColor: Colors.red,
                          highlightBackgroundColor: Colors.black,
                          highlightBorderColor: Colors.red,
                      ),
                    ),
                    Center(child: 
                      CTextField(null,
                        width: 300,
                        height: 50,
                        placeholder: "TextField",
                        textColor: Colors.black,
                        margin: EdgeInsets.all(10),
                         hintTextStyle: TextStyle(
                            fontSize: 22.0,
                            color: Colors.black.withAlpha(205)
                          ),
                      ),
                    ),
                    Center(child: 
                      CTextField(null,
                        width: 300,
                        height: 50,
                        placeholder: "Secure TextField",
                        textColor: Colors.black,
                        margin: EdgeInsets.all(10),
                        secure: true,
                         hintTextStyle: TextStyle(
                            fontSize: 22.0,
                            color: Colors.black.withAlpha(205)
                        ),
                      )
                    ),
                    Center(child: 
                       IconButton(
                          onPressed: null,
                          color: Colors.white,
                          icon: Image.asset('assets/arrow.png'),
                      )
                    ,)
                  ],
              ),
            )));
  }
}
