import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:spend/theme.dart';

class MyRowTransaction extends StatelessWidget {
  MyRowTransaction(
      {Key? key, required this.amount, required this.description})
      : super(key: key);

  final int amount;
  final String description;

  final CurrencyTextInputFormatter formatter = CurrencyTextInputFormatter(
      locale: 'id',
      decimalDigits: 0,
      symbol: '',
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(formatter.format('$amount'), style: interText(Colors.white, 12)),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                  color: lightBlue, borderRadius: BorderRadius.circular(15)),
              child: Text(
                description,
                style: interText(Colors.white, 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
