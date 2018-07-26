import 'package:flutter/material.dart';
import 'package:recipe_app/homeScreen.dart';

void main() => runApp(new FoodApp());

class FoodApp extends StatelessWidget {

  final theme = ThemeData(
    primaryColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
  );

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: theme,
      home: HomeScreen(),
    );
  }
}