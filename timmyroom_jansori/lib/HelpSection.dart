/*
import 'dart:math';
import 'package:flutter/material.dart';
import 'models/todo_info.dart';
import 'DBHelper.dart';
import 'data.dart';
import 'theme_data.dart';

class HelpSection extends StatefulWidget {
  @override
  _HelpSectionState createState() => _HelpSectionState();
}

class _HelpSectionState extends State<HelpSection> {
  double _spreadRadius = 2;
  double _blurRadius = 7;

  var sky = GradientTemplate.gradientTemplate[0].colors;
  var sunset = GradientTemplate.gradientTemplate[1].colors;
  var sea = GradientTemplate.gradientTemplate[2].colors;
  var mango = GradientTemplate.gradientTemplate[3].colors;
  var fire = GradientTemplate.gradientTemplate[4].colors;
  DBHelper _dbHelper = DBHelper();
  Future<List<ToDoInfo>> _toDos;
  List<ToDoInfo> _currentToDos;


  @override
  void initState(){
    print("시작");
    // print(_dbHelper.database); Future<Database>
    _dbHelper.initDB().then((value) {
      print('-----------datata intialized');
      loadToDos();
    });
    super.initState();
  }

  void loadToDos() {
    _toDos = _dbHelper.getToDos();
    if(mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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

          Text(
            '내 목록',
            style: TextStyle(
                fontFamily: 'avenir',
                fontWeight: FontWeight.w700,
                color: Colors.blue,
                fontSize: 24),
          ),

          Expanded(
            child: FutureBuilder<List<ToDoInfo>>(
              future: _toDos,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  _currentToDos = snapshot.data;
                  print("이건가");
                  print(snapshot.data);
                  return ListView(
                    scrollDirection: Axis.horizontal,
                    children: snapshot.data.map<Widget>((todo) {
                      return Container(
                        //margin: const EdgeInsets.only(bottom: 32),
                        //padding: const EdgeInsets.symmetric(
                            //horizontal: 16, vertical: 8),
                        width: 160,
                        height: 40,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: sky,
                            begin: Alignment.centerLeft,
                            end:  Alignment.centerRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: sky.last.withOpacity(0.4),
                              blurRadius: 8,
                              spreadRadius: 2,
                              offset: Offset(4, 4),
                            ),
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(24)),
                        ),
                        child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Icon(
                                        Icons.label,
                                        color: Colors.purple,
                                        size:20),
                                    Text(
                                      todo.name,
                                      style: TextStyle(
                                        color: Colors.black),
                                      ),
                                  ],
                                ),

                              ],
                            ),
                            Text(
                              'Mon-Fri',
                              style: TextStyle(
                                  color: Colors.black),
                            ),
                          ],
                        )
                      );
                    }).followedBy([
                        FloatingActionButton.extended(
                            onPressed: onSaveToDo,
                            icon: Icon(Icons.alarm),
                            label: Text('save'),
                        )
                    ]).toList()
                  );
                } else {
                  print("없다");
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Error: ${snapshot.error}',
                      style: TextStyle(fontSize: 15),
                    )
                  );
                }
              },

            ),
          ),









          /*
          FutureBuilder(
              future: DBHelper().getToDos(),
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
                          DBHelper().delete(item.id);
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
          */


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





          //그냥 상자들
          /*
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
           */
          SizedBox(height: 30,),
          Text('Copyright (c) 2020 TimmyRoom'),
          Text('All rights reserved')
        ],
      ),
    );
  }

  void onSaveToDo() {
    var todoInfo = ToDoInfo(
      name: 'studying',
      duringTime: 40,
      restTime: 10,
    );
    _dbHelper.insertToDo(todoInfo);
    print("저장저장 ");
    loadToDos();
  }
}


 */