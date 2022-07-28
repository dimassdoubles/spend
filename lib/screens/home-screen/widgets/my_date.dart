import 'package:flutter/material.dart';
import 'package:spend/theme.dart';

class MyDate extends StatelessWidget {
  const MyDate({
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
