import 'package:flutter/material.dart';

import 'DBHelper.dart';

class free extends StatefulWidget{
  free({Key key}) : super(key: key);

  _freeState createState() => _freeState();
}

class _freeState extends State<free>{
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
              colRestTime = newValue;
              print('succeeded 3');
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