import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:frontend/models/food.dart';

import 'package:frontend/pages/current_session_page.dart';

import 'package:frontend/widgets/abstract_button.dart';
import 'package:frontend/widgets/custom_flat_button.dart';
import 'package:frontend/widgets/custom_raised_button.dart';
import 'package:frontend/widgets/custom_text_field.dart';
import 'package:http/http.dart' as http;

class FoodItemPage extends StatefulWidget {


  static String routeName = "/foodItem";


  @override
  _FoodItemPageState createState() => _FoodItemPageState();
}

class _FoodItemPageState extends State<FoodItemPage> {

  final nameInput = TextEditingController();
  final weightInput = TextEditingController();
  final description = TextEditingController();
  final category = TextEditingController();
  final serving_size = TextEditingController();
  String dropdownValue = 'Vegetables';

  final api = 'http://127.0.0.1:8000/add_food';

  final food = new Food(
      name: "",
      weight: 300,
      date_produced: "2020-02-02",
      expiry_date: "2020-03-03",
      description: "",
      category: "Meat and Poultry",
      serving_size: "20kg");

  var _ScaffoldKey = new GlobalKey<ScaffoldState>();

  void logout() {
    // Note this Push Replacement is only if this foodItemPage is the parent of all the next pages.
    print("Log out pressed");
    Navigator.pushReplacementNamed(context, "/");
  }


  void goToCurrentSession() {
    Navigator.pushNamed(
      context,
      CurrentSessionPage.routeName,
    );
  }

  Future<void> createFood() async {
    final response =
        await http.post(this.api, body: json.encode(this.food.toJson()));
    if (response.statusCode == 200) {
      print("DONE!");
      setState(() {
        this.nameInput.text = "";
        this.weightInput.text = "";
        this.serving_size.text = "";
        this.description.text = "";
      });
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    var name = CTextField(nameInput,
        width: 100,
        height: 30,
        textColor: Colors.black,
        borderColor: Colors.black,
        placeholder: "Name",
        margin: EdgeInsets.all(10),
        hintTextStyle: TextStyle(fontSize: 16.0, color: Colors.black));

    var weight = CTextField(weightInput,
        width: 100,
        height: 30,
        borderColor: Colors.black,
        textColor: Colors.black,
        placeholder: "Weight",
        margin: EdgeInsets.all(10),
        keyboard: TextInputType.number,
        hintTextStyle: TextStyle(fontSize: 16.0, color: Colors.black));

    var servingSize = CTextField(serving_size,
        width: 100,
        height: 30,
        borderColor: Colors.black,
        textColor: Colors.black,
        placeholder: "",
        margin: EdgeInsets.all(10),
        keyboard: TextInputType.number,
        hintTextStyle: TextStyle(fontSize: 16.0, color: Colors.black));

    var desc = CTextField(description,
        width: 200,
        height: 30,
        borderColor: Colors.black,
        textColor: Colors.black,
        placeholder: "Description",
        margin: EdgeInsets.all(10),
        keyboard: TextInputType.number,
        hintTextStyle: TextStyle(fontSize: 16.0, color: Colors.black));

    return Scaffold(
        body: Center(
      child: Column(
        children: <Widget>[
          Text(
            "Food Item Page",
            style:
                TextStyle(color: Theme.of(context).accentColor, fontSize: 20),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 55.0),
                  child: name,
                ),
                weight,
              ],
            ),
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 55.0),
                child: RaisedButton(
                    child: Text("Date Produced"),
                    onPressed: () {
                      showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2001),
                              lastDate: DateTime(2040))
                          .then((date) {
                        setState(() {
                          food.date_produced = date.toString().substring(0, 10);
                        });
                      });
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(food.date_produced),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 55.0),
                child: RaisedButton(
                    child: Text("Expiration Date"),
                    onPressed: () {
                      showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2001),
                              lastDate: DateTime(2040))
                          .then((date) {
                        setState(() {
                          food.expiry_date = date.toString().substring(0, 10);
                        });
                      });
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(food.expiry_date),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(left: 55.0, right: 10),
                  child: Text("Category: ")),
              DropdownButton<String>(
                value: dropdownValue,
                icon: Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: Colors.black),
                underline: Container(
                  height: 2,
                  color: Colors.black,
                ),
                onChanged: (String newValue) {
                  setState(() {
                    dropdownValue = newValue;
                    food.category = newValue;
                  });
                },
                items: <String>[
                  'Vegetables',
                  'Fruits',
                  'Grains, Beans and Nuts',
                  'Meat and Poultry',
                  'Fish and Seafood',
                  'Dairy Foods'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 55.0, right: 10),
                child: Text("Serving Size in Kg: "),
              ),
              servingSize,
            ],
          ),
          desc,
          CFButton(() {
            setState(() {
              this.food.name = nameInput.text;
              this.food.weight = double.parse(weightInput.text);
              this.food.serving_size = serving_size.text;
              this.food.description = description.text;
            });
            createFood();
          },
              title: "Create Data",
              margin: EdgeInsets.all(10),
              textColor: Theme.of(context).accentColor,
              borderColor: Theme.of(context).accentColor,
              borderType: BorderType.round),
          Center(
            child: CRButton(goToCurrentSession,
                title: "Check Current Session!",
                width: 300.0,
                height: 30.0,
                borderType: BorderType.rounded,
                margin: EdgeInsets.all(0)),
          ),
        ],
      ),
    ));
  }
}
