import 'package:flutter/material.dart';
import 'package:rwa_app/screens/add_portfolio_transaction_screen.dart';

class AddCoinToPortfolioScreen extends StatefulWidget {
  const AddCoinToPortfolioScreen({super.key});

  @override
  State<AddCoinToPortfolioScreen> createState() =>
      _AddCoinToPortfolioScreenState();
}

class _AddCoinToPortfolioScreenState extends State<AddCoinToPortfolioScreen> {
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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

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
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        toolbarHeight: 80,
        titleSpacing: 0,
        title: Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back, color: theme.iconTheme.color),
              onPressed: () => Navigator.pop(context),
            ),
            Expanded(
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: TextField(
                  controller: _searchController,
                  onChanged:
                      (value) =>
                          setState(() => _isSearching = value.isNotEmpty),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF16C784),
                  ),
                  cursorColor: const Color(0xFF16C784),
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    prefixIcon: const Icon(Icons.search, size: 20),
                    suffixIcon:
                        _isSearching
                            ? GestureDetector(
                              onTap: () {
                                _searchController.clear();
                                setState(() => _isSearching = false);
                              },
                              child: const Icon(Icons.close, size: 18),
                            )
                            : null,
                    hintText: "Search for coin",
                    hintStyle: theme.textTheme.bodySmall?.copyWith(
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
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                child: Text(
                  "Recently Added",
                  style: theme.textTheme.titleSmall,
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
                        color:
                            isDark ? Colors.white10 : const Color(0xFFEEF1F6),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        children: [
                          Image.asset(coin["logo"], width: 24, height: 24),
                          const SizedBox(width: 6),
                          Text(
                            coin["symbol"],
                            style: theme.textTheme.bodySmall,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
            if (others.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Text("All Coins", style: theme.textTheme.titleSmall),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: theme.cardColor,
                    borderRadius: BorderRadius.circular(12),
                    // border: Border.all(color: theme.dividerColor),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.01),
                        blurRadius: 1,
                        offset: const Offset(0, .5),
                      ),
                    ],
                  ),
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: others.length,
                    separatorBuilder:
                        (_, __) => Divider(
                          color: isDark ? Colors.grey.shade800 : Colors.black12,
                          thickness: 0.1,
                          height: 0.5,
                        ),
                    itemBuilder: (_, i) => _buildCoinTile(context, others[i]),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildCoinTile(BuildContext context, Map<String, dynamic> coin) {
    final isUp = coin["change"] >= 0;
    final changeColor =
        isUp ? const Color(0xFF16C784) : const Color(0xFFFF3B30);
    final icon = isUp ? Icons.arrow_drop_up : Icons.arrow_drop_down;
    final theme = Theme.of(context);

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
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    coin["name"],
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.grey,
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
}
