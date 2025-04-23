import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rwa_app/screens/add_coin_to_portfolio.dart';
import 'package:rwa_app/screens/chat_screen.dart';
import 'package:rwa_app/screens/profile_screen.dart';
import 'package:rwa_app/screens/protfilio_coin_detail_screen.dart';

class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> coins = [
      {
        "name": "Chainlink",
        "symbol": "LINK",
        "amount": "\$1,484.49",
        "change": 5.23,
        "icon": Icons.link,
      },
      {
        "name": "Maple Finance",
        "symbol": "MPL",
        "amount": "\$2,784.40",
        "change": -0.78,
        "icon": Icons.local_fire_department,
      },
      {
        "name": "Avalanche",
        "symbol": "AVAX",
        "amount": "\$1,064.36",
        "change": -1.59,
        "icon": Icons.ac_unit, // snowflake-style icon
      },
      {
        "name": "Bitcoin",
        "symbol": "BTC",
        "amount": "\$42,758.00",
        "change": 3.87,
        "icon": Icons.currency_bitcoin,
      },
      {
        "name": "Ethereum",
        "symbol": "ETH",
        "amount": "\$2,320.91",
        "change": 1.34,
        "icon": Icons.auto_graph,
      },
      {
        "name": "Solana",
        "symbol": "SOL",
        "amount": "\$165.48",
        "change": -0.42,
        "icon": Icons.flash_on, // bolt style
      },
    ];

    final List<double> walletTrend = [
      23000,
      23400,
      23100,
      23600,
      23850,
      23990,
      23245,
    ];

    final bool hasCoins = coins.isNotEmpty;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(247, 247, 247, 1),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 1,
        titleSpacing: hasCoins ? 16 : 0,
        title: Text(
          hasCoins ? "Hi, John Doe" : "Portfolio",
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: !hasCoins,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreen(),
                  ),
                );
              },
              child: SvgPicture.asset(
                'assets/profile_outline.svg',
                width: 30,
                height: 30,
              ),
            ),
          ),
        ],
      ),
      body:
          hasCoins
              ? _buildPortfolioContent(context, coins, walletTrend)
              : _buildEmptyState(),
      floatingActionButton: SizedBox(
        width: 56, // Size of the button
        height: 56,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ChatScreen()),
            );
          },
          backgroundColor: const Color(0xFF348F6C),
          shape: const CircleBorder(),
          child: SvgPicture.asset(
            'assets/bot_light.svg',
            width: 40,
            height: 40,
            fit: BoxFit.contain,
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/portfolio.png', height: 240),
        const SizedBox(height: 16),
        const Text(
          "Almost there!\nJust few steps left",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            color: Color(0xFF000000),
            fontWeight: FontWeight.bold,
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 8),
          child: Text(
            "Add your first coin to begin tracking your assets.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: Color.fromARGB(147, 123, 123, 123),
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        const SizedBox(height: 60),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: SizedBox(
            height: 48,
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF348F6C),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onPressed: () {},
              child: const Text(
                'Add Coin',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPortfolioContent(
    BuildContext context,
    List<Map<String, dynamic>> coins,
    List<double> walletTrend,
  ) {
    final List<FlSpot> graphSpots = List.generate(
      walletTrend.length,
      (i) => FlSpot(i.toDouble(), walletTrend[i] / 1000), // Simplify values
    );

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Wallet Summary Card
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            height: 146,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: Colors.black.withOpacity(0.1),
                width: 0.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  offset: const Offset(0, 1),
                  blurRadius: 2,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Balance & Graph
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Total Wallet Balance",
                            style: TextStyle(
                              color: Color(0xFF000000),
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            "\$23,245.87",
                            style: TextStyle(
                              color: Color(0xFF000000),
                              fontWeight: FontWeight.w600,
                              fontSize: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 3,
                      child: SizedBox(
                        height: 60,
                        child: LineChart(
                          LineChartData(
                            borderData: FlBorderData(show: false),
                            gridData: FlGridData(show: false),
                            titlesData: FlTitlesData(show: false),
                            lineBarsData: [
                              LineChartBarData(
                                spots: graphSpots,
                                isCurved: true,
                                color: Colors.green,
                                barWidth: 2,
                                dotData: FlDotData(show: false),
                              ),
                            ],
                            minY:
                                walletTrend.reduce((a, b) => a < b ? a : b) /
                                    1000 -
                                1,
                            maxY:
                                walletTrend.reduce((a, b) => a > b ? a : b) /
                                    1000 +
                                1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Profit Box
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7F7F7),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: Colors.black.withOpacity(0.1),
                      width: 0.2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        offset: const Offset(0, 1),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                  child: Row(
                    children: const [
                      Text(
                        "Total Profit/Loss",
                        style: TextStyle(
                          color: Color(0xFF7B7B7B),
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                      ),
                      Spacer(),
                      Row(
                        children: [
                          Text(
                            "\$12,958.25",
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(width: 6),
                          Icon(
                            Icons.arrow_drop_up,
                            color: Colors.green,
                            size: 18,
                          ),
                          Text(
                            "13.46%",
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Portfolio Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "My Portfolio",
                  style: TextStyle(
                    color: Color(0xFF000000),
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) =>
                                const AddCoinToPortfolioScreen(), // ✅ correct usage
                      ),
                    );
                  },
                  child: const Text(
                    "+Add Coin",
                    style: TextStyle(color: Color(0xFF348F6C), fontSize: 12),
                  ),
                ),
              ],
            ),
          ),

          // Coin Tiles
          ...coins.map((coin) => _buildCoinTile(context, coin)),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildCoinTile(BuildContext context, Map<String, dynamic> coin) {
    final double change = coin['change'] as double;
    final Color changeColor = change >= 0 ? Colors.green : Colors.red;
    final IconData changeIcon =
        change >= 0 ? Icons.arrow_drop_up : Icons.arrow_drop_down;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (_) => ProfilioCoinDetailScreen(
                  coin: coin,
                  trend: [12.1, 12.3, 12.6, 12.5, 12.8, 13.2, 13.57],
                ),
          ),
        );
      },
      child: Stack(
        children: [
          // 🔲 Main Card
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.black.withOpacity(0.1),
                width: 0.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  offset: const Offset(0, 1),
                  blurRadius: 2,
                ),
              ],
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Image.asset('assets/logo.png', width: 40, height: 40),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        coin['name'],
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        coin['amount'],
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      coin['symbol'],
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    Row(
                      children: [
                        Icon(changeIcon, color: changeColor, size: 18),
                        const SizedBox(width: 2),
                        Text(
                          "${change.abs().toStringAsFixed(2)}%",
                          style: TextStyle(
                            color: changeColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          // ➕ Floating + Icon (top-left)
          // Positioned(
          //   top: 6,
          //   left: 16,
          //   child: Container(
          //     width: 20,
          //     height: 20,
          //     decoration: BoxDecoration(
          //       color: const Color(0xFF348F6C),
          //       shape: BoxShape.circle,
          //       boxShadow: [
          //         BoxShadow(
          //           color: Colors.black.withOpacity(0.1),
          //           blurRadius: 2,
          //           offset: const Offset(0, 1),
          //         ),
          //       ],
          //     ),
          //     child: const Icon(Icons.add, size: 14, color: Colors.white),
          //   ),
          // ),
        ],
      ),
    );
  }
}
