import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'data.dart';
import "timer.dart";

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  bool toggleValue = false;
  bool isOn = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Center(
              child: Column(
                children: <Widget>[
                  // 여백
                  SizedBox(height: 130,),
                  // Start 둘 원
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      // 큰 원을 그린다
                      height: 230,
                      width: 230,

                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: Colors.blueGrey.withOpacity(0.7),
                              width: 11),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.4),
                              spreadRadius: 7, // 그림자 진하기 .. ?
                              blurRadius: 4, // 그림자 얼마나  blur
                              offset: Offset(0, 3),
                            ),
                          ]
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  // 토글 바 1
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
                  // 토글바 2
                  SizedBox(height: 10,),
                  // list view 그 .. 내 할일 목록이요

                  Expanded(
                    child: Container(

                      height: 30,
                      width:50,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.9),
                      ),
                      child :Switch(
                        value: isOn,
                        onChanged: (bool value) {
                          setState(() {
                            isOn = value;
                            print(isOn);
                          });
                        },
                        activeTrackColor: Colors.yellow,
                        activeColor: Colors.deepOrange,
                      ),
                      //margin: EdgeInsets.symmetric(vertical: 10.0),



                    ),
                  ),
                ],
              ),
            )
        )
    );
  }
  toggleButton() {
    setState(() {
      toggleValue = !toggleValue;
    });
  }
}
