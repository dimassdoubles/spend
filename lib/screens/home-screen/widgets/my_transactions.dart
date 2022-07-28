import 'package:flutter/material.dart';
import 'package:spend/models/transaction.dart';
import 'package:spend/screens/home-screen/widgets/my_detail_transaction.dart';
import 'package:spend/theme.dart';

class MyTransactions extends StatelessWidget {
  const MyTransactions(
      {Key? key,
      required this.dailyTransactionAmount,
      required this.transactions})
      : super(key: key);

  final int dailyTransactionAmount;
  final List<Transaction> transactions;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Transaksi',
            style: poppinsText(grey, 12),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            'Rp $dailyTransactionAmount',
            style: interText(Colors.white, 16, FontWeight.w600),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(child: MyDetailTransaction(transactions: transactions)),
        ],
      ),
    );
  }
}
