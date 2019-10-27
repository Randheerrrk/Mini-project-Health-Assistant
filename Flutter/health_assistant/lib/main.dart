import 'dart:developer';

import 'package:flutter/material.dart';
import 'colors.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
	// Root
	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			debugShowCheckedModeBanner: false,
			title: 'PrimeAide',
			theme: ThemeData(
				primarySwatch: primaryColor,
			),
			home: HomePage(title: 'Home'),
		);
	}
}

class HomePage extends StatefulWidget {
	HomePage({Key key, this.title}) : super(key: key);
	final String title;
	@override
	_HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
	bool _isMicEnabled = true;

	final _myController = TextEditingController();

	@override
	void dispose() {
		// Clean up the controller when the widget is disposed.
		_myController.dispose();
		super.dispose();
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text(widget.title),
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
											onTap: micController(), // button pressed
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
