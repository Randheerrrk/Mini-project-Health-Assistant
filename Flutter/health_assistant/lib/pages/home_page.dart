import 'package:flutter/material.dart';
import 'package:flutter_login_demo/config.dart';
import 'package:flutter_login_demo/services/authentication.dart';
import 'package:speech_recognition/speech_recognition.dart';
import 'dart:developer' as developer;
import 'user_message.dart';
import 'message.dart';
import 'dart:io';

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

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController textEditingController = new TextEditingController();
  bool _enableMic = true;
  bool isConnected = false;
  final String file = "lib.send_bar.";

  SpeechRecognition _speechRecognition;
  String resultText ="";
  bool _isAvailable = false;
  bool _isListening =false;

  List<UserMessage> list = new List<UserMessage>(); 
  ScrollController listScrollController = new ScrollController();
  
  @override
  void initState() {
    super.initState();

  initialseSTT();
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
            children: <Widget>[
              Expanded(
                child:ListView.builder(
                padding: EdgeInsets.all(10.0),
                itemBuilder: (context, index) => MessageHandler(list[index]),
                itemCount:list.length,
                reverse: false,
                shrinkWrap: true,
                controller: listScrollController,
              ),
                ),
              
              Expanded(
                flex: 0,
                child: Container(
                  height: 5,
                  child: _isListening?LinearProgressIndicator():Container(width: 0,height: 0,)),
              ),
              textBoxWidget()],
          ),
        ),

    );
  }

///The text box that is shown at the bottom
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
              controller: textEditingController,
              onChanged: (val) {
                if (val == null || val == "")
                  setState(() {
                    _enableMic = true;
                  });
                else
                  setState(() {
                    _enableMic = false;
                  });
              },
              keyboardType: TextInputType.text,
              style: TextStyle(
                fontFamily: "Poppins",
              ),
            ),
          ),
          FloatingActionButton(
            child:_enableMic ? (_isListening? new Icon(Icons.stop):new Icon(Icons.mic) ): new Icon(Icons.send),
             onPressed:()=> _callParser(),
          ),
        ]));
  }

// Enables the mic and start and stop the voice to text plugin
  _callParser() {
    //There is text in text box send it to main
    if (textEditingController.text != "") {
      developer.log('Input has text: ' + textEditingController.text,
          name: file + " _callParser");
      sendKaBab(textEditingController.text);
    } else {
      if (_isAvailable && !_isListening && _enableMic) {
        _speechRecognition
            .listen(locale: "en_US")
            .then((result) => textEditingController.text =result);
        developer.log("Calling STT service!", name: file + "_callParser");
      }
     else if(_isListening && _enableMic && _isAvailable){
          _speechRecognition.stop().then(
                (result) => setState(()
                {_isListening = false;
                _enableMic = false;
                developer.log("Stopped Listening");
                }),
          );
    }
    }
  }

///THis method is used to intialise the voice reconginition engine.
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
          (String speech) => setState((){ 
            textEditingController.text = speech;
            // resultText = speech;
            _enableMic =false;
            }),
    );

    _speechRecognition.setRecognitionCompleteHandler(
          () => setState(() => _isListening = false),
    );

    _speechRecognition.activate().then(
          (result) => setState(() => _isAvailable = result),
    );
    print("Comlete");
}

  //Implement this function in main.dart
  sendKaBab(String text) {
    
    print(text);
    setState(() {
      textEditingController.text = "";
      _enableMic = true;
       list.add(UserMessage(text,UserType.User));
       list.add(UserMessage(text,UserType.Bert));
    });
    listScrollController.animateTo(listScrollController.position.maxScrollExtent + 40, duration: Duration(milliseconds: 200), curve: Curves.easeOut);
  
  }

  checkConnection() async{
    try {
        final connected = await InternetAddress.lookup(URLS.BASE_URL);
        if (connected.isNotEmpty && connected[0].rawAddress.isNotEmpty) {
          setState(() {
            isConnected = true;
          });
         print('connected');
  }
    } on SocketException catch (_) {
        print('not connected');
        setState(() {
          isConnected = false;
        });
    }
  }

}
