
import 'package:flutter/material.dart';
import 'testPage.dart';
import 'page1.dart';
import 'timer.dart';

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
          HelpSection(),
          Container(
              color: Colors.indigo,
              child: Container(
                width: 300,
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 10),
                ),
                child: Text("fullter"),
              )
          ),
          // TimeCheck(),
          // Container(color: Colors.red),
          Container(color: Colors.brown),

        ],
      )
    );
  }
}