import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:spend/models/transaction.dart';
import 'package:spend/screens/home-screen/widgets/my_detail_transaction.dart';
import 'package:spend/theme.dart';

class MyTransactions extends StatelessWidget {
  MyTransactions(
      {Key? key,
      required this.dailyTransactionAmount,
      required this.transactions})
      : super(key: key);

  final int dailyTransactionAmount;
  final List<Transaction> transactions;

  final CurrencyTextInputFormatter formatter = CurrencyTextInputFormatter(
      locale: 'id',
      decimalDigits: 0,
      symbol: '',
    );

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
            "Rp " + formatter.format("$dailyTransactionAmount"),
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
