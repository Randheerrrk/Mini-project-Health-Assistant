import 'package:flutter/material.dart';
import 'package:flutter_login_demo/config.dart';
import 'user_message.dart';

class Message2 extends StatelessWidget{

 UserMessage message;

  Message2(UserMessage message){
    this.message =message;
  }

  Widget getText() {
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
                          color: bertMessagebg,
                          decoration: BoxDecoration(
                                border: Border.all(color: Colors.blueAccent)
                              ),
                          child:  Text(message.text),,
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
                                border: Border.all(color: Colors.blueAccent)
                              ),
                            color: userMessagebg,
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
        else
          return Container(
            width: 0,
            height: 0,
          );
    }

  @override
  Widget build(BuildContext context) {
    return getText();
  }
}