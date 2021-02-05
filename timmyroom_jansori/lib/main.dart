import 'package:flutter/material.dart';
import 'package:timmyroom_jansori/HelpSection.dart';
import 'pageSlider.dart';
import 'startPage.dart';
import 'alarmList.dart';


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
      home: HomePage(),
    );
  }
}
