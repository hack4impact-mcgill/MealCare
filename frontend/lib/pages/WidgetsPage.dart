import 'package:flutter/material.dart';
import 'package:frontend/widgets/AbstractButton.dart';
import 'package:frontend/widgets/CustomFlatButton.dart';
import 'package:frontend/widgets/CustomRaisedButton.dart';
import 'package:frontend/widgets/CustomTextField.dart';

class WidgetsPage extends StatefulWidget {
  @override
  _WidgetsPageState createState() => _WidgetsPageState();
}

class _WidgetsPageState extends State<WidgetsPage> {
  
  void navigateBack() {
    Navigator.pop(context);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: 
         new GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          }, 
        child:
            new Container(
                height: MediaQuery.of(context).size.height, 
                child:  
                ListView( // List View to enable the GestureDetector
                  children: <Widget>[
                    Center(child:
                      Padding(
                        padding: EdgeInsets.all(24.0),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: CRButton(navigateBack,
                            width: 50.0,
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
                      ),
                    ),
                    Center(child: 
                      CFButton(() => {
                            // Necessary to activate button
                            print("Round Flat Button")
                          }, 
                          title: "Round",
                          margin:  EdgeInsets.all(20),
                          textColor: Colors.black,
                          borderColor: Colors.black,
                          borderType: BorderType.round,
                      ),
                    ),
                    Center(child: 
                      CTextField(null,
                        width: 300,
                        height: 50,
                        placeholder: "TextField",
                        textColor: Colors.black,
                        margin: EdgeInsets.all(10),
                        hintTextStyle: TextStyle(fontSize: 22.0, color: Colors.black.withAlpha(205))
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
                        hintTextStyle: TextStyle(fontSize: 22.0, color: Colors.black.withAlpha(205))
                      )
                    )
                  ],
              ),
          )
        )
    );
  }
}