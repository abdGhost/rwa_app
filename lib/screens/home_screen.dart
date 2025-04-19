import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rwa_app/screens/coin_search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCoin = 'None';

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
        child: Column(
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

            // Tab Bar
            const TabBarSection(),

            // 👉 Add Button Row here
            const SizedBox(height: 0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  // USD Button
                  // rgba(238, 241, 246, 1)
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(238, 241, 246, 1),
                      foregroundColor: Color.fromRGBO(0, 0, 0, 1),
                      elevation: 0,
                      side: const BorderSide(
                        color: Color.fromRGBO(238, 241, 246, 1),
                        width: 1,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4, // 👈 smaller height
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      textStyle: GoogleFonts.inter(
                        fontWeight: FontWeight.w500,
                        fontSize: 12, // 👈 smaller font
                      ),
                      minimumSize: const Size(
                        0,
                        28,
                      ), // 👈 tighter height constraint
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text('USD'),
                  ),
                  const SizedBox(width: 8),

                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.tune, size: 14), // 👈 smaller icon
                    label: const Text('Customize'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(238, 241, 246, 1),
                      foregroundColor: Color.fromRGBO(0, 0, 0, 1),
                      elevation: 0,
                      side: const BorderSide(
                        color: Color.fromRGBO(238, 241, 246, 1),
                        width: 1,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4, // 👈 tighter padding
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

            // Tab View
            Expanded(
              child: TabBarView(
                children: [
                  const AllCoinsTable(),
                  Center(child: Text('Top Coins')),
                  Center(child: Text('Watchlist')),
                  Center(child: Text('Trending')),
                  Center(child: Text('Top Gainers')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AllCoinsTable extends StatelessWidget {
  const AllCoinsTable({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, Object>> coins = [
      {
        'rank': 1,
        'name': 'LINK',
        'price': '\$12.719',
        'change': '-1.991%',
        'changeColor': Colors.red,
        'marketCap': '\$8,354,278,807',
        'icon': 'assets/logo.png',
      },
      {
        'rank': 2,
        'name': 'AVAX',
        'price': '\$19.1032',
        'change': '-3.014%',
        'changeColor': Colors.red,
        'marketCap': '\$7,943,278,710',
        'icon': 'assets/logo.png',
      },
      {
        'rank': 3,
        'name': 'HBAR',
        'price': '\$0.16849',
        'change': '+2.012%',
        'changeColor': Colors.green,
        'marketCap': '\$7,116,928,090',
        'icon': 'assets/logo.png',
      },
      {
        'rank': 4,
        'name': 'OM',
        'price': '\$6.385',
        'change': '+0.692%',
        'changeColor': Colors.green,
        'marketCap': '\$6,186,811,651',
        'icon': 'assets/logo.png',
      },
      {
        'rank': 1,
        'name': 'LINK',
        'price': '\$12.719',
        'change': '-1.991%',
        'changeColor': Colors.red,
        'marketCap': '\$8,354,278,807',
        'icon': 'assets/logo.png',
      },
      {
        'rank': 2,
        'name': 'AVAX',
        'price': '\$19.1032',
        'change': '-3.014%',
        'changeColor': Colors.red,
        'marketCap': '\$7,943,278,710',
        'icon': 'assets/logo.png',
      },
      {
        'rank': 3,
        'name': 'HBAR',
        'price': '\$0.16849',
        'change': '+2.012%',
        'changeColor': Colors.green,
        'marketCap': '\$7,116,928,090',
        'icon': 'assets/logo.png',
      },
      {
        'rank': 4,
        'name': 'OM',
        'price': '\$6.385',
        'change': '+0.692%',
        'changeColor': Colors.green,
        'marketCap': '\$6,186,811,651',
        'icon': 'assets/logo.png',
      },
      {
        'rank': 1,
        'name': 'LINK',
        'price': '\$12.719',
        'change': '-1.991%',
        'changeColor': Colors.red,
        'marketCap': '\$8,354,278,807',
        'icon': 'assets/logo.png',
      },
      {
        'rank': 2,
        'name': 'AVAX',
        'price': '\$19.1032',
        'change': '-3.014%',
        'changeColor': Colors.red,
        'marketCap': '\$7,943,278,710',
        'icon': 'assets/logo.png',
      },
      {
        'rank': 3,
        'name': 'HBAR',
        'price': '\$0.16849',
        'change': '+2.012%',
        'changeColor': Colors.green,
        'marketCap': '\$7,116,928,090',
        'icon': 'assets/logo.png',
      },
      {
        'rank': 4,
        'name': 'OM',
        'price': '\$6.385',
        'change': '+0.692%',
        'changeColor': Colors.green,
        'marketCap': '\$6,186,811,651',
        'icon': 'assets/logo.png',
      },
    ];

    return Column(
      children: [
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: _buildHeaderRow(),
        ),
        const Divider(
          height: 1,
          thickness: .6,
          color: Color.fromARGB(255, 194, 194, 194),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: coins.length,
            itemBuilder: (context, index) {
              final coin = coins[index];
              final priceRaw = (coin['price'] as String).replaceAll(
                RegExp(r'[^\d.]'),
                '',
              );
              final changeRaw = (coin['change'] as String).replaceAll(
                RegExp(r'[^\d.]'),
                '',
              );
              final isNegative = (coin['change'] as String)
                  .toString()
                  .startsWith('-');
              final isPositive = (coin['change'] as String)
                  .toString()
                  .startsWith('+');

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) => CoinDetailScreen(
                            coinName: coin['name'].toString(),
                          ),
                    ),
                  );
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 14,
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 20,
                            child: Center(
                              child: Text('${coin['rank']}', style: _rowStyle),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Image.asset(
                            coin['icon'] as String,
                            width: 20,
                            height: 20,
                          ),
                          const SizedBox(width: 0),
                          SizedBox(
                            width: 40,
                            child: Center(
                              child: Text(
                                coin['name'] as String,
                                style: _rowStyle,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: 50,
                            child: Center(
                              child: Text(
                                '\$${double.parse(priceRaw).toStringAsFixed(2)}',
                                style: _rowStyle,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: 50,
                            child: Center(
                              child: Text(
                                '${isNegative
                                    ? '-'
                                    : isPositive
                                    ? '+'
                                    : ''}${double.parse(changeRaw).toStringAsFixed(2)}%',
                                style: _rowStyle.copyWith(
                                  color: coin['changeColor'] as Color,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: 110,
                            child: Text(
                              coin['marketCap'] as String,
                              textAlign: TextAlign.center,
                              style: _rowStyle,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      height: 1,
                      thickness: .6,
                      color: Color.fromARGB(255, 194, 194, 194),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHeaderRow() {
    return SizedBox(
      height: 40,
      child: Row(
        children: const [
          SizedBox(
            width: 20,
            child: Center(child: Text('#', style: _headerStyle)),
          ),
          SizedBox(width: 8),
          SizedBox(width: 20), // Icon
          SizedBox(
            width: 40,
            child: Center(child: Text('Coin', style: _headerStyle)),
          ),
          SizedBox(width: 10),
          SizedBox(
            width: 50,
            child: Center(child: Text('Price', style: _headerStyle)),
          ),
          SizedBox(width: 10),
          SizedBox(
            width: 50,
            child: Center(child: Text('24H', style: _headerStyle)),
          ),
          SizedBox(width: 10),
          SizedBox(
            width: 110,
            child: Center(child: Text('Market Cap', style: _headerStyle)),
          ),
        ],
      ),
    );
  }

  static const TextStyle _headerStyle = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 12,
    color: Colors.grey,
  );

  static const TextStyle _rowStyle = TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 12,
    color: Colors.black,
  );
}

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

class TabBarSection extends StatelessWidget {
  const TabBarSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12), // match StatCard
      child: TabBar(
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        labelPadding: const EdgeInsets.only(right: 12),
        indicator: const UnderlineTabIndicator(
          borderSide: BorderSide(
            color: Color.fromARGB(255, 63, 167, 127),
            width: 2,
          ),
          insets: EdgeInsets.only(bottom: 10),
        ),
        indicatorSize: TabBarIndicatorSize.label,
        dividerColor: Colors.transparent,
        labelColor: Colors.black,
        unselectedLabelColor: Colors.grey,
        labelStyle: GoogleFonts.inter(
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
        unselectedLabelStyle: GoogleFonts.inter(fontSize: 13),
        tabs: const [
          Tab(text: "All Coins"),
          Tab(text: "Top Coins"),
          Tab(text: "Watchlist"),
          Tab(text: "Trending"),
          Tab(text: "Top Gainers"),
        ],
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String? subtitle;
  final String? change;
  final Color changeColor;
  final double width;
  final bool isFirst;
  final bool isLast;
  final bool isFearGreed;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    this.subtitle,
    this.change,
    required this.changeColor,
    required this.width,
    this.isFirst = false,
    this.isLast = false,
    this.isFearGreed = false,
  });

  String _getFearGreedSvg(int index) {
    if (index < 20) return 'assets/fear_greed/fear-1.svg';
    if (index < 40) return 'assets/fear_greed/fear-2.svg';
    if (index < 60) return 'assets/fear_greed/neutral.svg';
    if (index < 80) return 'assets/fear_greed/greed-1.svg';
    return 'assets/fear_greed/greed-2.svg';
  }

  @override
  Widget build(BuildContext context) {
    final int indexValue =
        int.tryParse(value.replaceAll(RegExp(r'\D'), '')) ?? 0;

    return Container(
      width: width,
      height: 90,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 63, 167, 127),
        borderRadius: BorderRadius.horizontal(
          left: isFirst ? const Radius.circular(12) : Radius.zero,
          right: isLast ? const Radius.circular(12) : Radius.zero,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment:
            isFearGreed ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          if (isFearGreed)
            Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset(
                  _getFearGreedSvg(indexValue),
                  width: 42,
                  height: 42,
                  fit: BoxFit.contain,
                ),
                Text(
                  '$indexValue',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            )
          else ...[
            Text(
              value,
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 1),
            if (subtitle != null && subtitle!.isNotEmpty)
              Row(
                children: [
                  Image.asset(
                    'assets/icons/${subtitle!.toLowerCase()}.png',
                    width: 14,
                    height: 14,
                    errorBuilder:
                        (_, __, ___) => Image.asset(
                          'assets/default-coin.png',
                          width: 16,
                          height: 16,
                        ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    subtitle!,
                    style: GoogleFonts.inter(fontSize: 12, color: Colors.white),
                  ),
                ],
              ),
            if (change != null)
              Row(
                children: [
                  Icon(
                    change!.startsWith('+')
                        ? Icons.arrow_upward
                        : Icons.arrow_downward,
                    size: 12,
                    color: changeColor,
                  ),
                  const SizedBox(width: 2),
                  Text(
                    change!.replaceAll(RegExp(r'^[\+\-]'), ''),
                    style: GoogleFonts.inter(fontSize: 12, color: changeColor),
                  ),
                ],
              ),
          ],
        ],
      ),
    );
  }
}
