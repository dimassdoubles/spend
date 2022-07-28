import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:spend/providers/balance_provider.dart';
import 'package:spend/providers/daily_target_provider.dart';
import 'package:spend/providers/transactions_provider.dart';
import 'package:spend/screens/home-screen/widgets/my_date.dart';
import 'package:spend/screens/home-screen/widgets/my_transactions.dart';
import 'package:spend/theme.dart';

class WebView extends StatefulWidget {
  const WebView({Key? key}) : super(key: key);

  @override
  State<WebView> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  int _dailyTransactionAmount = 0;
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

    for (int i = 0; i < transactions.length; i++) {
      setState(() {
        _dailyTransactionAmount += transactions[i].amount;
      });
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'Total saldo',
              style: poppinsText(grey, 12),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: _isEditBalance ? lightBlue : Colors.transparent,
                  child: IntrinsicWidth(
                    child: TextFormField(
                      initialValue: "${balance}",
                      onFieldSubmitted: (String value) {
                        setState(() {
                          _isEditBalance = false;
                          if (value != "") {
                            balanceProvider.setBalance(int.parse(value));
                          } else {
                            balanceProvider.setBalance(0);
                          }
                        });
                      },
                      enabled: _isEditBalance ? true : false,
                      style: interText(Colors.white, 20, FontWeight.bold),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(7),
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
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
                    ? SizedBox(
                        width: 40,
                      )
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
            const SizedBox(
              height: 28,
            ),
            const MyDate(),
            const SizedBox(
              height: 28,
            ),
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
                        print("hallo anjay");
                        setState(() {
                          _isEditDailyTarget = false;
                          if (value != "") {
                            dailyTargetProvider
                                .setDailyTarget(int.parse(value));
                          } else {
                            dailyTargetProvider.setDailyTarget(0);
                          }
                        });
                      },
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(7),
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      style: poppinsText(green, 12),
                      initialValue: "${dailyTarget}",
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
                    ? SizedBox(
                        width: 40,
                      )
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
              children:
                  (dailyTargetProvider.dailyTarget >= _dailyTransactionAmount)
                      ? [
                          Text(
                            'Rp ${dailyTargetProvider.dailyTarget - _dailyTransactionAmount}',
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
                            'Rp ${_dailyTransactionAmount - dailyTargetProvider.dailyTarget}',
                            style: interText(Colors.white, 16, FontWeight.w600),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'melebihi target',
                            style: poppinsText(red, 12),
                          )
                        ],
            ),
          ]),
        ),
        Expanded(
          child: MyTransactions(
            dailyTransactionAmount: _dailyTransactionAmount,
            transactions: transactions,
          ),
        ),
      ],
    );
  }
}
