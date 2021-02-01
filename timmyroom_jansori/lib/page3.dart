import 'package:flutter/material.dart';



class Page3 extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: home()
    );
  }

  Widget home(){
    return Scaffold(
      body: popup()
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
                  width: 2,
                  color: Color.fromRGBO(93, 136, 248, 0.8),
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            child:
              Container(
                width: 255,
                margin: EdgeInsets.all(15),
                child:
                  timeSetting(),
              ),
          ),
    );
  }

  Widget timeSetting(){
    return Container(
      width: 255,
      // height: 103.25,
      /*
      decoration: BoxDecoration(
        border: Border.all(
        width: 2,
        color: Color.fromRGBO(93, 136, 248, 0.8),
      )),
      */
      child:
        Text(
          "시간 설정",
          style: TextStyle(
            fontFamily: 'Roboto',
            fontStyle: FontStyle.normal,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color.fromRGBO(4, 4, 7, 0.7),
            height: 1.4,
          ),
        ),
    );
  }
}
