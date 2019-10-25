import 'package:flutter/material.dart';
import 'package:speech_recognition/speech_recognition.dart';
import 'dart:developer' as developer;
import 'color.dart';


class SendBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
   return MainState();
  }
}

class MainState extends State<SendBar> {
  final TextEditingController textEditingController = new TextEditingController();
  bool _isEnabled = true;
  bool _enableMic = true;
  final String file = "lib.send_bar.";
  final _speech = SpeechRecognition();
  String _myLocale ;

  bool _speechRecognitionAvailable = false;

  bool _isListening =false;


  MainState(){
    _speech.setAvailabilityHandler((bool result)
    => setState(() => _speechRecognitionAvailable = result));
    _speech.setCurrentLocaleHandler((String locale) =>
        setState(() => _myLocale = locale));

    _speech
        .activate()
        .then((res) => setState(() => _speechRecognitionAvailable = res));
  }

  _callParser() {
    //There is text in text box send it to main
    if (textEditingController.text != "") {
      developer.log('Inpur has text: ' + textEditingController.text , name: file + " _callParser");
      sendKaBab(textEditingController.text);
    } else {
      _speech.setRecognitionStartedHandler(()
      => setState(() => _isListening = true));
      // We need to open mic reception
      String tempString;
      developer.log("Calling STT service!",name: file + "_callParser");

      _speech.listen(locale:_myLocale).then((result)=> print('result : $result'));

      _speech.setRecognitionCompleteHandler(()
      => setState(() => _isListening = false));
    }
  }

  //Implement this function in main.dart
  sendKaBab(String text) {
    Scaffold.of(context).showSnackBar(new SnackBar(
      content: new Text(text),
    ));
  }


  //Disables mic and shows send button when
  _typing() {
    textEditingController.text!=""?setState(() {
      developer.log("Disabling Mic",name: file + "_typing");
      _enableMic = false;
    }):setState(() {
      developer.log("Enabling Mic",name: file + "_typing");
      _enableMic = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          // Button send image
          // Edit text
          Flexible(
            child: Container(
              child: TextField(
                style: TextStyle(color: primaryColor, fontSize: 15.0),
                controller: textEditingController,
                enabled: _isEnabled,
                onChanged: _typing(),
                onTap: _typing(),
                decoration: InputDecoration.collapsed(
                  hintText: 'Type here what you feel...',
                  hintStyle: TextStyle(color: greyColor),
                ),
//                focusNode: focusNode,
              ),
            ),
          ),

          // Button send message
          Material(
            child: new Container(
              margin: new EdgeInsets.symmetric(horizontal: 8.0),
              child: new IconButton(
                icon: _enableMic ? new Icon(Icons.mic) : new Icon(Icons.send),
                onPressed: () => _isEnabled ? _callParser() : null,
                color: primaryColor,

              ),
            ),
            color: Colors.white,
          ),
        ],
      ),
      width: double.infinity,
      height: 50.0,
      decoration: new BoxDecoration(
          border: new Border(
              top: new BorderSide(color: greyColor2, width: 0.5)),
          color: Colors.white),
    );
  }


}

