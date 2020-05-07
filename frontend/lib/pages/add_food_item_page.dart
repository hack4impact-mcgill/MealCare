import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class AddFoodItemPage extends StatefulWidget {
  AddFoodItemPage({Key key}) : super(key: key);

  @override
  _AddFoodItemPageState createState() => _AddFoodItemPageState();
}

class _AddFoodItemPageState extends State<AddFoodItemPage> {
  final formKey = new GlobalKey<FormState>();
  String _name;
  int _quantity;
  DateTime _date;
  int _servings;
  int numberOfTrays;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.green, //change your color here
        ),
        // App bar need to be edited
        backgroundColor: Colors.white,
        title: Text(
            "Pasta",
          style:
          TextStyle(color: Colors.green, fontSize: 16),
        ),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.view_headline),
            onPressed: (){},
          ),
        ],
      ),
        body: new Padding(
          padding: const EdgeInsets.all(20.0),
          child: new Form(
            key: formKey,
            child: new ListView(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                ),
                Text("NAME (REQUIRED)"),
                new TextFormField(
                  decoration: new InputDecoration(hintText: "Enter a name"),
                  validator: (val) =>
                  val.isEmpty ? 'Please enter a name!' : null,
                  onSaved: (val) => _name = val,
                ),
                new Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                ),
                Text("DATE COLLECTED"),
                BasicDateField(),
                new Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                ),
                Text("SERVINGS/QUANTITY"),
                new TextFormField(
                  decoration: new InputDecoration(hintText: "Enter a number"),
                  keyboardType: TextInputType.number,
                  validator: (val) =>
                  int.parse(val) < 0 ? 'Quantity cannot be negative!' : null,
                  onSaved: (val) => _quantity = int.parse(val),
                ),
                new Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                ),
                Text("NO. OF TRAYS"),
                new TextFormField(
                  decoration: new InputDecoration(hintText: "Enter a number"),
                  keyboardType: TextInputType.number,
                  validator: (val) =>
                  int.parse(val) < 0 ? 'No. of trays cannot be negative!' : null,
                  onChanged: (value) {
                    numberOfTrays = int.parse(value);
                  },
                  onSaved: (val) => _quantity = int.parse(val),
                ),
                new Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                ),
                // if (numberOfTrays != null)
                for (var i = 0; i < 3; i++)  TrayInputForm(i+1),
                new RaisedButton(
                  child: new Text(
                    "SAVE",
                    style: new TextStyle(color: Colors.white),
                  ),
                  color: Colors.green,
                  onPressed: (){},
                )
              ],
            ),
          ),
        )
    );
  }
}

// DATE INPUT FIELD
class BasicDateField extends StatelessWidget {
  final format = DateFormat("yyyy-MM-dd");
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[

      DateTimeField(
        format: format,
        decoration: new InputDecoration(hintText: '(${format.pattern})'),
        onShowPicker: (context, currentValue) {
          return showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
        },
      ),
    ]);
  }
}

class TrayInputForm extends StatelessWidget {
  final int number;

  TrayInputForm(this.number);

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('TRAY $number',
            style:
            TextStyle(color: Colors.green, fontSize: 16),
          ),
          new Padding(
            padding: const EdgeInsets.only(top: 20.0),
          ),
          Text("SIZE"),
          new TextFormField(
            decoration: new InputDecoration(hintText: "Should be a select list"),
            onSaved: (val) {},
          ),
          new Padding(
            padding: const EdgeInsets.only(top: 20.0),
          ),
          Text("WEIGHT (LB)"),
          new TextFormField(
            decoration: new InputDecoration(hintText: "Enter the weight in lb(s)"),
            keyboardType: TextInputType.number,
            validator: (val) =>
            int.parse(val) < 0 ? 'Weight cannot be negative!' : null,
            onSaved: (val) {},
          ),
          new Padding(
            padding: const EdgeInsets.only(top: 20.0),
          ),
        ]
    );
  }
}