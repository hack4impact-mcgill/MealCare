import 'package:flutter/material.dart';
import 'package:frontend/http/server.dart';
import 'package:frontend/models/vendor.dart';
import 'package:frontend/pages/entry_page.dart';
import 'package:frontend/widgets/vendor_list/vendor_tile.dart';

class VendorsPage extends StatefulWidget {
  static String routeName = "/vendors";

  @override
  _VendorsPageeState createState() => _VendorsPageeState();
}

class _VendorsPageeState extends State<VendorsPage> {

  void goToCurrentSession() {
    Navigator.pushNamed(
      context,
      EntryPage.routeName,
    );
  }

  var client = HttpClientService();

  Future<List<Vendor>> vendors;
  
  @override
  void initState() {
      super.initState();
    try {
      vendors = client.getAllVendors();
    } catch(error) {
        print(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: 
        Column(children: <Widget>[
          Container(
            height: 57,
            child: 
            Align(
              alignment: Alignment.centerLeft,
              child: 
                Padding(padding:  EdgeInsets.fromLTRB(20, 27, 0, 0),
                  child: Text(
                    "VENDORS",
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
            FutureBuilder<List<Vendor>>(
              future: vendors,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var items = snapshot.data.map((vendor) => Vendor(name: vendor.name, city: vendor.city, address: vendor.address, id: vendor.id)).toList();
                  return Expanded(
                    flex: 1,
                    child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                        final item = items[index];
                        return GestureDetector(
                          // TODO: Change item.id to number of active trays
                          child: VendorTile(item.name, item.id, item.address),
                          onTap: () => goToCurrentSession(),
                        );
                      }
                    )
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                // By default, show a loading spinner.
                return  Padding(
                  padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                  child: 
                    Align(
                    alignment: Alignment.center,
                    child: 
                      Container( 
                          height: 100,
                          width: 100,
                          child: CircularProgressIndicator()
                      )
                  )
                );
              },
          ),
        ],)
    );
  }
}