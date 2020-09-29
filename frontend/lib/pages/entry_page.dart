import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:frontend/http/server.dart';
import 'package:frontend/models/foodCollect.dart';
import 'package:frontend/models/vendor.dart';
import 'package:frontend/pages/current_session_page.dart';
import 'package:frontend/widgets/vendor_list/date_tile.dart';

class EntryPage extends StatefulWidget {
  static String routeName = "/entries";

  @override
  _EntriesPageState createState() => _EntriesPageState();
}

class CurrentSessionArgument {
  CurrentSessionArgument({this.foodCollect, this.vendor});
  final FoodCollect foodCollect;
  final Vendor vendor;
}

class _EntriesPageState extends State<EntryPage> {
  Vendor vendor;
  void goToCurrentSession(foodCollect) {
    Navigator.pushNamed(context, CurrentSessionPage.routeName,
        arguments: CurrentSessionArgument(
            foodCollect: foodCollect, vendor: this.vendor));
  }

  var client = HttpClientService();
  Future<List<FoodCollect>> foodCollects;

  @override
  void initState() {
    super.initState();
    try {
      foodCollects = client.getAllFoodCollect();
    } catch (error) {
      print(error.toString());
    }
  }

  final activeEntries =
      List<DateTile>.generate(5, (i) => DateTile("March 10th, 2020", true, i));

  final archives =
      List<DateTile>.generate(5, (i) => DateTile("March 10th, 2020", false, i));

  @override
  Widget build(BuildContext context) {
    final Vendor vendor = ModalRoute.of(context).settings.arguments;
    this.setState(() {
      this.vendor = vendor;
    });
    return Scaffold(
      appBar: AppBar(
        // App bar need to be edited
        backgroundColor: Theme.of(context).accentColor,
        title: Text(vendor.name),
      ),
      body: Column(children: <Widget>[
        Container(
            height: 57,
            child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 27, 0, 0),
                    child: Text(
                      "ACTIVE ENTRIES",
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                          color: Color.fromRGBO(139, 139, 139, 1)),
                    )))),
        FutureBuilder<List<FoodCollect>>(
          future: foodCollects,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var items = snapshot.data
                  .map((food) => FoodCollect(
                      id: food.id,
                      pickup_time: food.pickup_time,
                      vendor_id: food.vendor_id))
                  .toList();
              return Expanded(
                  flex: 1,
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return GestureDetector(
                          child: DateTile(
                              convertDateFromString(item.pickup_time),
                              false,
                              index),
                          onTap: () => goToCurrentSession(item),
                        );
                      }));
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            // By default, show a loading spinner.
            return Padding(
                padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                child: Align(
                    alignment: Alignment.center,
                    child: Container(
                        height: 100,
                        width: 100,
                        child: CircularProgressIndicator())));
          },
        ),
        Container(
            height: 57,
            child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 27, 0, 0),
                    child: Text(
                      "ARCHIVES",
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                          color: Color.fromRGBO(139, 139, 139, 1)),
                    )))),
        Expanded(
            flex: 1,
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: archives.length,
                itemBuilder: (context, index) {
                  final item = archives[index];
                  return GestureDetector(
                    child: item,
                    // onTap: () => goToCurrentSession(),
                  );
                })),
      ]),
    );
  }

  String convertDateFromString(String pickup_time) {
    DateTime todayDate = DateTime.parse(pickup_time);
    return formatDate(todayDate, [M, ' ', dd, ', ', yyyy]);
  }
}
