import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spend/models/data.dart';
import 'package:spend/models/transaction.dart';
import 'package:spend/screens/home_screen.dart';
import 'package:spend/theme.dart';
import 'dart:convert';

class InputScreen extends StatefulWidget {
  const InputScreen({Key? key, required this.data}) : super(key: key);

  final Data data;

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  Data data = Data(balance: 0, dailyTarget: 0, transactions: []);
  int amount = 0;
  String description = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = widget.data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Tambah Transaksi',
          style: interText(green, 20, FontWeight.w500),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Jumlah transaksi',
              style: poppinsText(grey, 12),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: lightBlue,
              ),
              child: TextField(
                style: interText(Colors.white, 20, FontWeight.bold),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                decoration: InputDecoration(
                  prefixText: 'Rp ',
                  prefixStyle: interText(Colors.white, 20, FontWeight.bold),
                  border: InputBorder.none,
                ),
                onChanged: (String value) {
                  print(value);
                  setState(() {
                    try {
                      amount = int.parse(value);
                    } catch (e) {
                      amount = 0;
                    }
                  });
                },
              ),
            ),
            SizedBox(
              height: 28,
            ),
            Text(
              'Deskripsi',
              style: poppinsText(grey, 12),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: lightBlue,
              ),
              child: TextField(
                style: poppinsText(Colors.white, 16),
                minLines: 5,
                maxLines: 5,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                onChanged: (String value) {
                  setState(() {
                    description = value;
                  });
                },
              ),
            ),
            SizedBox(
              height: 28,
            ),
            Container(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                  onPressed: () {
                    if (amount > 0 && amount <= data.balance) {
                      data.balance -= amount;
                      data.transactions.add(Transaction(
                          amount: amount, description: description));
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => HomeScreen(data: data))),
                          (route) => false);
                    } else if (amount < 0 ){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          "Maaf, jumlah transaksi yang anda masukan tidak valid.",
                          style: interText(Colors.white, 16),
                        ),
                        backgroundColor: red,
                        duration: Duration(seconds: 2),
                      ));
                    } else if (amount > data.balance) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          "Maaf, sisa saldo tidak mencukupi.",
                          style: interText(Colors.white, 16),
                        ),
                        backgroundColor: red,
                        duration: Duration(seconds: 2),
                      ));
                    }
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                    child: Text(
                      'Submit',
                      style: poppinsText(blue, 20, FontWeight.w500),
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(green),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    )),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}