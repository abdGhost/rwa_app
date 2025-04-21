import 'package:flutter/material.dart';

class AddCoinScreen extends StatelessWidget {
  const AddCoinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> coins = [
      {"name": "LINK", "change": -1.99},
      {"name": "AVAX", "change": -3.01},
      {"name": "HBAR", "change": 2.01},
      {"name": "OM", "change": 0.69},
      {"name": "ONDO", "change": 5.23},
      {"name": "VET", "change": -3.38},
      {"name": "ALGO", "change": -3.38},
      {"name": "XDC", "change": 13.46},
      {"name": "MKR", "change": 1.43},
      {"name": "INJ", "change": 1.41},
      {"name": "QNT", "change": -1.21},
      {"name": "IOTA", "change": -0.48},
    ];

    return Scaffold(
      backgroundColor: const Color.fromRGBO(247, 247, 247, 1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Add Coin", style: TextStyle(color: Colors.black)),
        leading: const BackButton(color: Colors.black),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search for coin",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Chip(label: Text("LINK")),
                SizedBox(width: 8),
                Chip(label: Text("AVAX")),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              itemCount: coins.length,
              itemBuilder: (context, index) {
                final coin = coins[index];
                final String name = coin['name'] as String;
                final double change = coin['change'] as double;

                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey.shade200,
                    child: Text(
                      name[0],
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                  title: Text(name),
                  trailing: Text(
                    "${change.toStringAsFixed(2)}%",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: change >= 0 ? Colors.green : Colors.red,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
