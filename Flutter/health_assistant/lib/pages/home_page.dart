import 'package:flutter/material.dart';
import 'package:flutter_login_demo/config.dart';
import 'package:flutter_login_demo/services/authentication.dart';
import 'dart:developer';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {

 // final FirebaseDatabase _database = FirebaseDatabase.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool _isMicEnabled = true;

  final _myController = TextEditingController();

  @override
  void initState() {
    super.initState();

  }


  @override
  void dispose() {
    super.dispose();
  }


  signOut() async {
    try {
      await widget.auth.signOut();
      widget.logoutCallback();
    } catch (e) {
      print(e);
    }
  }



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Prime Aide'),
          actions: <Widget>[
            new FlatButton(
                child: new Icon(Icons.exit_to_app,
                color: whiteColor,),
                onPressed: signOut)
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[textBoxWidget()],
          ),
        ),

    );
  }


  void micController(){
    if(_isMicEnabled){
      log("Mic is enabled!");


    }else{
      String temp = _myController.text;
      if(temp!=null||temp!="")
        callDoctor(temp);
      else
        log("Unable to fetch string");
    }
  }

  void callDoctor(String val){
    log("Sending" + val + " to DOctor");
    // TODO: Implement this.
  }

  Widget textBoxWidget() {
    return Container(
        padding: EdgeInsets.all(8.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                labelText: "Enter your problem here.",
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(),
                ),
              ),
              validator: (val) {
                if (val.length == 0) {
                  return "Text cannot be empty";
                } else {
                  return null;
                }
              },
              controller: _myController,
              onChanged: (val) {
                if (val == null || val == "")
                  setState(() {
                    _isMicEnabled = true;
                  });
                else
                  setState(() {
                    _isMicEnabled = false;
                  });
              },
              keyboardType: TextInputType.text,
              style: TextStyle(
                fontFamily: "Poppins",
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 8.0),
            child: SizedBox.fromSize(
              size: Size(56, 56), // button width and height
              child: ClipOval(
                child: Material(
                  color: primaryColor, // button color
                  child: InkWell(
                      splashColor: whiteColor, // splash color
                      onTap:(){micController();}, // button pressed
                      child: Icon(
                        _isMicEnabled ? Icons.mic : Icons.send,
                        color: whiteColor,
                      )),
                ),
              ),
            ),
          ),
        ]));
  }
}
