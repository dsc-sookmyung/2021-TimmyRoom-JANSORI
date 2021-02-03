import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
// import "timer.dart";
import 'package:carousel_slider/carousel_slider.dart';
import "theme_data.dart";
import 'package:timmyroom_jansori/models/todo_info.dart';
import 'models/todo_info.dart';
import 'DBHelper.dart';
import 'data.dart';
import 'theme_data.dart';


class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  bool toggleValue = false;
  bool isOn = true;

  var sky = GradientTemplate.gradientTemplate[0].colors;
  var sunset = GradientTemplate.gradientTemplate[1].colors;
  var sea = GradientTemplate.gradientTemplate[2].colors;
  var mango = GradientTemplate.gradientTemplate[3].colors;
  var fire = GradientTemplate.gradientTemplate[4].colors;

  String clickedName = "할 일을 선택해주세요";

  DBHelper _dbHelper = DBHelper();
  Future<List<ToDoInfo>> _toDos;
  List<ToDoInfo> _currentToDos;

  @override
  void initState(){
    print("시작");
    // print(_dbHelper.database); Future<Database>
    _dbHelper.initDB().then((value) {
      print('-----------datata intialized---------');
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
      backgroundColor: Color.fromRGBO(44, 44, 84, 1.0),
        body: SafeArea(
            child: Center(
              child: Column(
                children: <Widget>[
                  // 여백
                  SizedBox(height: 130,),
                  // **************** 원 두개
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      // *********** 하얀 작은 원
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white60,
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Colors.black12,
                                width: 2),
                            boxShadow: [
                              BoxShadow(
                                color: sky.last.withOpacity(0.4),
                                spreadRadius: 10, // 그림자 진하기 .. ?
                                blurRadius: 7, // 그림자 얼마나  blur
                                offset: Offset(0, 3),
                              ),
                            ]
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              clickedName,
                              style: TextStyle(
                                color: Colors.black26,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              "START",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),
                      //************* 테두리
                      // 큰 원을 그린다
                      height: 220,
                      width: 220,

                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: sky,
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        //color: Colors.white.withOpacity(0.9),
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: Colors.black12,
                              width: 11),
                          boxShadow: [
                            BoxShadow(
                              color: sky.last.withOpacity(0.2),
                              spreadRadius: 7, // 그림자 진하기 .. ?
                              blurRadius: 4, // 그림자 얼마나  blur
                              offset: Offset(0, 3),
                            ),
                          ]
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  /* 토글 바
                  AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      height: 35.0,
                      width: 80.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: toggleValue ? Colors.blueGrey.withOpacity(0.4) :
                          Colors.black12
                      ),
                      child: Stack(
                          children: <Widget>[
                            AnimatedPositioned(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.linear,
                                top: 2.5,
                                left: toggleValue ? 40.0 : 0.0,
                                right: toggleValue ? 0.0 : 40.0,
                                child: InkWell(
                                  onTap: toggleButton,
                                  child: AnimatedSwitcher(
                                    duration: Duration(milliseconds: 500),
                                    transitionBuilder:
                                        (Widget child, Animation<double> animation) {
                                      return SlideTransition(
                                          position: Tween(
                                            begin: Offset(0.0,0.0),
                                            end: Offset(0.0,0.0))
                                              .animate(animation),
                                        child: child
                                      );
                                      //return RotationTransition(child: child, turns: animation);
                                    },


                                    child: toggleValue?
                                    (Icon(Icons.check_circle, color: Colors.blueGrey, size: 30.0,
                                    key: UniqueKey())
                                    )
                                    :
                                    Icon(Icons.remove_circle_outline, color: Colors.red, size: 30.0,
                                    key: UniqueKey())
                                  ),
                                )
                            )
                          ]
                      )
                  ),

                  SizedBox(height:5,),
                   */

                  // ***************** 토글바
                  Container(
                    height: 50,
                    width: 175,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.08),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                          color: sky.first.withOpacity(0.2),
                          spreadRadius: 7,
                          blurRadius: 4,
                          offset:Offset(0,3),
                        ),
                      ]
                    ),


                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                                children: <Widget>[
                                  SizedBox(width: 8),
                                  Icon( Icons.block, color:Colors.white, size:25),
                                  SizedBox(width: 8),
                                  Text("block mode",
                                    style: TextStyle(color:Colors.white)),
                                  Switch(
                                    value: isOn,
                                    onChanged: (bool value) {
                                      setState(() {
                                        isOn = value;
                                        print(isOn);
                                      });
                                    },
                                    activeTrackColor: Colors.grey,
                                    activeColor: Color(0xFF6448FE),
                                  ),
                                ]
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 80,),
                  // list view 그 .. 내 할일 목록이요

                  Expanded(
                    child: FutureBuilder<List<ToDoInfo>>(
                      future: _toDos,
                      builder: (context, snapshot,) {
                        if (snapshot.hasData) {
                          _currentToDos = snapshot.data;
                          print(snapshot.data);
                          return ListView(
                              scrollDirection: Axis.horizontal,
                              children: snapshot.data.map<Widget>((todo) {
                                return GestureDetector(
                                  onTap: (){
                                    print("container index:" );
                                    clickedName = todo.name;
                                    setState(() {});
                                    print(clickedName);
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 50, left: 32, right: 32),
                                    padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                    width: 250,
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
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 20,
                                                    ),
                                                  ),
                                                ],
                                              ),

                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                'delete Item',
                                                style: TextStyle(
                                                  color: Colors.yellow,
                                                  fontSize: 14),
                                              ),
                                              IconButton(
                                                icon: Icon(Icons.delete),
                                                color: Colors.white,
                                                onPressed: (){
                                                  deleteToDo(todo.id);
                                                }),
                                            ],
                                          )
                                        ],
                                      )
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
                ],
              ),
              ),
            ),
        );
  }
  toggleButton() {
    setState(() {
      toggleValue = !toggleValue;
    });
  }
  void onSaveToDo() {
    loadToDos();
  }

  void deleteToDo(int id) {
    _dbHelper.delete(id);
    loadToDos();
  }
}

