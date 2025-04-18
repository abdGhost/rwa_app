import 'package:flutter/material.dart';

class CoinSearch extends StatefulWidget {
  const CoinSearch({super.key});

  @override
  State<CoinSearch> createState() => _CoinSearchState();
}

class _CoinSearchState extends State<CoinSearch> {
  final TextEditingController _searchController = TextEditingController();

  final List<String> allCoins = [
    'Bitcoin',
    'Ethereum',
    'Solana',
    'Cardano',
    'Polkadot',
    'Avalanche',
    'Polygon',
    'Ripple',
    'Litecoin',
    'Chainlink',
  ];

  List<String> filteredCoins = [];

  @override
  void initState() {
    super.initState();
    filteredCoins = allCoins;
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredCoins =
          allCoins.where((coin) => coin.toLowerCase().contains(query)).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Coins'),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: const TextStyle(color: Colors.black, fontSize: 18),
        elevation: 1,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search coin name...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredCoins.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(filteredCoins[index]),
                  onTap: () {
                    Navigator.pop(
                      context,
                      filteredCoins[index],
                    ); // return result
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
