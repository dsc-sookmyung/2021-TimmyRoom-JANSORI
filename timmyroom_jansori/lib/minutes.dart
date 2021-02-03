import 'package:flutter/material.dart';

import 'DBHelper.dart';

class minutes extends StatefulWidget{
  minutes({Key key}) : super(key: key);

  _minutesState createState() => _minutesState();
}

class _minutesState extends State<minutes>{
  String dropdownValue = '0';
  var m = List.generate(60, (index) => "$index");

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child:
        DropdownButton<String>(
          icon: Icon(
            Icons.arrow_drop_down,
          ),
          value: dropdownValue,
          iconSize: 20,
          elevation: 16,
          style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1), fontWeight: FontWeight.w700),
          underline: Container(
            width: 8,
            height: 2,
            color: Color.fromRGBO(93, 136, 248, 1),
          ),
          onChanged: (String newValue) {
            setState(() {
              dropdownValue = newValue;
              colDuringTime += int.parse(newValue);
            });
          },
          items: m.map((value) {
            return DropdownMenuItem(
              value: value,
              child: Text(value),
            );
          }).toList(),
        )
    );

  }
}