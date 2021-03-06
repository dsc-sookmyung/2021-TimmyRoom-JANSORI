import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:timmyroom_jansori/record.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'SoundHelper.dart';
import 'alarmList.dart';
import 'models/sound_info.dart';
import 'page3.dart';
import 'page3.dart';
import "testTimer.dart";
import 'package:carousel_slider/carousel_slider.dart';
import "theme_data.dart";
import 'package:timmyroom_jansori/models/todo_info.dart';
import 'models/todo_info.dart';
import 'DBHelper.dart';
import 'data.dart';
import 'theme_data.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:quiver/async.dart';


class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  AudioCache player=new AudioCache();
  bool toggleValue = false;
  bool isOn = true;

  var sky = GradientTemplate.gradientTemplate[0].colors;
  var sunset = GradientTemplate.gradientTemplate[1].colors;
  var sea = GradientTemplate.gradientTemplate[2].colors;
  var mango = GradientTemplate.gradientTemplate[3].colors;
  var fire = GradientTemplate.gradientTemplate[4].colors;

  String clickedName = "할 일을 선택해주세요";

  int _duringTime=5;
  int _restTime=6;

  DBHelper _dbHelper = DBHelper();
  Future<List<ToDoInfo>> _toDos;
  List<ToDoInfo> _currentToDos;

  SoundHelper _sdHelper = SoundHelper();
  Future<List<SoundInfo>> _sounds;

  PageController pageController = PageController(initialPage: 0);
  int pageChanged = 0;

  @override
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
    _sounds = _sdHelper.getSounds();
    print("중요");
    print(_sounds);
    if(mounted) setState(() {});
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => MyApp(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 3.0); // <-
        var end = Offset.zero;
        var curve = Curves.ease;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(44, 44, 84, 1.0),
        appBar: GradientAppBar(
          elevation: 0,
          // 앱바 그림자 없애기
          title: Text('JANSORI',
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
          centerTitle: true,
          backgroundColorStart: Colors.white.withOpacity(0.1),
          backgroundColorEnd: Colors.white.withOpacity(0.0),
          actions: [
            IconButton(
              icon: Icon(Icons.music_note_sharp),
              onPressed: () => {Navigator.of(context).push(_createRoute())},
            )
          ],
        ),
        body: PageView(
          controller: pageController,
          onPageChanged: (index) {
            setState(() {
              pageChanged = index;
            });
            print(pageChanged);
          },
          children: [SafeArea(
            child: Center(
              child: Column(
                children: <Widget>[
                  // 여백
                  SizedBox(height: 100,),
                  // **************** 원 두개
                  Padding(

                    /*  * * ****  * * * * * * * * * *
                    **     스타트 클릭 >> 타이머 설정
                    */
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        print("STRRT 클릭");
                        duringStartTimer(
                            _duringTime, _duringTime, _restTime, _restTime);
                      },
                      child: Container(
                        // *********** 하얀 작은 원
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.5),
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
                            //mainAxisAlignment: MainAxisAlignment.center,
                            //crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(height: 85,),
                              Text(
                                clickedName,
                                style: TextStyle(
                                  color: Colors.black26,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                "START",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ),
                        ),

                        //************* 테두리
                        // 큰 원을 그린다
                        height: 260,
                        width: 260,

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
                  ),
                  SizedBox(height: 40,),

                  // ***************** 토글바
                  Container(
                    height: 55,
                    width: 140,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        gradient: LinearGradient(
                          colors: sky,
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                        ),
                        //color: Colors.white.withOpacity(0.9),
                        boxShadow: [
                          BoxShadow(
                            color: sky.last.withOpacity(0.2),
                            spreadRadius: 7, // 그림자 진하기 .. ?
                            blurRadius: 4, // 그림자 얼마나  blur
                            offset: Offset(0, 3),
                          ),
                        ]
                    ),

                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.5),
                          borderRadius: BorderRadius.all(Radius.circular(60)),
                          border: Border.all(
                              color: Colors.black12,
                              width: 3),
                          boxShadow: [
                            BoxShadow(
                              color: sky.first.withOpacity(0.2),
                              spreadRadius: 3,
                              blurRadius: 2,
                              offset: Offset(0, 3),
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
                                    SizedBox(width: 16),
                                    // Icon( Icons.block, color:Colors.grey, size:25),
                                    SizedBox(width: 8),
                                    Text("BLOCK",
                                        style: TextStyle(
                                            color: Colors.white.withOpacity(
                                                0.9))),
                                    Switch(
                                      value: isOn,
                                      onChanged: (bool value) {
                                        setState(() {
                                          isOn = value;
                                        });
                                      },
                                      activeTrackColor: Colors.black
                                          .withOpacity(0.2),
                                      activeColor: Colors.deepPurple
                                          .withOpacity(0.5),
                                    ),
                                  ]
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 70,),
                  // list view 그 .. 내 할일 목록이요

                  Expanded(
                    child: FutureBuilder<List<ToDoInfo>>(
                      future: _toDos,
                      builder: (context, snapshot,) {
                        if (snapshot.hasData) {
                          _currentToDos = snapshot.data;
                          if (_currentToDos.length == 0) {
                            Text("할일을 추가해주세요");
                          }
                          return ListView(
                              padding: EdgeInsets.only(left: 60),
                              scrollDirection: Axis.horizontal,
                              children: snapshot.data.map<Widget>((todo) {
                                return GestureDetector(
                                  onTap: () {
                                    print("container index:");
                                    clickedName = todo.name;
                                    setState(() {});
                                    print(clickedName);
                                  },
                                  child: Container(
                                      margin: const EdgeInsets.only(
                                          bottom: 50, left: 20, right: 20),
                                      //padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                      width: 250,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xFF6448FE),
                                            Color(0xFF5FC6FF)
                                          ],
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: sky.last.withOpacity(0.4),
                                            blurRadius: 8,
                                            spreadRadius: 2,
                                            offset: Offset(4, 4),
                                          ),
                                        ],
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(24)),
                                      ),
                                      child: Stack(
                                        children: <Widget>[
                                          Positioned.fill(
                                              right: -10,
                                              left: 150,
                                              top: -100,
                                              bottom: -150,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  //boxShadow: customShadow,
                                                    shape: BoxShape.circle,
                                                    color: Colors.white
                                                        .withOpacity(0.1)),)),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment
                                                .center,
                                            crossAxisAlignment: CrossAxisAlignment
                                                .center,
                                            children: <Widget>[
                                              SizedBox(height: 16,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .center,
                                                children: <Widget>[
                                                  Row(
                                                    children: <Widget>[
                                                      SizedBox(width: 8,),
                                                      Text(
                                                        todo.name,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight: FontWeight
                                                              .bold,
                                                          fontSize: 20,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .center,
                                                children: <Widget>[
                                                  Text(
                                                    'Jansori #1',
                                                    style: TextStyle(
                                                        color: Colors.yellow,
                                                        fontSize: 14),
                                                  ),

                                                  IconButton(
                                                      icon: Icon(Icons.delete),
                                                      color: Colors.white,
                                                      onPressed: () {
                                                        deleteToDo(todo.id);
                                                      }),
                                                ],
                                              )
                                            ],
                                          ),
                                        ],
                                      )
                                  ),
                                );
                              }).toList());
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 30,),
                ],
              ),
            ),
          ),
            page2(), MainPage3(),
          ],
        )
    );
  }
  toggleButton() {
    setState(() {
      toggleValue = !toggleValue;
    });
  }
  
  List names=["모델 돌리기","코딩하기","실컷 놀기","커피 먹기"];
  List isOns=[0,0,0,0];
  List duringTimes=[10,20,30,40];
  List restTimes=[11,22,33,44];

  void onSaveToDo() {
    for (int i = 0; i < 4; i++){
      var todoInfo = ToDoInfo(
        name: names[i],
        duringTime: duringTimes[i],
        restTime: restTimes[i],
        isOn: isOns[i],
      );
      _dbHelper.insertToDo(todoInfo);
      loadToDos();
    }
  }

  void deleteToDo(int id) {
    _dbHelper.delete(id);
    loadToDos();
  }

  List<BoxShadow> customShadow =[
    BoxShadow(
      color: Colors.black,
      spreadRadius: -5,
      offset: Offset(5,5),
      blurRadius: 30),
  ];

  _incrementCounter() async{ //타이머와 연결시켜야 함!
    SharedPreferences prefs=await SharedPreferences.getInstance();
    int counter=(prefs.getInt('counter')??0)+1;

    const alarmAudioPath="wakeup.m4a";
    player.play(alarmAudioPath);

    await prefs.setInt('counter',counter);
  }

  void restStartTimer(int start, int current){
    print("휴식시작");
    CountdownTimer countdownTimer = new CountdownTimer(
      new Duration(seconds: start),
      new Duration(seconds: 1),
    );

    // 휴식 시작오디오
    var startAudioPath="3.m4a";
    player.play(startAudioPath);

    var restTimer = countdownTimer.listen(null);
    restTimer.onData((duration) {
      setState(() {
        current = start - duration.elapsed.inSeconds;
      });
    });

    restTimer.onDone(() {
      print("   TIMES UP!   ");
      // 휴식 시간 끝
      var alarmAudioPath="4.m4a";
      player.play(alarmAudioPath);
      restTimer.cancel();
    });
  }


  void duringStartTimer(int dstart, int dcurrent, int rstart, int rcurrent) {
    print("타이머 시작");
    CountdownTimer countdownTimer = new CountdownTimer(
      new Duration(seconds: dstart),
      new Duration(seconds: 1),
    );

    AudioPlayer audioPlayer = AudioPlayer();
    // 학습   시작하면 시작했다고 알려주
    print(soundList[0]);
    var startAudioPath=soundList[0];
    audioPlayer.play(startAudioPath, isLocal: true);
    //player.play(startAudioPath);

    var duringTimer = countdownTimer.listen(null);
    duringTimer.onData((duration) {
      setState(() {
        dcurrent = dstart - duration.elapsed.inSeconds;
      });
    });

    duringTimer.onDone(() {
      print("   TIMES UP!   ");
      // 학습시간 끝
      var endAudioPath="2.m4a";
      audioPlayer.play(endAudioPath, isLocal: true);
      restStartTimer(rstart, rcurrent);
      duringTimer.cancel();
    });
  }
}

