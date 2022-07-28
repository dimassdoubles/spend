import 'package:flutter/material.dart';
import 'package:spend/screens/home-screen/views/mobile_view.dart';
import 'package:spend/screens/home-screen/views/web_view.dart';
import 'package:spend/screens/input_screen.dart';

import 'package:spend/theme.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = "/home";

  const HomeScreen({Key? key}) : super(key: key);

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
            Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => InputScreen()));
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
              return WebView();
            } else if (constraints.maxWidth >= 550) {
              return WebView();
            } else {
              return MobileView();
            }
          }),
        ),
      ),
    );
  }
}