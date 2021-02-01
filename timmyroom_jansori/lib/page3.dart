import 'package:flutter/cupertino.dart';
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      timeSetting(),
                      nameSetting(),
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
                          height: 1.4,
                        ),
                      ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(9, 0, 0, 0),
                        child:
                          Text(
                            "집중 타임 (시간)",
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 13,
                              color: Color.fromRGBO(4, 4, 7, 0.7),
                              height: 1.5,
                            ),
                          ),
                        ),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 14.5, 0),
                        child:
                        Text(
                          "휴식 타임 (분)",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 13,
                            color: Color.fromRGBO(4, 4, 7, 0.7),
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "09:20",
                        style: TextStyle(
                          fontFamily: 'RobotoMono',
                          fontSize: 35,
                          color: Color.fromRGBO(0, 0, 0, 1),
                          shadows: [
                            Shadow(
                              offset: Offset(0, 4),
                              blurRadius: 4,
                              color: Color.fromRGBO(0, 0, 0, 0.25),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "10:00",
                        style: TextStyle(
                          fontFamily: 'RobotoMono',
                          fontSize: 35,
                          color: Color.fromRGBO(0, 0, 0, 1),
                          shadows: [
                            Shadow(
                              offset: Offset(0, 4),
                              blurRadius: 4,
                              color: Color.fromRGBO(0, 0, 0, 0.25),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
          ),
    );
  }

  Widget nameSetting(){
    return Container(
      child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 7),
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
              child:
                Text(
                  "쎈 수학 B단계",
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontStyle: FontStyle.normal,
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(0, 0, 0, 1),
                  ),
                ),
            ),
          ],
        ),
    );
  }

}
