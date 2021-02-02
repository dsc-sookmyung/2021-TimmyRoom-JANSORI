import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// import 'year_month_day_time_picker.dart';

class MainPage3 extends StatefulWidget{
  Page3 createState()=> Page3();
}

class Page3 extends State<MainPage3>{

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: home()
    );
  }

  Widget home(){
    return Scaffold(
      body: popup(),
    );
  }

  Widget popup(){
    return Center(
      child:
          Container(
            width: 285,
            height: 500,
            decoration:
              BoxDecoration(
                border: Border.all(
                  width: 0.8,
                  color: Color.fromRGBO(93, 136, 248, 0.8),
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
            child:
              Container(
                width: 255,
                margin: EdgeInsets.all(15),
                child:
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      timeSetting(),
                      nameSetting(),
                      jansoriSetting(),
                      submitButton(),
                    ],
                  ),
              ),
          ),
    );
  }

  submit() {
  }

  Widget submitButton(){
    return Column(
      children: [
        SizedBox(height: 10.0),
        MaterialButton(
          onPressed: submit,
          color: Color.fromRGBO(93, 136, 248, 1),
          textColor: Colors.white,
          padding: EdgeInsets.symmetric(
            horizontal: 94.0,
            vertical: 10.0,
          ),
          child: Text(
            'Submit',
            style: TextStyle(fontSize: 20.0),
          ),
        ),
      ],
    );
  }

  Widget timeSetting(){
    int _value;

    return Container(
      width: 255,
      margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
      child:
          Container(
            child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                          color: Color.fromRGBO(4, 4, 7, 0.7),
                          // color: Color.fromRGBO(56, 110, 218, 1),
                          height: 1.4,
                        ),
                      ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child:
                          Container(
                              height: 20,
                              // color: Colors.green,
                              child: Container(
                                child:
                                  Text(
                                    "집중 타임(시간)",
                                    style: TextStyle(fontSize: 12),
                                    textAlign: TextAlign.center,
                                  ),
                              ),
                          ),
                      ),
                      Expanded(
                        flex: 1,
                        child:
                          Container(
                              height: 20,
                              // color: Colors.amber,
                              child: Container(
                                child:
                                Text(
                                  "휴식 타임(분)",
                                  style: TextStyle(fontSize: 12),
                                  textAlign: TextAlign.center,
                                ),
                              )
                          ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child:
                          Container(
                            height: 40,
                            //color: Colors.amber,
                            child:
                              Row(
                                children: [
                                  DropdownButton(
                                    value: _value,
                                    items: [
                                      DropdownMenuItem(
                                        child: Text("0"),
                                        value: 1,
                                      ),
                                      DropdownMenuItem(
                                        child: Text("1"),
                                        value: 2,
                                      ),
                                      DropdownMenuItem(
                                          child: Text("2"),
                                          value: 3
                                      ),
                                      DropdownMenuItem(
                                          child: Text("3"),
                                          value: 4
                                      ),
                                      DropdownMenuItem(
                                          child: Text("4"),
                                          value: 5
                                      ),
                                      DropdownMenuItem(
                                          child: Text("5"),
                                          value: 6
                                      ),
                                      DropdownMenuItem(
                                          child: Text("6"),
                                          value: 7
                                      )
                                    ],
                                  onChanged: (value) {
                                    setState(() {
                                      _value = value;
                                    });
                                  },
                                  //value: _value,
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(10, 0, 5, 0),
                                    child: Text("시간"),
                                  ),
                                ],
                              ),
                          ),
                      ),
                      Expanded(
                        flex: 1,
                        child:
                          Container(
                            height: 40,
                            color: Colors.green,
                          ),
                      ),
                    ],
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
          crossAxisAlignment: CrossAxisAlignment.start,
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
                  color: Color.fromRGBO(4, 4, 7, 0.7),
                  height: 1.4,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child:
                  TextField(
                      focusNode: myFocusNode,
                      style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                      ),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '일정 이름을 입력해주세요',
                        labelStyle: TextStyle(
                          fontSize: 13,
                          color: myFocusNode.hasFocus ? Color.fromRGBO(56, 110, 218, 1) : Color.fromRGBO(4, 4, 7, 0.7),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color.fromRGBO(56, 110, 218, 1)),
                        ),
                      )
                  ),
            ),
          ],
        ),
    );
  }

  Widget jansoriSetting(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
          child:
            Text(
              "잔소리 설정",
              style: TextStyle(
                fontFamily: 'Roboto',
                fontStyle: FontStyle.normal,
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Color.fromRGBO(4, 4, 7, 0.7),
                height: 1.4,
              ),
            ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
          height: 130,
          decoration: BoxDecoration(
            border: Border.all(
              color: Color.fromRGBO(4, 4, 7, 0.35),
            ),
            borderRadius: BorderRadius.all(Radius.circular(3)),
          ),
          child:
            jansoriList(),
        ),
      ],
    );
  }

  Widget jansoriList () {
    List<String> items = List.generate(10, (i) => 'jansori #$i');
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, i) {
        return ListTile(
            title: Text(items[i]),
            subtitle: Text('this is jansori $i')
        );
      },
    );
  }


}
