import 'package:flutter/material.dart';
import 'package:health_assistant/main.dart';
import 'colors.dart';


@deprecated
class TB  extends State<HomePage>{
  
  bool _isMicEnabled = false;

  Widget textBox() {
    return Container(
        padding: EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
           children: [
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
              onChanged: (val){
                  if(val == null || val == "")
                  setState(() {
                    _isMicEnabled = true;
                  });
                  else
                  setState(() {
                     _isMicEnabled =false;
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
                      onTap: () {}, // button pressed
                      child: Icon(
                        _isMicEnabled?Icons.mic:Icons.send,
                        color: whiteColor,
                      )),
                ),
              ),
            ),
          ),
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return textBox();
  }
  
}
