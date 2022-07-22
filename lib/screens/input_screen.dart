import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spend/theme.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';

class InputScreen extends StatefulWidget {
  const InputScreen({Key? key}) : super(key: key);

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  int _amount = 0;
  String _description = "";

  
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
                onChanged: (String amount) {
                  print(amount);
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
                onChanged: (String amount) {
                  print(amount);
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
