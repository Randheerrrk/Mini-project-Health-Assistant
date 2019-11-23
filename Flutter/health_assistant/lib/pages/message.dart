import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_login_demo/config.dart';
import 'package:flutter_login_demo/services/api.dart';
import 'user_message.dart';

class MessageHandler extends StatefulWidget{
    UserMessage val;
    MessageHandler(final UserMessage message){
      this.val =message;
    }

    @override
    State<StatefulWidget> createState() => new _Message2(val);
}

class _Message2 extends State<MessageHandler>{

 UserMessage message;
 String reply;

  _Message2(UserMessage message){
    this.message =message;
  }

  @override
  initState(){
    super.initState();
    reply = "Loading";
    if(message.user==UserType.Bert)
      call();
  }

    void call() async{
      String temp =  await ApiService.getConsulted(message.text);
      log("Called async: result:" +temp);
      setState(() {
        reply=temp;
      });
      return;
    }

  @override
  Widget build(BuildContext context) {
     if(message.user==UserType.Bert){
         return new Container(
            child: new Row(
              children: <Widget>[
                new Column(
                  children: <Widget>[
                    new MaterialButton(
                      color: primaryColor,
                      minWidth: 60.0,
                      onPressed: null,
                      ),
                  ],
                ),
                new Expanded(
                  child: new Column(
                    crossAxisAlignment :CrossAxisAlignment.start,																																																																																																																																																																																																																																																																																																								
                    children: <Widget>[
                      new Align(
                        alignment: Alignment.topLeft,
                        child:   Container(
                          
                          decoration: BoxDecoration(
                                border: Border.all(color: Colors.blueAccent),
                                color: bertMessagebg,
                              ),
                          child:  Text(reply),
                        ),
                      ),
              ],
                  ),
                  // ),
                ),
                
              ],
            ),
          );
     }
      else if (message.user == UserType.User)
        {
           return new Container(
              child: new Row(
                children: <Widget>[
                  
                  new Expanded(
                    // child: new Container(
                    // padding: EdgeInsets.all(10.0),
                    child: new Column(
                      // mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.blueAccent),
                                color:userMessagebg,
                              ),
                            child: Text(message.text),
                          ) 
                        ),
                ],
                    ),
                  ),
                  
                ],
              ),
            );  
        }
        else return Container(
            width: 0,
            height: 0,
          );
  }
}