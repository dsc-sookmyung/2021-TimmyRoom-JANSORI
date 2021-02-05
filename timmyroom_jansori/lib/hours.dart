import 'package:flutter/material.dart';

import 'DBHelper.dart';

class hours extends StatefulWidget{
  hours({Key key}) : super(key: key);

  _hoursState createState() => _hoursState();
}

class _hoursState extends State<hours>{
  String dropdownValue = '0';

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child:DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          icon: Icon(
            Icons.arrow_drop_down,
          ),
          iconEnabledColor: Colors.blue,
          value: dropdownValue,
          iconSize: 20,
          elevation: 16,
          style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1), fontWeight: FontWeight.w700),
          underline: Container(
            width: 4,
            height: 2,
            color: Color.fromRGBO(93, 136, 248, 1),
          ),
          onChanged: (String newValue) {
            setState(() {
              dropdownValue = newValue;
              var a = int.parse(newValue) * 60;
              colDuringTime = a.toString();
              print('succeeded 1');
            });
          },
          items: <String>['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        )
    ));

  }
}