import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
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

  @override
  void initState() {
    super.initState();
    fetchCoins();
  }

  Future<void> fetchCoins() async {
    setState(() => _isLoading = true);
    try {
      final coinList = await _apiService.fetchCoins();
      allCoins = coinList;
      displayedCoins = allCoins;
    } catch (e) {
      print('❌ Error fetching coins: $e');
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
      // 3rd tab = Watchlist
      final favIds = await getFavoriteCoinIds();
      displayedCoins =
          allCoins.where((coin) => favIds.contains(coin.id)).toList();
    } else {
      displayedCoins = allCoins;
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
                    value: '\$2.79 T',
                    change: '5.78%',
                    changeColor: Colors.green,
                    width: (MediaQuery.of(context).size.width - 24 - 6) / 4,
                    isFirst: true,
                  ),
                  const SizedBox(width: 2),
                  StatCard(
                    title: 'Volume',
                    value: '\$3.48 T',
                    change: '8.59%',
                    changeColor: Colors.green,
                    width: (MediaQuery.of(context).size.width - 24 - 6) / 4,
                  ),
                  const SizedBox(width: 2),
                  StatCard(
                    title: 'Dominance',
                    value: '26.46%',
                    subtitle: 'LINK',
                    changeColor: Colors.blue,
                    width: (MediaQuery.of(context).size.width - 24 - 6) / 4,
                  ),
                  const SizedBox(width: 2),
                  StatCard(
                    title: 'Fear & Greed',
                    value: '31',
                    changeColor: Colors.red,
                    width: (MediaQuery.of(context).size.width - 24 - 6) / 4,
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
                  MaterialPageRoute(builder: (context) => const ChatScreen()),
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
