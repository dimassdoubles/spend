import 'package:flutter/material.dart';
import 'package:spend/models/transaction.dart';

class TransactionsProvider extends ChangeNotifier {
  List<Transaction> _transactions = [
    Transaction(amount: 50000, description: "Hello World!"),
    Transaction(amount: 20000, description: "Lorem Ipsum"),
  ];

  List<Transaction> get transactions {
    return [..._transactions];
  }

  void addTransaction(Transaction transaction) {
    _transactions.insert(0,transaction);
  }
}
