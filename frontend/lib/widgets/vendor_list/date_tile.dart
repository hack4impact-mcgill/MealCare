import 'package:flutter/material.dart';
import 'package:frontend/widgets/vendor_list/badges/count_badge.dart';

class DateTile extends StatelessWidget {

  final String date;
  final bool isActive;
  final double width;
  final double height;
  final int itemCount;
  final EdgeInsets margin;

  DateTile(
   this.date,
   this.isActive,
   this.itemCount,
   {
      this.width = 0.0,
      this.height = 0.0,
      this.margin = EdgeInsets.zero,
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
       height: 65,
       color: Theme.of(context).primaryColor,
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(flex: 4,
                    child: Padding(padding: EdgeInsets.fromLTRB(35, 
                    displayCount == 0 ? 5 : 25, 
                    5, 5),
                      child: Text(date,
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                        ),
                      ),
                  ),
                ),
                CountBadge(displayCount, small: true)
              ]
              )
            ],
          )
        ),
      );
  }
}
