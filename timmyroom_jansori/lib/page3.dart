import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'year_month_day_time_picker.dart';



class Page3 extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: home()
    );
  }

  Widget home(){
    return Scaffold(
      body: popup(),
    );
  }

  Widget popup(){
    return Center(
      child:
          Container(
            width: 285,
            height: 450,
            decoration:
              BoxDecoration(
                border: Border.all(
                  width: 0.8,
                  color: Color.fromRGBO(93, 136, 248, 0.8),
                  // color: Color.fromRGBO(4, 4, 7, 0.2),
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
            child:
              Container(
                width: 255,
                margin: EdgeInsets.all(15),
                child:
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      timeSetting(),
                      nameSetting(),
                      jansoriSetting(),
                    ],
                  ),
              ),
          ),
    );
  }

  Widget timeSetting(){
    return Container(
      width: 255,
      margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
      child:
          Container(
            child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 16),
                    child:
                      Text(
                        "시간 설정",
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontStyle: FontStyle.normal,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color.fromRGBO(4, 4, 7, 0.7),
                          // color: Color.fromRGBO(56, 110, 218, 1),
                          height: 1.4,
                        ),
                      ),
                  ),
                  YearMonthPicker(),
                ],
               ),
          ),
    );
  }

  Widget nameSetting(){
    FocusNode myFocusNode = new FocusNode();

    return Container(
      child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child:
              Text(
                "이름 설정",
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontStyle: FontStyle.normal,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color.fromRGBO(4, 4, 7, 0.7),
                  height: 1.4,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child:
                  TextField(
                      focusNode: myFocusNode,
                      style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                      ),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '일정 이름을 입력해주세요',
                        labelStyle: TextStyle(
                          fontSize: 13,
                          color: myFocusNode.hasFocus ? Color.fromRGBO(56, 110, 218, 1) : Color.fromRGBO(4, 4, 7, 0.7),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color.fromRGBO(56, 110, 218, 1)),
                        ),
                      )
                  ),
            ),
          ],
        ),
    );
  }

  Widget jansoriSetting(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
          child:
            Text(
              "잔소리 설정",
              style: TextStyle(
                fontFamily: 'Roboto',
                fontStyle: FontStyle.normal,
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Color.fromRGBO(4, 4, 7, 0.7),
                height: 1.4,
              ),
            ),
        ),
        Container(
          height: 103.5,
          decoration: BoxDecoration(
            border: Border.all(
              color: Color.fromRGBO(93, 136, 248, 0.8),
            ),
          ),
          child:
            ListView(),
        ),
      ],
    );
  }
}
