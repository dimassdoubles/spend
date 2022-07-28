import 'package:flutter/material.dart';
import 'package:spend/models/transaction.dart';
import 'package:spend/screens/home-screen/widgets/my_row_transaction.dart';

class MyDetailTransaction extends StatelessWidget {
  MyDetailTransaction({Key? key, required this.transactions}) : super(key: key);

  List<Transaction> transactions;

  List<MyRowTransaction> loadDetailTransaction(List<Transaction> transactions) {
    List<MyRowTransaction> listRow = [];
    if (!transactions.isEmpty) {
      for (int i = 0; i < transactions.length; i++) {
        listRow.add(MyRowTransaction(
            amount: transactions[i].amount,
            description: transactions[i].description));
      }
    }

    return listRow;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: ListView(clipBehavior: Clip.antiAlias, children: [
        Container(
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                width: 2,
                color: Colors.white,
              ),
            ),
          ),
          child: Column(
            children: loadDetailTransaction(transactions),
          ),
        ),
        SizedBox(height: 16),
      ]),
    );
  }
}
