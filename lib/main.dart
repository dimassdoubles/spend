import 'package:flutter/material.dart';
import 'package:spend/screens/home_screen.dart';
import 'package:spend/screens/input_screen.dart';
import 'package:spend/theme.dart';

import 'models/data.dart';
import 'models/transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  List<Transaction> transactions = [];
  int balance = 200000;
  int dailyTarget = 50000;

  @override
  Widget build(BuildContext context) {
    Data data = Data(
        balance: balance, dailyTarget: dailyTarget, transactions: transactions);

    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: blue,
      ),
      home: HomeScreen(data: data),
    );
  }
}
