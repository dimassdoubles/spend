import 'package:flutter/material.dart';
import 'package:spend/screens/home_screen.dart';
import 'package:spend/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: blue,
      ),
      home: HomeScreen(),
    );
  }
}

