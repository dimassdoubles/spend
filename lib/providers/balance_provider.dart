import 'package:flutter/material.dart';

class BalanceProvider extends ChangeNotifier {
  int _balance = 1000000;

  int get balance {
    return _balance;
  }

  void setBalance(int balance) {
    _balance = balance;
    notifyListeners();
  }
}
