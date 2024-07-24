import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final String text;
  const MyText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return buildText();
  }

  Text buildText() {
    return Text(
      text,
      style: TextStyle(
        color: Colors.purple,
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
