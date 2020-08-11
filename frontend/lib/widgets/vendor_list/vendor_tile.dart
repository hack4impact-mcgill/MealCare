import 'package:flutter/material.dart';
import 'package:frontend/widgets/vendor_list/badges/count_badge.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VendorTile extends StatelessWidget {

  final String title;
  final String address;
  final int itemCount;
  final double height;
  final Color backgroundColor;

  VendorTile(
    this.title,
    this.itemCount,
    this.address,
    {
        this.height = 77.0,
        this.backgroundColor = Colors.white
    }
  );

  @override
  Widget build(BuildContext context) {
    
    int displayCount = itemCount;
    if(itemCount > 25) {
      displayCount = 25;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container (
      height: height,
       color: Theme.of(context).primaryColor,
        child: 
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.fromLTRB(35, 10, 5, 5),
                        child: Text(title,
                          style: TextStyle(
                              fontSize: 16,
                            )
                          ),
                      ),
                      Padding(padding: EdgeInsets.fromLTRB(35, 2.5, 2.5, 2.5),
                        child:   
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: 
                          <Widget>[
                              Padding(padding: EdgeInsets.fromLTRB(2, 4, 2, 2),
                                child: SvgPicture.asset("assets/svg/Location.svg")
                              ),
                              Padding(padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
                                child: Text( address,
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w400
                                  )
                                )
                              )
                            ],
                          )
                      )
                  ],)
                ),
               CountBadge(displayCount)
              ],
            )
          ],
        )
      )
    );
  }
}
