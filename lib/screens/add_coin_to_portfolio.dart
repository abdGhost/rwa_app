import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rwa_app/models/coin_model.dart' show Coin, CurrenciesResponse;
import 'package:rwa_app/screens/add_portfolio_transaction_screen.dart';
import 'package:rwa_app/screens/portfolio_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddCoinToPortfolioScreen extends StatefulWidget {
  const AddCoinToPortfolioScreen({super.key});

  @override
  State<AddCoinToPortfolioScreen> createState() =>
      _AddCoinToPortfolioScreenState();
}

class _AddCoinToPortfolioScreenState extends State<AddCoinToPortfolioScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;
  bool _isLoading = true;

  List<Coin> coins = [];
  final List<int> recentlyAddedIndices = [0, 1];

  static const String _baseUrl = "https://rwa-f1623a22e3ed.herokuapp.com/api";

  @override
  void initState() {
    super.initState();
    fetchCoins();
  }

  Future<void> fetchCoins({int page = 1, int size = 25}) async {
    try {
      final uri = Uri.parse("$_baseUrl/currencies?page=$page&size=$size");
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final parsed = CurrenciesResponse.fromJson(json);

        setState(() {
          coins = parsed.currencies;
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load coins: ${response.body}');
      }
    } catch (e) {
      print('❌ Error fetching coins: $e');
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final filteredCoins =
        _isSearching && _searchController.text.isNotEmpty
            ? coins.where((coin) {
              final query = _searchController.text.toLowerCase();
              return coin.name.toLowerCase().contains(query) ||
                  coin.symbol.toLowerCase().contains(query);
            }).toList()
            : coins;

    final recentlyAdded =
        recentlyAddedIndices
            .where((index) => index < coins.length)
            .map((i) => coins[i])
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
      body:
          _isLoading
              ? const Center(
                child: CircularProgressIndicator(color: Colors.green),
              )
              : SingleChildScrollView(
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
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    isDark
                                        ? Colors.white10
                                        : const Color(0xFFEEF1F6),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Row(
                                children: [
                                  Image.network(
                                    coin.image,
                                    width: 24,
                                    height: 24,
                                    errorBuilder:
                                        (_, __, ___) => const Icon(Icons.image),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    coin.symbol.toUpperCase(),
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
                        child: Text(
                          "All Coins",
                          style: theme.textTheme.titleSmall,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                          decoration: BoxDecoration(
                            color: theme.cardColor,
                            borderRadius: BorderRadius.circular(12),
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
                                  color:
                                      isDark
                                          ? Colors.grey.shade800
                                          : Colors.black12,
                                  thickness: 0.1,
                                  height: 0.5,
                                ),
                            itemBuilder:
                                (_, i) => _buildCoinTile(context, others[i]),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
    );
  }

  Widget _buildCoinTile(BuildContext context, Coin coin) {
    final isUp = coin.priceChange24h >= 0;
    final changeColor =
        isUp ? const Color(0xFF16C784) : const Color(0xFFFF3B30);
    final icon = isUp ? Icons.arrow_drop_up : Icons.arrow_drop_down;
    final theme = Theme.of(context);

    return InkWell(
      onTap: () async {
        try {
          // Load token
          final prefs = await SharedPreferences.getInstance();
          final token = prefs.getString('token') ?? '';

          if (token.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Authentication token missing.')),
            );
            return;
          }

          // API Call
          final response = await http.get(
            Uri.parse(
              'https://rwa-f1623a22e3ed.herokuapp.com/api/user/token/add/portfolio/${coin.id}',
            ),
            headers: {'Authorization': 'Bearer $token'},
          );

          print(response.body);

          if (response.statusCode == 200) {
            final data = jsonDecode(response.body);
            if (data['status'] == true) {
              // Success
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => PortfolioScreen()),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Failed to add coin: ${data['message']}'),
                ),
              );
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Server error while adding coin.')),
            );
          }
        } catch (e) {
          print('❌ Error adding coin to portfolio: $e');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Error connecting to server.')),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Image.network(
              coin.image,
              width: 34,
              height: 34,
              errorBuilder: (_, __, ___) => const Icon(Icons.image),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    coin.symbol.toUpperCase(),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    coin.name,
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
                  "${coin.priceChange24h.abs().toStringAsFixed(2)}%",
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
