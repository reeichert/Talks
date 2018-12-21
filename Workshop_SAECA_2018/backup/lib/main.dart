import 'package:flutter/material.dart';
import 'package:workshop_chat/Modules/Login/LoginController.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.lightBlue[900],
        accentColor: Colors.yellow[600],
        backgroundColor: Colors.grey[100]
      ),
      home: LoginController(),
    );
  }
}