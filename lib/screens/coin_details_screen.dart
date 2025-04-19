import 'package:flutter/material.dart';

class CoinDetailScreen extends StatelessWidget {
  final String coinName;
  const CoinDetailScreen({super.key, required this.coinName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$coinName Details')),
      body: Center(
        child: Text(
          'Details for $coinName',
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
