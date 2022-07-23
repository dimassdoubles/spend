import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spend/screens/input_screen.dart';

import 'package:spend/theme.dart';
import '../models/data.dart';
import '../models/transaction.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.data}) : super(key: key);

  final Data data;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Data data = Data(balance: 0, dailyTarget: 0, transactions: []);
  int dailyTransactionAmount = 0;
  bool isEditBalance = false;
  bool isEditDailyTarget = false;

  int getDailyTransactionAmount(List<Transaction> transactions) {
    int dailyTransactionAmount = 0;

    for (int i = 0; i < transactions.length; i++) {
      dailyTransactionAmount += transactions[i].amount;
    }

    return dailyTransactionAmount;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = widget.data;
    dailyTransactionAmount = getDailyTransactionAmount(data.transactions);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SPEND',
          style: interText(green, 32, FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(10),
        child: FloatingActionButton(
          onPressed: () {
            setState(() {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => InputScreen(data: data)));
            });
          },
          backgroundColor: green,
          child: Icon(Icons.add, color: blue),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: LayoutBuilder(
          builder: ((context, constraints) {
            if (constraints.maxHeight <= 50) {
              return Text(
                "Maaf, tinggi minimal tidak terpenuhi.",
                style: poppinsText(Colors.white, 16),
              );
            } else if (constraints.maxWidth < 328) {
              return Text(
                "Maaf, lebar minimal tidak terpenuhi.",
                style: poppinsText(Colors.white, 16),
              );
            } else if (constraints.maxHeight <= 400) {
              return getWebView();
            } else if (constraints.maxWidth >= 550) {
              return getWebView();
            } else {
              return getMobileView();
            }
          }),
        ),
      ),
    );
  }

  Widget getWebView() {
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
                  color: isEditBalance ? lightBlue : Colors.transparent,
                  child: IntrinsicWidth(
                    child: TextFormField(
                      initialValue: "${data.balance}",
                      onFieldSubmitted: (String value) {
                        setState(() {
                          isEditBalance = false;
                          if (value != "") {
                            data.balance = int.parse(value);
                          } else {
                            data.balance = 0;
                          }
                        });
                      },
                      enabled: isEditBalance ? true : false,
                      style: interText(Colors.white, 20, FontWeight.bold),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(7),
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      autofocus: isEditBalance ? true : false,
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
                isEditBalance
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
                            isEditBalance = true;
                          });
                        },
                      ),
              ],
            ),
            const SizedBox(
              height: 28,
            ),
            const Date(),
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
                  color: isEditDailyTarget ? lightBlue : Colors.transparent,
                  child: IntrinsicWidth(
                    child: TextFormField(
                      onFieldSubmitted: (String value) {
                        setState(() {
                          isEditDailyTarget = false;
                          if (value != "") {
                            data.dailyTarget = int.parse(value);
                          } else {
                            data.dailyTarget = 0;
                          }
                        });
                      },
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(7),
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      style: poppinsText(green, 12),
                      initialValue: "${data.dailyTarget}",
                      enabled: isEditDailyTarget ? true : false,
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
                isEditDailyTarget
                    ? SizedBox(
                        width: 40,
                      )
                    : IconButton(
                        icon: Icon(Icons.edit, color: Colors.white, size: 20),
                        onPressed: () {
                          setState(() {
                            isEditDailyTarget = true;
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
              children: (data.dailyTarget >= dailyTransactionAmount)
                  ? [
                      Text(
                        'Rp ${data.dailyTarget - dailyTransactionAmount}',
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
                        'Rp ${dailyTransactionAmount - data.dailyTarget}',
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
          child: Transactions(
            dailyTransactionAmount: dailyTransactionAmount,
            transactions: data.transactions,
          ),
        ),
      ],
    );
  }

  Widget getMobileView() {
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
                  color: isEditBalance ? lightBlue : Colors.transparent,
                  child: IntrinsicWidth(
                    child: TextFormField(
                      initialValue: "${data.balance}",
                      onFieldSubmitted: (String value) {
                        setState(() {
                          isEditBalance = false;
                          if (value != "") {
                            data.balance = int.parse(value);
                          } else {
                            data.balance = 0;
                          }
                        });
                      },
                      enabled: isEditBalance ? true : false,
                      style: interText(Colors.white, 20, FontWeight.bold),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(7),
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      autofocus: isEditBalance ? true : false,
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
                isEditBalance
                    ? SizedBox()
                    : IconButton(
                        icon: Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 20,
                        ),
                        onPressed: () {
                          setState(() {
                            isEditBalance = true;
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
        const Date(),
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
                  color: isEditDailyTarget ? lightBlue : Colors.transparent,
                  child: IntrinsicWidth(
                    child: TextFormField(
                      onFieldSubmitted: (String value) {
                        setState(() {
                          isEditDailyTarget = false;
                          if (value != "") {
                            data.dailyTarget = int.parse(value);
                          } else {
                            data.dailyTarget = 0;
                          }
                        });
                      },
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(7),
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      style: poppinsText(green, 12),
                      initialValue: "${data.dailyTarget}",
                      enabled: isEditDailyTarget ? true : false,
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
                isEditDailyTarget
                    ? SizedBox()
                    : IconButton(
                        icon: Icon(Icons.edit, color: Colors.white, size: 20),
                        onPressed: () {
                          setState(() {
                            isEditDailyTarget = true;
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
              children: (data.dailyTarget >= dailyTransactionAmount)
                  ? [
                      Text(
                        'Rp ${data.dailyTarget - dailyTransactionAmount}',
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
                        'Rp ${dailyTransactionAmount - data.dailyTarget}',
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
          child: Transactions(
            dailyTransactionAmount: dailyTransactionAmount,
            transactions: data.transactions,
          ),
        ),
      ],
    );
  }
}

class Detailtransaction extends StatelessWidget {
  Detailtransaction({Key? key, required this.transactions}) : super(key: key);

  List<Transaction> transactions;

  List<RowTransaction> loadDetailTransaction(List<Transaction> transactions) {
    List<RowTransaction> listRow = [];
    if (!transactions.isEmpty) {
      for (int i = 0; i < transactions.length; i++) {
        listRow.add(RowTransaction(
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

class RowTransaction extends StatelessWidget {
  const RowTransaction(
      {Key? key, required this.amount, required this.description})
      : super(key: key);

  final int amount;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text('$amount', style: interText(Colors.white, 12)),
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

class Transactions extends StatelessWidget {
  const Transactions(
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
          Expanded(child: Detailtransaction(transactions: transactions)),
        ],
      ),
    );
  }
}

class DailyTarget extends StatelessWidget {
  const DailyTarget(
      {Key? key,
      required this.dailyTarget,
      required this.dailyTransactionAmount})
      : super(key: key);

  final int dailyTarget;
  final int dailyTransactionAmount;

  @override
  Widget build(BuildContext context) {
    return Column(
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
            Text(
              '( Rp $dailyTarget )',
              style: poppinsText(green, 12),
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
                    'Rp ${dailyTarget - dailyTransactionAmount}',
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
                    'Rp ${dailyTransactionAmount - dailyTarget}',
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
    );
  }
}

class Date extends StatelessWidget {
  const Date({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: lightBlue,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
            child: Text(
              'Hari Ini',
              style: interText(green, 14),
            ),
          ),
        ),
      ],
    );
  }
}
