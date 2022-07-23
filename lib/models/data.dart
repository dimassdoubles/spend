import 'package:spend/models/transaction.dart';

class Data {
  int balance;
  int dailyTarget;
  List<Transaction> transactions;

  Data(
      {required this.balance,
      required this.dailyTarget,
      required this.transactions});
}
