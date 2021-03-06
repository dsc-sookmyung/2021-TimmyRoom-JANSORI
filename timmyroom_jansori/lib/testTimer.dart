import 'package:flutter/material.dart';
import 'dart:async';

class TimeCheck extends StatefulWidget {
  @override
  _TimeCheckState createState() => _TimeCheckState();
}

class _TimeCheckState extends State<TimeCheck>  {
  var _icon = Icons.play_arrow;
  var _color = Colors.amber;

  Timer _timer; // 타이머
  var _time = 0; // 실제 늘어날 시간
  var _isPlaying = false; // 시작 정지 상태값
  List<String> _saveTimes = []; // 기록하기 위한 리스트

  // 타이머 앱 종료할 때는 반복되는 동작을 멈춰주어야 한다.
  // dispose() 메소드를 재정의하여 타이머가 취소되도록 해주어야 한다.
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
      bottomNavigationBar: BottomAppBar (
        child: Container(
          height: 80
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() {
          _click();
        }),
        child: Icon(_icon),
        backgroundColor: _color,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  // 시간 보여지는 부분
  Widget _body(){
    var sec = _time ~/ 100; // 초
    var hundredth = '${_time % 100}'.padLeft(2, '0');

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Stack( // 위젯 위에 위젯 겹치기
          children: <Widget>[
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget> [
                    Text( // seconds
                      '$sec',
                      style: TextStyle(fontSize: 80),
                    ),
                    Text( // milliseconds
                      '.$hundredth',
                      style: TextStyle(fontSize: 30),
                    )
                  ],
                ),
                SizedBox(height: 50, //여백
                ),
                Container(
                  width: 200,
                  height: 300,
                  child:ListView(
                    children: _saveTimes.map((time) => Text(time, style: TextStyle(fontSize: 20),)).toList(),
                  ),
                )
              ],
            ),
            Positioned(
              right: 0,
              bottom: 80,
              child: RaisedButton(
                onPressed: () {
                  setState(() {
                    _reset();
                  });
                },
                textColor: Colors.white,
                padding: const EdgeInsets.all(0.0),
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        Color(0xFF0D47A1),
                        Color(0xFF1976D2),
                        Color(0xFF42A5F5),
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Clear Board',
                    style: TextStyle(
                        fontSize: 20),
                  ),
                ),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 20,
              child: RaisedButton(
                onPressed: () {
                  setState(() {
                    _saveTime('$sec.$hundredth');
                  });
                },
                textColor: Colors.white,
                padding: const EdgeInsets.all(0.0),
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        Color(0xFF0D47A1),
                        Color(0xFF1976D2),
                        Color(0xFF42A5F5),
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Save Time!!',
                    style: TextStyle(
                        fontSize: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 시작, 일시정지 버튼
  void _click() {
    _isPlaying = !_isPlaying;

    if(_isPlaying) {
      _icon = Icons.pause;
      _color = Colors.grey;
      _start();
      print('start');
    } else {
      _icon = Icons.play_arrow;
      _color = Colors.amber;
      _pause();
    }
  }

  // 1/100초에 한 번씩 time 1씩 증가
  void _start() {
    // Duration은 일정 간격이 들어가며 시분초 등이 들어갈 수 있다.
    _timer = Timer.periodic(Duration(milliseconds: 10), (timer) {
      setState(() {
        _time++;
      });
    });
  }

  // 타이머 중지 (취소)
  void _pause() {
      _timer?.cancel();
  }

  // 초기화
  void _reset() {
    setState(() {
      _isPlaying = false;
      _timer?.cancel();
      _saveTimes.clear();
      _time = 0;
    });
  }
    //기록하기
  void _saveTime(String time) {
    _saveTimes.insert(0, '${_saveTimes.length + 1}등 : $time');
  }
}

  // 출처 : https://kyungsnim.net/83