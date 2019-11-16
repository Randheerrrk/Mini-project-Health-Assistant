import 'package:flutter/material.dart';
import 'package:speech_recognition/speech_recognition.dart';
import 'dart:developer' as developer;
import 'color.dart';
// import 'package:simple_permissions/simple_permissions.dart';

class SendBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
   return MainState();
  }
}

class MainState extends State<SendBar> {
  final TextEditingController textEditingController = new TextEditingController();
  bool _enableMic = true;
  final String file = "lib.send_bar.";

  SpeechRecognition _speechRecognition;
  String resultText;
  bool _isAvailable = false;
  bool _isListening =false;
  // Permission permission;


//  checkPermission() async {
//     bool res = await SimplePermissions.checkPermission(permission);
//     if(!res){
//       SimplePermissions.getPermissionStatus(permission);
//     }
//   }

void initialseSTT(){
  developer.log("Initialsing Voice!");
    
    _speechRecognition = SpeechRecognition();

    _speechRecognition.setAvailabilityHandler(
          (bool result) => setState(() => _isAvailable = result),
    );

    _speechRecognition.setRecognitionStartedHandler(
          () => setState(() => _isListening = true),
    );

    _speechRecognition.setRecognitionResultHandler(
          (String speech) => setState(() => resultText = speech),
    );

    _speechRecognition.setRecognitionCompleteHandler(
          () => setState(() => _isListening = false),
    );

    _speechRecognition.activate().then(
          (result) => setState(() => _isAvailable = result),
    );
    print("Comlete");
}

  @override
  void initState() {
    super.initState();
    // checkPermission();
     
    initialseSTT();
  }
  _callParser() {
    
    //There is text in text box send it to main
    if (textEditingController.text != "") {
      developer.log('Inpur has text: ' + textEditingController.text,
          name: file + " _callParser");
      sendKaBab(textEditingController.text);
    } else {
      if (_isAvailable && !_isListening && _enableMic) {
        _speechRecognition
            .listen(locale: "en_US")
            .then((result) => print('$result'));
        developer.log("Calling STT service!", name: file + "_callParser");
      }
     else if(_isListening){
        if (_isListening)
          _speechRecognition.stop().then(
                (result) => setState(()
                {_isListening = false;
                textEditingController.text = result;
                }),
          );
    }
    }
  }

  //Implement this function in main.dart
  sendKaBab(String text) {
    print(text);
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
          FloatingActionButton(
            child:_enableMic ? (_isListening? new Icon(Icons.mic):new Icon(Icons.stop) ): new Icon(Icons.send),
             onPressed:(){ _callParser();
             print("Sasi"); },
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


//   icon: _enableMic ? (_isListening? new Icon(Icons.mic):new Icon(Icons.stop) ): new Icon(Icons.send),
//                 onPressed: () => _isEnabled ? _callParser() : null,


}

