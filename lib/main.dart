
import 'package:flutter/material.dart';
import 'package:primeaide/services/authentication.dart';
import 'package:primeaide/pages/root_page.dart';
import 'package:primeaide/config.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: appName,
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
          primarySwatch:primaryColor,
        ),
        home: new RootPage(auth: new Auth()));
  }
}
