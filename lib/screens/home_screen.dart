import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rwa_app/api/api_service.dart';
import 'package:rwa_app/models/coin_model.dart';
import 'package:rwa_app/screens/chat_screen.dart';
import 'package:rwa_app/screens/coin_search_screen.dart';
import 'package:rwa_app/screens/coins_table_widget.dart';
import 'package:rwa_app/screens/profile_screen.dart';
import 'package:rwa_app/widgets/stats_card_widget.dart';
import 'package:rwa_app/widgets/tabbar_section_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = false;
  int _selectedTabIndex = 0;
  final ApiService _apiService = ApiService();
  List<Coin> allCoins = [];
  List<Coin> displayedCoins = [];

  double? marketCap;
  double? volume24h;
  double? marketCapChange;

  String? trendingCoinSymbol;
  String? trendingCoinDominance;
  String? trendingCoinImage; // ✅ New: coin image for Dominance card

  @override
  void initState() {
    super.initState();
    fetchCoinsAndHighlight();
  }

  Future<void> fetchCoinsAndHighlight() async {
    setState(() => _isLoading = true);
    try {
      final coinList = await _apiService.fetchCoins();
      final highlightData = await _apiService.fetchHighlightData();
      final topTrending = await _apiService.fetchTopTrendingCoin();

      allCoins = coinList;
      displayedCoins = allCoins;

      marketCap = highlightData['market_cap'];
      volume24h = highlightData['volume_24h'];
      marketCapChange = highlightData['market_cap_change_24h'];

      if (topTrending != null) {
        trendingCoinDominance =
            (topTrending['market_cap_change_percentage_24h'] ?? 0.0)
                .toStringAsFixed(2);
        trendingCoinSymbol =
            (topTrending['symbol'] ?? '').toString().toUpperCase();
        trendingCoinImage = topTrending['image']; // ✅ Assign image
      }
    } catch (e) {
      print('❌ Error fetching data: $e');
    }
    setState(() => _isLoading = false);
  }

  Future<List<String>> getFavoriteCoinIds() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('favorites') ?? [];
  }

  Future<void> _onTabChanged(int index) async {
    if (_selectedTabIndex == index) return;

    setState(() {
      _selectedTabIndex = index;
      _isLoading = true;
    });

    await Future.delayed(const Duration(milliseconds: 300));

    if (index == 2) {
      final favIds = await getFavoriteCoinIds();
      displayedCoins =
          allCoins.where((coin) => favIds.contains(coin.id)).toList();
    } else {
      displayedCoins = allCoins;
    }

    setState(() => _isLoading = false);
  }

  String formatNumber(double? value) {
    if (value == null) return '...';
    if (value >= 1e12) return '\$${(value / 1e12).toStringAsFixed(2)} T';
    if (value >= 1e9) return '\$${(value / 1e9).toStringAsFixed(2)} B';
    if (value >= 1e6) return '\$${(value / 1e6).toStringAsFixed(2)} M';
    if (value >= 1e3) return '\$${(value / 1e3).toStringAsFixed(2)} K';
    return '\$${value.toStringAsFixed(2)}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cardWidth = (MediaQuery.of(context).size.width - 24 - 6) / 4;

    return DefaultTabController(
      length: 5,
      initialIndex: _selectedTabIndex,
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: theme.appBarTheme.backgroundColor,
          elevation: theme.appBarTheme.elevation,
          automaticallyImplyLeading: false,
          toolbarHeight: 60,
          title: Row(
            children: [
              Image.asset('assets/logo.png', width: 32, height: 32),
              const SizedBox(width: 8),
              Text(
                'RWA CAMP',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          actions: [
            GestureDetector(
              onTap:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CoinSearchScreen()),
                  ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: SvgPicture.asset(
                  'assets/search_outline.svg',
                  width: 24,
                  height: 24,
                  color: theme.iconTheme.color,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: GestureDetector(
                onTap:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ProfileScreen()),
                    ),
                child: SvgPicture.asset(
                  'assets/profile_outline.svg',
                  width: 30,
                  height: 30,
                  color: theme.iconTheme.color,
                ),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  StatCard(
                    title: 'Market Cap',
                    value: formatNumber(marketCap),
                    change:
                        marketCapChange != null
                            ? '${marketCapChange! >= 0 ? '+' : ''}${marketCapChange!.toStringAsFixed(1)}%'
                            : '',
                    changeColor:
                        marketCapChange == null
                            ? Colors.grey
                            : marketCapChange! >= 0
                            ? Colors.green
                            : Colors.red,
                    width: cardWidth,
                    isFirst: true,
                  ),
                  const SizedBox(width: 2),
                  StatCard(
                    title: 'Volume',
                    value: formatNumber(volume24h),
                    change: '24H',
                    changeColor: Colors.white,
                    width: cardWidth,
                  ),
                  const SizedBox(width: 2),
                  StatCard(
                    title: 'Dominance',
                    value:
                        trendingCoinDominance != null
                            ? '$trendingCoinDominance%'
                            : '...',
                    subtitle: trendingCoinSymbol ?? '',
                    imageUrl: trendingCoinImage, // ✅ Use live image
                    changeColor: Colors.blue,
                    width: cardWidth,
                  ),
                  const SizedBox(width: 2),
                  StatCard(
                    title: 'Fear & Greed',
                    value: _isLoading ? '...' : '31', // ✅ Show loading state
                    changeColor: Colors.red,
                    width: cardWidth,
                    isLast: true,
                    isFearGreed: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 2),
            TabBarSection(onTap: _onTabChanged),
            Expanded(
              child:
                  _isLoading
                      ? const Center(
                        child: CircularProgressIndicator(color: Colors.green),
                      )
                      : displayedCoins.isEmpty
                      ? Center(
                        child: Text(
                          _selectedTabIndex == 2
                              ? 'No favorite coins added yet'
                              : 'No data available',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      )
                      : CoinsTable(coins: displayedCoins),
            ),
          ],
        ),
        floatingActionButton: SizedBox(
          width: 56,
          height: 56,
          child: FloatingActionButton(
            onPressed:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ChatScreen()),
                ),
            backgroundColor: const Color(0xFF348F6C),
            shape: const CircleBorder(),
            child: SvgPicture.asset(
              'assets/bot_light.svg',
              width: 40,
              height: 40,
              fit: BoxFit.contain,
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
