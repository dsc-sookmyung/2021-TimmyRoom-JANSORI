
import 'package:flutter/material.dart';
import 'HelpSection.dart';
import 'startPage.dart';
import 'alarmList.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  PageController pageController = PageController(initialPage: 0);
  int pageChanged = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // title appBar랑 actions은 같이..
      /*
      appBar: AppBar(title: Text('page view'),
      // curve 바꾸면 different action
      actions: [
        IconButton(icon: Icon(Icons.arrow_back), onPressed: (){
          pageController.animateToPage(--pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut);
        }),
        IconButton(icon: Icon(Icons.arrow_forward), onPressed: (){
          pageController.animateToPage(++pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut);
        }),
      ],
      ),
       */
      body: PageView(
        //pageSnapping: true,
        controller: pageController,
        onPageChanged: (index) {
          setState(() {
            pageChanged = index;
          });
          print(pageChanged);
        },
        children: [
          page2(),
          StartPage(),
          //HelpSection(),
          /*
          Container(
              height: 400,
              width: 200,
              color: Colors.indigo,
              /*
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.purple, Colors.red],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(24)),
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                        children: <Widget>[
                         Text(
                            'Office',
                            style: TextStyle(
                              color: Colors.white, fontFamily: 'abenir'),
                            ),
                        ],
                      ),
                        Switch(
                          onChanged: (bool value) {},
                          value: true,
                          activeColor: Colors.white,
                        ),
                      ],
                    )

                  ]
                )
              )

               */
          ),

          // TimeCheck(),
           */
          // Container(color: Colors.red),
         // Container(color: Colors.brown),

        ],
      )
    );
  }
}