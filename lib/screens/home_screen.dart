import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:spend/theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _balance = 0;
  int _dailyTarget = 0;
  int _dailyTransactionAmount = 0;
  List _transactions = [];

  Future<void> readData() async {
    final String response = await rootBundle.loadString('assets/data.json');
    final data = await json.decode(response);
    setState(() {
      _balance = data["balance"];
      _dailyTarget = data["daily_target"];
      _transactions = data["transactions"];
      for (int i = 0; i < _transactions[0]["detail_transaction"].length; i++) {
        int x = _transactions[0]["detail_transaction"][i]["amount"];
        _dailyTransactionAmount += x;
      }
    });
    print("selesai membaca data");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(10),
        child: FloatingActionButton(
          onPressed: () {
            setState(() {
              // reset all state
              _dailyTransactionAmount = 0;

              print("set state");
              readData();
            });
          },
          backgroundColor: green,
          child: Icon(Icons.add, color: blue),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            const SizedBox(
              height: 28,
            ),
            const Header(),
            const SizedBox(
              height: 32,
            ),
            Balance(balance: _balance),
            const SizedBox(
              height: 28,
            ),
            const Date(),
            const SizedBox(
              height: 28,
            ),
            DailyTarget(
              dailyTarget: _dailyTarget,
              dailyTransactionAmount: _dailyTransactionAmount,
            ),
            const SizedBox(
              height: 28,
            ),
            Transactions(
              dailyTransactionAmount: _dailyTransactionAmount,
              transactions: _transactions,
            ),
          ],
        ),
      ),
    );
  }
}

class Detailtransaction extends StatelessWidget {
  Detailtransaction({Key? key, required this.transactions}) : super(key: key);

  List transactions;

  List<RowTransaction> loadDetailTransaction(List transactions) {
    List<RowTransaction> listRow = [];
    if (!transactions.isEmpty) {
      for (int i = 0; i < transactions[0]["detail_transaction"].length; i++) {
        listRow.add(RowTransaction(
          amount: transactions[0]["detail_transaction"][i]["amount"],
          description: transactions[0]["detail_transaction"][i]["description"]
        ));
      }
    } else {
      print("transaksi kosong");
    }

    return listRow;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  color: lightBlue,
                  borderRadius: BorderRadius.circular(15)),
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
  final List transactions;

  @override
  Widget build(BuildContext context) {
    return Column(
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
        Padding(
          padding: EdgeInsets.all(10),
          child: Detailtransaction(transactions: transactions),
        ),
      ],
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

class Balance extends StatelessWidget {
  const Balance({Key? key, required this.balance}) : super(key: key);

  final int balance;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Total saldo',
          style: poppinsText(grey, 12),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          'Rp $balance',
          style: interText(Colors.white, 20, FontWeight.bold),
        ),
      ],
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Text(
        'SPEND',
        style: interText(green, 32, FontWeight.bold),
      ),
    );
  }
}
