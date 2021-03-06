import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timmyroom_jansori/models/sound_info.dart';
import 'SoundHelper.dart';
import 'theme_data.dart';
import 'alarmList.dart';
import 'hours.dart';
import 'main.dart';
import 'minutes.dart';
import 'free.dart';
import 'data.dart';
import 'DBHelper.dart';
import './models/todo_info.dart';
import 'startPage.dart';
import 'pageSlider.dart';

// import 'year_month_day_time_picker.dart';

class MainPage3 extends StatefulWidget{
  Page3 createState()=> Page3();
}

class Page3 extends State<MainPage3>{
  final _formKey = GlobalKey<FormState>();

  var sky = GradientTemplate.gradientTemplate[0].colors;
  var sunset = GradientTemplate.gradientTemplate[1].colors;
  var sea = GradientTemplate.gradientTemplate[2].colors;
  var mango = GradientTemplate.gradientTemplate[3].colors;
  var fire = GradientTemplate.gradientTemplate[4].colors;

  SoundHelper _dbHelper = SoundHelper();
  Future<List<SoundInfo>> _sounds; // _toDOs
  List<SoundInfo> _currentSounds; // _currentToDos

  void initState(){
    // print(_dbHelper.database); Future<Database>
    _dbHelper.initDB().then((value) {
      print('-----------page3 DB OK---------');
      loadSounds();
    });
    super.initState();
  }

  void loadSounds() {
    _sounds = _dbHelper.getSounds();
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color.fromRGBO(44, 44, 84, 1.0),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 60,),
                Container(
                  width: 300,
                  height: 620,
                  decoration:
                  BoxDecoration(
                    //color: Colors.white.withOpacity(0.1),
                    gradient: LinearGradient(
                      colors: [Color(0xFF6448FE).withOpacity(0.2), Color(0xFF5FC6FF).withOpacity(0.3)],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF6448FE).withOpacity(0.2),
                        spreadRadius: 10, // 그림자 진하기 .. ?
                        blurRadius: 7, // 그림자 얼마나  blur
                        offset: Offset(0, 3),
                      ),
                    ],
                    border: Border.all(
                      width: 4,
                      color: Colors.grey.withOpacity(0.1),
                      // color: Color.fromRGBO(93, 136, 248, 0.8),
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child:
                  Container(
                    width: 255,
                    margin: EdgeInsets.all(15),
                    child:
                    Form(
                      key: _formKey,
                      child:
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          timeSetting(),
                          nameSetting(),
                          /// 여기에 들어가야한다.
                          ///
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 20, 0, 15),
                            child:
                            Text(
                              "잔소리 설정",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Roboto',
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                height: 1.4,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                            height: 160,
                            decoration: BoxDecoration(
                              border: Border.all(
                                //color: Color.fromRGBO(4, 4, 7, 0.5),
                                color: Colors.white.withOpacity(0.1),
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                  child: FutureBuilder<List<SoundInfo>> (
                                    future: _sounds,
                                    builder: (context, snapshot) {
                                      if(snapshot.hasData){
                                        _currentSounds= snapshot.data;
                                        return ListView(
                                            children: snapshot.data.map<Widget>((sound) {
                                              return GestureDetector(
                                                  onTap: () {
                                                    print(sound.id);
                                                  },
                                                  child: Container(
                                                      margin: EdgeInsets.fromLTRB(10, 0.5, 10, 1),
                                                      height: 30,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(10),
                                                        gradient: LinearGradient(
                                                          colors: [Color(0xFF61A3FE).withOpacity(0.5), Color(0xFF63FFD5).withOpacity(0.5)],
                                                          begin: Alignment.centerLeft,
                                                          end: Alignment.centerRight,
                                                        ),
                                                        boxShadow: [
                                                          BoxShadow(
                                                              color: Colors.white.withOpacity(0.1),
                                                              blurRadius: 0.05,
                                                              spreadRadius: 2,
                                                              offset: Offset(0, 1)),
                                                        ],
                                                      ),
                                                      child : Row (
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: <Widget>[
                                                            Text("잔소리 #${sound.id+1}",
                                                            style: TextStyle( color: Colors.white.withOpacity(0.9))),
                                                            
                                                          ]
                                                      )
                                                  )
                                              );
                                            }).followedBy([
                                              GestureDetector(
                                                onTapDown: (TapDownDetails details){
                                                    onSaveSound();
                                                    print("녹음시작 ");
                                                    },
                                                onTapUp: (TapUpDetails details){
                                                  print("녹음 끝");
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.fromLTRB(10, 1, 10, 0.05),
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                    //color: Colors.white.withOpacity(0.1),
                                                    gradient: LinearGradient(colors: [Color(0xFFFFA738).withOpacity(0.3), Color(0xFFFFE130).withOpacity(0.3)], begin: Alignment.bottomCenter, end: Alignment.topCenter,),
                                                    border: Border.all(width: 1, color: Colors.grey.withOpacity(0.1),),
                                                    borderRadius: BorderRadius.all(
                                                      Radius.circular(40),
                                                    ),
                                                  ),
                                                  child : Center(child:
                                                  Text("RECORDING",
                                                    style: TextStyle(color: Colors.white.withOpacity(0.8)),)
                                                  ),
                                                ),
                                              ),
                                            ]).toList()
                                        );
                                      } else {
                                        return CircularProgressIndicator();
                                      }
                                    },
                                  ),
                                ),
                              ],
                            )
                          ),

                          submitButton(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
      ),
    );
  }

  submit() {
    final FormState form = _formKey.currentState;

    form.save();
    print('saved $colDuringTime, $colRestTime, $colName.');

    DBHelper _dbHelper = DBHelper();
    var todoInfo = ToDoInfo(
      name: colName,
      duringTime: int.parse(colDuringTime),
      restTime: int.parse(colRestTime),
    );
    _dbHelper.insertToDo(todoInfo);
    print(colName);
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => StartPage()), (route) => false);
  }

  Widget submitButton(){
    return Column(
      children: [
        SizedBox(height: 10.0),
        GestureDetector(
          onTap: (){
            submit();
        },
          child : Container(
            width: 260,
            height: 50,
            decoration:
              BoxDecoration(
              gradient: LinearGradient(colors: [Color(0xFFFE6197).withOpacity(0.3), Color(0xFFFFB463).withOpacity(0.2)], begin: Alignment.bottomCenter, end: Alignment.topCenter,),
              border: Border.all(
              width: 1,
              color: Colors.black.withOpacity(0.1),
          // color: Color.fromRGBO(93, 136, 248, 0.8),
              ),
              borderRadius: BorderRadius.all(Radius.circular(20),),
              ),
              child: Center(
                child: Text('Submit',style: TextStyle
                (fontSize: 20.0,color:Colors.white.withOpacity(0.8),
                    fontWeight: FontWeight.bold),),
              ),
            ),
          ),
      ],
    );
  }

  Widget timeSetting(){
    colDuringTime = 'duringTime';
    return Container(
      width: 255,
      margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
      child:
      Container(
        child:
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              // ********* 시간 설정
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
                  color: Colors.white,
                  //color: Color.fromRGBO(4, 4, 7, 0.7),
                  // color: Color.fromRGBO(56, 110, 218, 1),
                  height: 1.4,
                ),
              ),
            ),
            Container(
              child: Row(
                children: [
                // ********* * * * * ** * 집중시간 ********* * * * * ** *
                  Expanded(
                    flex: 2,
                    child:
                    Container(
                      decoration:
                      BoxDecoration(
                        //color: Colors.white.withOpacity(0.1),
                        //gradient: LinearGradient(colors: [Color(0xFFFFA738).withOpacity(0.3), Color(0xFFFFE130).withOpacity(0.3)], begin: Alignment.bottomCenter, end: Alignment.topCenter,),
                        border: Border.all(
                        width: 3,
                        color: Colors.grey.withOpacity(0.2),
                        // color: Color.fromRGBO(93, 136, 248, 0.8),
                      ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(40),
                        ),
                      ),
                      height: 70,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                            child:
                            Text(
                              "집중 타임",
                              style: TextStyle(fontSize: 12, color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child:
                            Container(
                              height: 40,
                              //color: Colors.amber,
                              child:
                              Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.fromLTRB(4, 0, 0, 0),
                                  ),
                                  hours(),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(10, 0, 15, 0),
                                    child: Text("시간", style: TextStyle(fontWeight: FontWeight.bold, color:Colors.white)),
                                  ),
                                  minutes(),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: Text("분", style: TextStyle(fontWeight: FontWeight.bold, color:Colors.white)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // ********* * * * * ** * 휴식 시간 *  * **** ** ******
                  Expanded(
                    flex: 1,
                    child:
                    Container(
                        height: 70,
                        decoration:
                        BoxDecoration(
                          //color: Colors.white.withOpacity(0.1),
                          //gradient: LinearGradient(colors: [Color(0xFFFFA738).withOpacity(0.3), Color(0xFFFFE130).withOpacity(0.3)], begin: Alignment.bottomCenter, end: Alignment.topCenter,),
                          border: Border.all(
                            width: 2,
                            color: Colors.grey.withOpacity(0.2),
                            // color: Color.fromRGBO(93, 136, 248, 0.8),
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(40),
                          ),
                        ),
                        // color: Colors.amber,
                        child: Column(
                          children: [
                            Container(
                              child:
                              Text(
                                "휴식 타임",
                                style: TextStyle(fontSize: 12, color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child:
                              Container(
                                height: 50,
                                child:
                                Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.fromLTRB(11, 0, 0, 0),
                                    ),
                                    free(),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      child: Text("분", style: TextStyle(fontWeight: FontWeight.bold, color:Colors.white)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                    ),
                  ),
                ],
              ),
            ),
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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //crossAxisAlignment: CrossAxisAlignment.start,
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
                color:Colors.white,
                height: 1.4,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
            child:
            TextFormField(
              focusNode: myFocusNode,
              style: TextStyle(
                //color: Color.fromRGBO(0, 0, 0, 1),
                  color: Colors.white.withOpacity(0.8),
              ),
              decoration: InputDecoration(
                fillColor: Colors.white,
                focusColor: Colors.white,

                border: OutlineInputBorder(),
                labelText: '일정 이름을 입력해주세요',
                labelStyle: TextStyle(
                  fontSize: 13,
                  color: myFocusNode.hasFocus ? Color.fromRGBO(56, 110, 218, 1) : Colors.white.withOpacity(0.7),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromRGBO(56, 110, 218, 1)),
                ),
              ),
              onSaved: (val) => colName = val,
            ),
          ),
        ],
      ),
    );
  }

  void deleteSound(int id){
      _dbHelper.deleteSound(id);
      loadSounds();
  }

  void onSaveSound(){
    // for(int i = 0; i < 4; i++){
    //   var soundInfo = SoundInfo(
    //     id: i,
    //   );
    //
    //   _dbHelper.insertSound(soundInfo);
    //   loadSounds();
    // }
  }


  onAudioRecording(){
    print("오디오녹음시작");
  }

}
