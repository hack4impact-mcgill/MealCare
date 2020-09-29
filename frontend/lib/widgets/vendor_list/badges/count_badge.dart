import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CountBadge extends StatelessWidget {

  final int itemCount;

  final bool small;

  CountBadge(this.itemCount, {this.small = false});
  
  @override
  Widget build(BuildContext context) {
     return itemCount != 0 ? Expanded(flex: 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
              child: new Container(
                  width: 50,
                  height: small ? 50 : 62,
                  child: new Stack(
                  children: <Widget> [
                    new Positioned(
                          bottom: small ? 20 : 30,
                      child: SvgPicture.asset("assets/svg/inbox.svg"),
                    ),
                    new Positioned(
                      bottom: small ? 25 : 35,
                      left: small ? 14: 14,
                      child: ClipOval(
                          child: Material(
                            color: Colors.red, 
                            child: SizedBox(width: 24, height: 24,
                              child: Center(
                                  child: Text((itemCount).toString(),
                                  textAlign: TextAlign.center,
                                  style: 
                                    TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold
                                  ),
                                )
                              )) 
                            )
                      ), 
                    ),
                  ]
                )
              )
            )
          ]
        )
      ) : Text("");
  }

}