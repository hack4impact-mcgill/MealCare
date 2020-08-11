import 'package:flutter/material.dart';

class MenuTile extends StatelessWidget {

  final String title;
  final double height;
  final EdgeInsets margin;
  final Color backgroundColor;

  MenuTile(
   this.title,
   {
      this.height = 54.0,
      this.margin = EdgeInsets.zero,
      this.backgroundColor = Colors.white
   }
  );

  @override
  Widget build(BuildContext context) {
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
            Padding(padding: EdgeInsets.fromLTRB(35, 5, 5, 5),
              child: 
                 Align(alignment: Alignment.centerLeft,
                  child: 
                    Text(title, textAlign: TextAlign.center,
                      style: 
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color.fromRGBO(84, 84, 84, 1))
                      )
                )
            )
          ],
        )
      )
    );
  }
}