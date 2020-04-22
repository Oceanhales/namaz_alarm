import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget alarmItem(hour, enabled, name ){
  return Padding(
    padding: EdgeInsets.all(17.0),
    child: Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(name, style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'SourceSansPro'
                ),),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Text(hour, style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600
                      ),),
                    ),
                  ],
                ),
              ],
            ),
            CupertinoSwitch(
              value: enabled,
              onChanged: (bool val) {
                print(val);
              },                    
              activeColor: Color(0xff65D1BA),
            ),
          ],
        ),
      ],
    ),
  );
}