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

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCoin = 'None';
  bool _isLoading = false;
  int _selectedTabIndex = 0;
  final ApiService _apiService = ApiService();
  List<Coin> coins = [];

  @override
  void initState() {
    super.initState();
    fetchCoins();
  }

  Future<void> fetchCoins() async {
    setState(() => _isLoading = true);
    try {
      final coinList = await _apiService.fetchCoins();
      coins = coinList;
      print(coins);
    } catch (e) {
      print('❌ Error fetching coins: $e');
    }
    setState(() => _isLoading = false);
  }

  void _onTabChanged(int index) async {
    if (_selectedTabIndex == index) return;

    setState(() {
      _isLoading = true;
      _selectedTabIndex = index;
    });

    // Optional: simulate a small delay to show loading spinner (even if using same coins)
    await Future.delayed(const Duration(milliseconds: 500));

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

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
            // const SizedBox(height: 4),

            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 12),
            //   child: Row(
            //     children: [
            //       ElevatedButton(
            //         onPressed: () {},
            //         style: ElevatedButton.styleFrom(
            //           backgroundColor:
            //               isDark ? Colors.grey[800] : const Color(0xFFEFEFEF),
            //           foregroundColor: theme.textTheme.bodyMedium?.color,
            //           elevation: 0,
            //           padding: const EdgeInsets.symmetric(
            //             horizontal: 10,
            //             vertical: 4,
            //           ),
            //           shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(6),
            //           ),
            //           textStyle: GoogleFonts.inter(
            //             fontWeight: FontWeight.w500,
            //             fontSize: 12,
            //           ),
            //           minimumSize: const Size(0, 28),
            //           tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            //         ),
            //         child: const Text('USD'),
            //       ),
            //       const SizedBox(width: 8),
            //       ElevatedButton.icon(
            //         onPressed: () {},
            //         icon: Icon(
            //           Icons.tune,
            //           size: 14,
            //           color: theme.iconTheme.color,
            //         ),
            //         label: const Text('Customize'),
            //         style: ElevatedButton.styleFrom(
            //           backgroundColor:
            //               isDark ? Colors.grey[800] : const Color(0xFFEFEFEF),
            //           foregroundColor: theme.textTheme.bodyMedium?.color,
            //           elevation: 0,
            //           padding: const EdgeInsets.symmetric(
            //             horizontal: 10,
            //             vertical: 4,
            //           ),
            //           shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(6),
            //           ),
            //           textStyle: GoogleFonts.inter(
            //             fontWeight: FontWeight.w500,
            //             fontSize: 12,
            //           ),
            //           minimumSize: const Size(0, 28),
            //           tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            Expanded(
              child:
                  _isLoading
                      ? const Center(
                        child: CircularProgressIndicator(color: Colors.green),
                      )
                      : coins.isEmpty
                      ? const Center(
                        child: Text(
                          'No data available',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      )
                      : CoinsTable(coins: coins),
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
