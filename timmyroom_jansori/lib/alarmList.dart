import 'package:flutter/material.dart';
import 'theme_data.dart';
import 'package:timmyroom_jansori/models/todo_info.dart';
import 'models/todo_info.dart';
import 'DBHelper.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'page3.dart';

class page2 extends StatefulWidget {
  @override
  _page2State createState() => _page2State();
}

class _page2State extends State<page2> {
  var sky = GradientTemplate.gradientTemplate[0].colors;
  var sunset = GradientTemplate.gradientTemplate[1].colors;
  var sea = GradientTemplate.gradientTemplate[2].colors;
  var mango = GradientTemplate.gradientTemplate[3].colors;
  var fire = GradientTemplate.gradientTemplate[4].colors;

  String _idString;
  String _duringTimeString;
  String _restTimeString;


  DBHelper _dbHelper = DBHelper();
  Future<List<ToDoInfo>> _toDos;
  List<ToDoInfo> _currentToDos;

  var _isOn = 1;

  void initState(){
    // print(_dbHelper.database); Future<Database>
    _dbHelper.initDB().then((value) {
      print('-----------datata intialized---------');
      loadToDos();
    });
    super.initState();
  }

  void loadToDos() {
    _toDos = _dbHelper.getToDos();
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        elevation: 0, // 앱바 그림자 없애기
        title: Text('list',
          style: TextStyle(color: Colors.white.withOpacity(0.8)),),
        centerTitle : true,
        backgroundColorStart: Colors.white.withOpacity(0.0),
        backgroundColorEnd: Colors.white.withOpacity(0.1),
      ),
      backgroundColor: Color.fromRGBO(44, 44, 84, 1.0),
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              Expanded(
                child: FutureBuilder<List<ToDoInfo>> (
                  future: _toDos,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      _currentToDos = snapshot.data;
                      return ListView(
                          //shrinkWrap: true,
                        children: snapshot.data.map<Widget>((todo) {
                        String onOffImg;
                        return GestureDetector(
                          onTap: () {
                            print(todo.id); // 나중엔 수정하는 뭐 뜨게 ㅇㅇ
                          },
                          // **************************** 할일 목록
                          child: Container(
                            margin: EdgeInsets.only(
                                bottom: 16, left: 20.0, right: 20.0),
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(26),
                              gradient: LinearGradient(
                                colors: [Color(0xFF6448FE).withOpacity(0.5), Color(0xFF5FC6FF)],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              boxShadow: [
                                BoxShadow(
                                    color: sky.last.withOpacity(0.4),
                                    blurRadius: 8,
                                    spreadRadius: 2,
                                    offset: Offset(3, 3)),
                              ],
                            ),
                            //width: MediaQuery.of(context).size.width,
                            ///// 이게 박스안에 들어가는 애들 이어야한다.
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    // * * * * * * ** * * * 박스 안 아이템들  * * * * ** * * * * * *
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          GestureDetector(
                                            onTap: () {
                                              if(todo.isOn == 1){
                                                onUpdateIsOn(todo.id, 0);
                                              } else {
                                                onUpdateIsOn(todo.id, 1);
                                              }
                                              setState(() {});
                                            },
                                            child: CircleAvatar(
                                              radius: 30,
                                              backgroundColor: Colors.white.withOpacity(0.1),
                                              foregroundColor: Colors.white.withOpacity(0.1),
                                              backgroundImage: todo.isOn == 1 ? AssetImage("images/sound_on.png"):AssetImage("images/sound_off2.png"),
                                            ),

                                          ),

                                        ],
                                      ),
                                      SizedBox(width: 10.0),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            todo.name,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            'jansori #0',
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text("집중 타임",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10.0)),
                                      Text(
                                          "${todo.duringTime.toString()}" + "분",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold)),
                                      Text("휴식 타임",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10.0)),
                                      Text("${todo.restTime.toString()}" + "분",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).followedBy([
                          FloatingActionButton.extended(
                            onPressed: onSaveToDo,
                            icon: Icon(Icons.alarm),
                            label: Text('save'),
                          ),
                        ]).toList()
                      );

                    } else {
                      return CircularProgressIndicator();
                    }
                    ;
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void onUpdateIsOn(int id, int value){
    _dbHelper.updateIsOn(id, value);
    loadToDos();
  }
  onSaveToDo() {
    print("팝업창나와라");
    return MainPage3();
  }
}

