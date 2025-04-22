import 'package:flutter/material.dart';
import 'package:rwa_app/screens/add_portfolio_transaction_screen.dart';

class CoinSearchScreen extends StatefulWidget {
  const CoinSearchScreen({super.key});

  @override
  State<CoinSearchScreen> createState() => _CoinSearchScreenState();
}

class _CoinSearchScreenState extends State<CoinSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  final List<Map<String, dynamic>> coins = [
    {
      "name": "LINK",
      "symbol": "Chainlink",
      "change": -1.99,
      "logo": "assets/logo.png",
    },
    {
      "name": "AVAX",
      "symbol": "Avalanche",
      "change": -3.01,
      "logo": "assets/logo.png",
    },
    {
      "name": "HBAR",
      "symbol": "Hedera",
      "change": 2.01,
      "logo": "assets/logo.png",
    },
    {
      "name": "OM",
      "symbol": "Mantra",
      "change": 0.69,
      "logo": "assets/logo.png",
    },
    {
      "name": "ONDO",
      "symbol": "Ondo",
      "change": 5.23,
      "logo": "assets/logo.png",
    },
    {
      "name": "VET",
      "symbol": "VeChain",
      "change": -3.38,
      "logo": "assets/logo.png",
    },
    {
      "name": "ALGO",
      "symbol": "Algorand",
      "change": -3.38,
      "logo": "assets/logo.png",
    },
    {
      "name": "XDC",
      "symbol": "XDC Network",
      "change": 13.46,
      "logo": "assets/logo.png",
    },
    {
      "name": "MKR",
      "symbol": "Maker",
      "change": 1.43,
      "logo": "assets/logo.png",
    },
    {
      "name": "INJ",
      "symbol": "Injective",
      "change": 1.41,
      "logo": "assets/logo.png",
    },
    {
      "name": "QNT",
      "symbol": "Quant",
      "change": -1.21,
      "logo": "assets/logo.png",
    },
    {
      "name": "IOTA",
      "symbol": "IOTA",
      "change": 0.48,
      "logo": "assets/logo.png",
    },
  ];

  final List<int> recentlyAddedIndices = [0, 1]; // LINK and AVAX

  @override
  Widget build(BuildContext context) {
    final filteredCoins =
        _isSearching && _searchController.text.isNotEmpty
            ? coins.where((coin) {
              final query = _searchController.text.toLowerCase();
              return coin['name'].toLowerCase().contains(query) ||
                  coin['symbol'].toLowerCase().contains(query);
            }).toList()
            : coins;

    final recentlyAdded =
        recentlyAddedIndices
            .map((i) => coins[i])
            .where((coin) => filteredCoins.contains(coin))
            .toList();

    final others =
        filteredCoins.where((coin) => !recentlyAdded.contains(coin)).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F7F7),
        elevation: 0,
        automaticallyImplyLeading: false,
        toolbarHeight: 80,
        titleSpacing: 0,
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
            Expanded(
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() => _isSearching = value.isNotEmpty);
                  },
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF16C784), // ✅ Green text color
                  ),
                  cursorColor: Color(0xFF16C784), // ✅ Green cursor
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    prefixIcon: const Icon(
                      Icons.search,
                      size: 20,
                      color: Colors.grey,
                    ),
                    suffixIcon:
                        _isSearching
                            ? GestureDetector(
                              onTap: () {
                                _searchController.clear();
                                setState(() => _isSearching = false);
                              },
                              child: const Icon(
                                Icons.close,
                                size: 18,
                                color: Colors.grey,
                              ),
                            )
                            : null,
                    hintText: "Search for coin",
                    hintStyle: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (recentlyAdded.isNotEmpty) ...[
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 12, 16, 8),
                child: Text(
                  "Recently Added",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1D1D1D),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(left: 16),
                  itemCount: recentlyAdded.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (_, i) {
                    final coin = recentlyAdded[i];
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEEF1F6),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        children: [
                          Image.asset(coin["logo"], width: 24, height: 24),
                          const SizedBox(width: 6),
                          Text(
                            coin["symbol"],
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF4D4D4D),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
            if (others.isNotEmpty) ...[
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Text(
                  "All Coins",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1D1D1D),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Color(0xFFF7F7F7)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.01),
                        blurRadius: 1,
                        offset: const Offset(0, .5),
                      ),
                    ],
                  ),
                  child: ListView.separated(
                    padding: const EdgeInsets.only(left: 12, right: 12),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: others.length,
                    separatorBuilder:
                        (_, __) => const Divider(
                          height: 0.5,
                          color: Color(0xFF000000),
                          thickness: 0.1,
                        ),
                    itemBuilder: (_, i) => _buildCoinTile(others[i]),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildCoinTile(Map<String, dynamic> coin) {
    final isUp = coin["change"] >= 0;
    final changeColor = isUp ? Color(0xFF16C784) : Color(0xFFFF3B30);
    final icon = isUp ? Icons.arrow_drop_up : Icons.arrow_drop_down;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => AddPortfolioTransactionScreen(coin: coin),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Image.asset(coin["logo"], width: 34, height: 34),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    coin["symbol"],
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: Color(0xFF000000),
                    ),
                  ),
                  Text(
                    coin["name"],
                    style: const TextStyle(
                      fontSize: 10,
                      color: Color(0xFF959595),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Icon(icon, size: 16, color: changeColor),
                Text(
                  "${coin['change'].abs().toStringAsFixed(2)}%",
                  style: TextStyle(
                    color: changeColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildCoinTile(Map<String, dynamic> coin) {
  //   final isUp = coin["change"] >= 0;
  //   final changeColor = isUp ? Color(0xFF16C784) : Color(0xFFFF3B30);
  //   final icon = isUp ? Icons.arrow_drop_up : Icons.arrow_drop_down;

  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 12),
  //     child: Row(
  //       children: [
  //         Image.asset('assets/logo.png', width: 34, height: 34),
  //         const SizedBox(width: 12),
  //         Expanded(
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text(
  //                 coin["symbol"],
  //                 style: const TextStyle(
  //                   fontWeight: FontWeight.w600,
  //                   fontSize: 12,
  //                   color: Color(0xFF000000),
  //                 ),
  //               ),
  //               Text(
  //                 coin["name"],
  //                 style: const TextStyle(
  //                   fontSize: 10,
  //                   color: Color(0xFF959595),
  //                   fontWeight: FontWeight.w400,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         Row(
  //           children: [
  //             Icon(icon, size: 16, color: changeColor),
  //             Text(
  //               "${coin['change'].abs().toStringAsFixed(2)}%",
  //               style: TextStyle(
  //                 color: changeColor,
  //                 fontWeight: FontWeight.w600,
  //                 fontSize: 12,
  //               ),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
