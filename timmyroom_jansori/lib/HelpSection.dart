import 'dart:math';

import 'package:flutter/material.dart';
import 'models/todo_info.dart';
import 'DBHelper.dart';
import 'data.dart';


class HelpSection extends StatefulWidget {
  @override
  _HelpSectionState createState() => _HelpSectionState();
}

class _HelpSectionState extends State<HelpSection> {
  @override
  Widget build(BuildContext context) {
    double _spreadRadius = 2;
    double _blurRadius = 7;

    Future<List<ToDoInfo>> _toDos;
    List<ToDoInfo> _currentToDos;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0, // 앱바 그림자 없애기
        title: Text('Contact Us',
          style: TextStyle(color: Colors.lightBlue),),
          centerTitle : true,
      ),
      body: Column(
        children: <Widget>[ // 이 순서대로 생김 sizedbox는 margin 느낌
          SizedBox(height: 40, ),
          //Center(child: Image.asset('images/door-opened.png', height: 150,)),
          // 여기에 데이터 뜨게하기

          FutureBuilder(
              future: DBHelper().getAllToDos(),
              builder: (BuildContext context, AsyncSnapshot<List<ToDoInfo>> snapshot) {

                if (snapshot.hasData) {
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      ToDoInfo item = snapshot.data[index];
                      return Dismissible(
                        key: UniqueKey(),
                        onDismissed: (direction) {
                          DBHelper().deleteToDos(item.id);
                          setState(() {});
                        },
                        child: Center(child: Text(item.name)),
                      );
                    },
                  );
                }
                else {
                  return Center(child: CircularProgressIndicator(),);
                }
              },
          ),

          /*
          SizedBox(height: 20,),

          Text(
            'Have an issue or query? \n Feel free to contact us',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 17, color: Colors.grey[800]),
          ),
          */

          SizedBox(height: 30,),
          // DB연동상자들
          Row(
            // 상자들을 가운대로 옮긴다.
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap:(){
                      print("delete click");
                      DBHelper().deleteAllToDos();
                      setState(() {});
                    },
                    child: Container( // 큰 박스
                      // container 안에 padding을 주면 글씨 시작 위치가 바뀜
                      // padding: const EdgeInsets.all(8.0),
                      height: 100,
                      width: 150,

                      // 그림자를 주자
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            spreadRadius: _spreadRadius, // 그림자 진하기 .. ?
                            blurRadius: _blurRadius, // 그림자 얼마나  blur
                            offset: Offset(0,3),
                          ),
                        ]
                      ),

                      // color: Colors.white,
                      // child: Text('test') 이 박스 안에 뭘 더 넣고 싶다.
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.analytics_outlined, color: Colors.orange, size: 50),
                          Text("Delete data", style:TextStyle(color: Colors.orange)),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      print('click');
                      ToDoInfo toDo = toDos[Random().nextInt(toDos.length)];
                      DBHelper().insertToDo(toDo);
                      setState((){});
                    },

                    child: Container(
                      height: 100,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.4),
                              spreadRadius: _spreadRadius, // 그림자 진하기 .. ?
                              blurRadius: _blurRadius, // 그림자 얼마나  blur
                              offset: Offset(0,3),
                            ),
                          ]
                      ),
                      //child: Text('test'),
                      child: Column(
                        // 박스 안에 아이템들 정렬
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          // https://api.flutter.dev/flutter/material/Icons-class.html
                          Icon(Icons.account_circle_outlined, color: Colors.orange, size: 50),
                          Text("insert data", style:TextStyle(color: Colors.orange)),
                          Text("제발제발제발 !")
                        ],
                      ),
                    ),
                  ),
                ),
              ]
          ),

          //그냥 자들
          Row(
            // 상자들을 가운대로 옮긴다.
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container( // 큰 박스
                    // container 안에 padding을 주면 글씨 시작 위치가 바뀜
                    // padding: const EdgeInsets.all(8.0),
                    height: 100,
                    width: 150,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            spreadRadius: _spreadRadius, // 그림자 진하기 .. ?
                            blurRadius: _blurRadius, // 그림자 얼마나  blur
                            offset: Offset(0,3),
                          ),
                        ]
                    ),
                    // child: Text('test') 이 박스 안에 뭘 더 넣고 싶다.
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.announcement_outlined, color: Colors.orange, size: 50),
                        Text("if you have any qeustion", style:TextStyle(color: Colors.orange)),
                        Text("let us know")
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 100,
                    width: 150,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            spreadRadius: _spreadRadius, // 그림자 진하기 .. ?
                            blurRadius: _blurRadius, // 그림자 얼마나  blur
                            offset: Offset(0,3),
                          ),
                        ]
                    ),
                    //child: Text('test'),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // https://api.flutter.dev/flutter/material/Icons-class.html
                        Icon(Icons.app_blocking_outlined, color: Colors.orange, size: 50),
                        Text("block mode", style:TextStyle(color: Colors.orange)),
                        Text("on", textAlign: TextAlign.center)
                      ],
                    ),
                  ),
                ),
              ],
          ),
          SizedBox(height: 30,),
          Text('Copyright (c) 2020 TimmyRoom'),
          Text('All rights reserved')
        ],
      ),
    );
  }
}
