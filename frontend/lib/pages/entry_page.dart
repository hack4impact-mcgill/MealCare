import 'package:flutter/material.dart';
import 'package:frontend/pages/current_session_page.dart';
import 'package:frontend/widgets/vendor_list/date_tile.dart';

class EntryPage extends StatefulWidget {
  static String routeName = "/entries";

  @override
  _EntriesPageState createState() => _EntriesPageState();
}

class _EntriesPageState extends State<EntryPage> {

  void goToCurrentSession() {
    Navigator.pushNamed(
      context,
      CurrentSessionPage.routeName,
    );
  }

final activeEntries = List<DateTile>.generate(5, 
  (i) =>  DateTile("March 10th, 2020", true, i)
  );

final archives = List<DateTile>.generate(5, 
  (i) => DateTile("March 10th, 2020", false, i)
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // App bar need to be edited
          backgroundColor: Theme.of(context).accentColor,
          title: Text("Current Session Page"),
        ),
        body: Column(children: <Widget>[
             Container(
                height: 57,
                child: 
                Align(
                  alignment: Alignment.centerLeft,
                  child: 
                    Padding(padding:  EdgeInsets.fromLTRB(20, 27, 0, 0),
                      child: Text(
                        "ACTIVE ENTRIES",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                          color: Color.fromRGBO(139, 139, 139, 1)
                        ),
                        )
                      )
                )
              ),
              Expanded(
                flex: 1,
                child: 
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: activeEntries.length,
                  itemBuilder: (context, index) {
                    final item = activeEntries[index];
                    return GestureDetector(
                      child: item,
                      onTap: () => goToCurrentSession(),
                    );
                  }
                )  
              ),
             Container(
                height: 57,
                child: 
                Align(
                  alignment: Alignment.centerLeft,
                  child: 
                    Padding(padding:  EdgeInsets.fromLTRB(20, 27, 0, 0),
                      child: Text(
                        "ARCHIVES",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                          color: Color.fromRGBO(139, 139, 139, 1)
                        ),
                        )
                      )
                )
              ),
              Expanded(
                flex: 1,
                child: 
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: archives.length,
                  itemBuilder: (context, index) {
                    final item = archives[index];
                    return GestureDetector(
                      child: item,
                      onTap: () => goToCurrentSession(),
                    );
                  }
                )  
              ),
             ]
        ),
    );
  }
}