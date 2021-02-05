import 'package:flutter/material.dart';
import 'pageSlider.dart';
import 'dart:async';

import 'package:splashscreen/splashscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData.dark(),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 4,
      navigateAfterSeconds: HomePage(),
      // title: new Text('GeeksForGeeks',textScaleFactor: 2,),
      image: Image.asset('images/logo03.png'),
      //loadingText: Text("Loading"),
      photoSize: 100.0,
      backgroundColor: Color.fromRGBO(44, 44, 84, 1.0),

    );
  }
}