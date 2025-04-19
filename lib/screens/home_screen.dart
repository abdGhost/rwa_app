import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rwa_app/data/coins_list.dart';
import 'package:rwa_app/screens/coin_search_screen.dart';
import 'package:rwa_app/screens/coins_table_widget.dart';
import 'package:rwa_app/widgets/stats_card_widget.dart';
import 'package:rwa_app/widgets/tabbar_section_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCoin = 'None';

  // Add this state variable in _HomeScreenState
  int _currentTabIndex = 0;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Optional: simulate loading delay for initial tab
    _simulateTabLoading();
  }

  void _simulateTabLoading() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(247, 247, 247, 1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        automaticallyImplyLeading: false,
        toolbarHeight: 60,
        title: Row(
          children: [
            Image.asset('assets/logo.png', width: 32, height: 32),
            const SizedBox(width: 8),
            Text(
              'RWA CAMP',
              style: GoogleFonts.inter(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CoinSearch()),
              );
              if (result != null) {
                setState(() {
                  selectedCoin = result;
                });
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: SvgPicture.asset(
                'assets/search_outline.svg',
                width: 24,
                height: 24,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: SvgPicture.asset(
              'assets/profile_outline.svg',
              width: 30,
              height: 30,
            ),
          ),
        ],
      ),
      body: DefaultTabController(
        length: 5,
        child: StatefulBuilder(
          builder: (context, setState) {
            final TabController controller = DefaultTabController.of(context);
            int currentIndex = controller.index;
            bool isLoading = false;

            controller.addListener(() {
              setState(() => isLoading = true);
              Future.delayed(const Duration(milliseconds: 300), () {
                setState(() => isLoading = false);
              });
            });

            final List<List<Map<String, Object>>> tabData = [
              allCoins,
              topCoins,
              watchlistCoins,
              trendingCoins,
              topGainers,
            ];

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      StatCard(
                        title: 'Market Cap',
                        value: '\$2.79 T',
                        change: '5.78%',
                        changeColor: const Color.fromARGB(255, 109, 247, 114),
                        width: (MediaQuery.of(context).size.width - 24 - 6) / 4,
                        isFirst: true,
                      ),
                      const SizedBox(width: 2),
                      StatCard(
                        title: 'Volume',
                        value: '\$3.48 T',
                        change: '8.59%',
                        changeColor: const Color.fromARGB(255, 109, 247, 114),
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
                const TabBarSection(),
                const SizedBox(height: 0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(
                            238,
                            241,
                            246,
                            1,
                          ),
                          foregroundColor: const Color.fromRGBO(0, 0, 0, 1),
                          elevation: 0,
                          side: const BorderSide(
                            color: Color.fromRGBO(238, 241, 246, 1),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          textStyle: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                          minimumSize: const Size(0, 28),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: const Text('USD'),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.tune, size: 14),
                        label: const Text('Customize'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(
                            238,
                            241,
                            246,
                            1,
                          ),
                          foregroundColor: const Color.fromRGBO(0, 0, 0, 1),
                          elevation: 0,
                          side: const BorderSide(
                            color: Color.fromRGBO(238, 241, 246, 1),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          textStyle: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                          minimumSize: const Size(0, 28),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: List.generate(tabData.length, (index) {
                      final data = tabData[index];
                      if (isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (data.isEmpty) {
                        return const Center(child: Text('No data available'));
                      } else {
                        return CoinsTable(coins: data);
                      }
                    }),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
