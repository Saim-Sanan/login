import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  Map<String, dynamic> data;
  Dashboard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Text(data.toString()),
        ),
      ),
    );
  }
}
