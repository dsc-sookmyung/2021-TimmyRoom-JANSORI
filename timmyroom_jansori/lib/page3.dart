import 'package:flutter/material.dart';

import 'package:dotted_border/dotted_border.dart';


class Page3 extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: home()
    );
  }

  Widget home(){
    return Scaffold(
      body: popup()
    );
  }

  Widget popup(){
    return Center(
      child:
        DottedBorder(
          strokeWidth: 2,
          dashPattern: [2, 2],
          color: Color.fromRGBO(93, 136, 248, 0.8),
          child:
            Container(
              width: 285,
              height: 450,
            ),
        ),
    );
  }
}
