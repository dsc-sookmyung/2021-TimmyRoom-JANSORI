import 'package:flutter/material.dart';




class alarmList extends StatelessWidget {

  List titles=["모델 돌리기","코딩하기","3","4","5","6","7","8","9","10"];
  List subTitles=["11","22","33","44","55","66","77","88","99","1010"];
  List concentrateTime=["10","20","30","40","50","60","70","80","90","100"];
  List breakTime=["1","22","33","44","55","66","77","88","99","1010"];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body:ListView.builder(
        itemCount:10,
        shrinkWrap: true,
        itemBuilder: (BuildContext context,int index)=>Container(
          width:MediaQuery.of(context).size.width,
          padding:EdgeInsets.symmetric(horizontal:10.0,vertical:5.0),
          child:Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            child:Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient:LinearGradient(
                    begin:Alignment.centerLeft,
                    end:Alignment.centerRight,
                    colors:[Color.fromRGBO(100, 72 , 254, 0.8),Color.fromRGBO(95, 198, 255, 0.8)]
                ),
              ),
              width:MediaQuery.of(context).size.width,
              padding:EdgeInsets.symmetric(horizontal:10.0,vertical: 10.0),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:<Widget>[
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children:<Widget>[
                        Container(
                          width:55.0,
                          height:55.0,
                          color: Colors.white,
                          child:
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.white,
                            backgroundImage: AssetImage("images/on.png"),
                          ),
                        ),
                        SizedBox(width:15.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:<Widget>[
                            Text(titles[index],style:TextStyle(color:Colors.white,fontSize:18.0,fontWeight: FontWeight.bold)),
                            Text(subTitles[index],style:TextStyle(color:Colors.white)),
                          ],
                        ),
                      ]
                  ),
                  Container(
                    alignment:Alignment.center,
                    padding:EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:<Widget>[
                        Text("집중 타임",style:TextStyle(color:Colors.white,fontSize:10.0)),
                        Text(concentrateTime[index]+"분",style:TextStyle(color:Colors.white,fontSize:18.0,fontWeight: FontWeight.bold)),
                        Text("휴식 타임",style:TextStyle(color:Colors.white,fontSize:10.0)),
                        Text(breakTime[index]+"분",style:TextStyle(color:Colors.white,fontSize:18.0,fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}