import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(CashBox());
}

class CashBox extends StatelessWidget {
  const CashBox({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(),
    );
  }
}
