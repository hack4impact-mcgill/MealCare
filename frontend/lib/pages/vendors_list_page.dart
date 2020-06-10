import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/http/server.dart';
import 'package:frontend/models/vendor.dart';
import 'package:frontend/widgets/progress.dart';

class VendorListPage extends StatefulWidget {
  static var routeName;

  @override
  _VendorListPageState createState() => _VendorListPageState();
}

class _VendorListPageState extends State<VendorListPage> {
  Vendor vendor;

  void goToFoodItemPage(Vendor v) {
    Navigator.of(context).pushNamed('/foodItemPage', arguments: v);
  }

  Container buildVendors(Vendor v) {
    return Container(
      width: double.infinity,
      child: GestureDetector(
        onTap: () {
          print(v.id);
          goToFoodItemPage(v);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text(
              v.name,
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2),
            ),
            Text(v.address),
            SizedBox(
              height: 25.0,
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final server = HttpClientService();
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 40.0),
            child: Text(
              "Vendors",
              textAlign: TextAlign.start,
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
          ),
          FutureBuilder(
              future: server.getAllVendors(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return somethingWrong();
                  case ConnectionState.active:
                    return circularProgress();
                  case ConnectionState.waiting:
                    return circularProgress();
                  case ConnectionState.done:
                    List<Vendor> v = snapshot.data;
                    // return circularProgress();
                    // return linearProgress();
                    return ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.only(top: 40, left: 40),
                      children: v.map((item) => buildVendors(item)).toList(),
                    );
                }
              }),
        ],
      ),
    );
  }
}
