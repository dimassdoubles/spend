import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spend/providers/balance_provider.dart';
import 'package:spend/providers/daily_target_provider.dart';
import 'package:spend/providers/transactions_provider.dart';
import 'package:spend/screens/home-screen/home_screen.dart';
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

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BalanceProvider(),),
        ChangeNotifierProvider(create: (context) => DailyTargetProvider(),),
        ChangeNotifierProvider(create: (context) => TransactionsProvider(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: blue,
        ),
        // home: HomeScreen(data: data),
        home: HomeScreen(),
        routes: {
          HomeScreen.routeName: (context) => HomeScreen(),
          // InputScreen.routeName: (context) => InputScreen(),
        },
      ),
    );
  }
}
