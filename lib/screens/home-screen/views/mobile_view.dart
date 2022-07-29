import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:spend/providers/balance_provider.dart';
import 'package:spend/providers/daily_target_provider.dart';
import 'package:spend/providers/transactions_provider.dart';
import 'package:spend/screens/home-screen/widgets/my_date.dart';
import 'package:spend/screens/home-screen/widgets/my_transactions.dart';
import 'package:spend/theme.dart';

class MobileView extends StatefulWidget {
  const MobileView({Key? key}) : super(key: key);

  @override
  State<MobileView> createState() => _MobileViewState();
}

class _MobileViewState extends State<MobileView> {
  bool _isEditBalance = false;
  bool _isEditDailyTarget = false;

  @override
  Widget build(BuildContext context) {
    // provider
    final balanceProvider = Provider.of<BalanceProvider>(context);
    final dailyTargetProvider = Provider.of<DailyTargetProvider>(context);
    final transactionsProvider = Provider.of<TransactionsProvider>(context);

    int balance = balanceProvider.balance;
    int dailyTarget = dailyTargetProvider.dailyTarget;
    final transactions = transactionsProvider.transactions;

    int dailyTransactionAmount = 0;

    for (int i = 0; i < transactions.length; i++) {
      dailyTransactionAmount += transactions[i].amount;
    }

    final CurrencyTextInputFormatter formatter = CurrencyTextInputFormatter(
      locale: 'id',
      decimalDigits: 0,
      symbol: '',
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 32,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total saldo',
              style: poppinsText(grey, 12),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Container(
                  color: _isEditBalance ? lightBlue : Colors.transparent,
                  child: IntrinsicWidth(
                    child: TextFormField(
                      initialValue: formatter.format("$balance"),
                      onFieldSubmitted: (String value) {
                        setState(() {
                          _isEditBalance = false;
                          if (value != "") {
                            balanceProvider.setBalance(
                                int.parse(value.replaceAll(".", "")));
                          } else {
                            balanceProvider.setBalance(0);
                          }
                        });
                      },
                      enabled: _isEditBalance ? true : false,
                      style: interText(Colors.white, 20, FontWeight.bold),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        CurrencyTextInputFormatter(
                          locale: 'id',
                          decimalDigits: 0,
                          symbol: '',
                        ),
                        LengthLimitingTextInputFormatter(10),
                        // FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      autofocus: _isEditBalance ? true : false,
                      decoration: InputDecoration(
                        prefixText: 'Rp ',
                        prefixStyle:
                            interText(Colors.white, 20, FontWeight.bold),
                        isDense: true,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                _isEditBalance
                    ? SizedBox()
                    : IconButton(
                        icon: Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 20,
                        ),
                        onPressed: () {
                          setState(() {
                            _isEditBalance = true;
                          });
                        },
                      ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 28,
        ),
        const MyDate(),
        const SizedBox(
          height: 28,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Target pengeluaran harian',
                  style: poppinsText(grey, 12),
                ),
                const SizedBox(
                  width: 5,
                ),
                Container(
                  color: _isEditDailyTarget ? lightBlue : Colors.transparent,
                  child: IntrinsicWidth(
                    child: TextFormField(
                      onFieldSubmitted: (String value) {
                        setState(() {
                          _isEditDailyTarget = false;
                          if (value != "") {
                            dailyTargetProvider
                                .setDailyTarget(int.parse(value.replaceAll(".", "")));
                          } else {
                            dailyTargetProvider.setDailyTarget(0);
                          }
                        });
                      },
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        CurrencyTextInputFormatter(
                          locale: 'id',
                          decimalDigits: 0,
                          symbol: '',
                        ),
                        LengthLimitingTextInputFormatter(7),
                        // FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      style: poppinsText(green, 12),
                      // initialValue: "${dailyTarget}",
                      initialValue: formatter.format("$dailyTarget"),
                      enabled: _isEditDailyTarget ? true : false,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixText: '( Rp ',
                        prefixStyle: poppinsText(green, 12),
                        suffixText: ' )',
                        suffixStyle: poppinsText(green, 12),
                      ),
                    ),
                  ),
                ),
                _isEditDailyTarget
                    ? SizedBox()
                    : IconButton(
                        icon: Icon(Icons.edit, color: Colors.white, size: 20),
                        onPressed: () {
                          setState(() {
                            _isEditDailyTarget = true;
                          });
                        },
                      ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: (dailyTarget >= dailyTransactionAmount)
                  ? [
                      Text(
                        "Rp " + formatter.format('${dailyTarget - dailyTransactionAmount}'),
                        style: interText(Colors.white, 16, FontWeight.w600),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'tersisa',
                        style: poppinsText(green, 12),
                      )
                    ]
                  : [
                      Text(
                        "Rp " + formatter.format('${dailyTransactionAmount - dailyTarget}'),
                        style: interText(Colors.white, 16, FontWeight.w600),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'melebihi target',
                        style: poppinsText(red, 12),
                      )
                    ],
            ),
          ],
        ),
        const SizedBox(
          height: 28,
        ),
        Expanded(
          child: MyTransactions(
            dailyTransactionAmount: dailyTransactionAmount,
            transactions: transactions,
          ),
        ),
      ],
    );
  }
}
