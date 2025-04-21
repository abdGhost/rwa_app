import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:rwa_app/screens/protfilio_coin_detail_screen.dart';

class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> coins = [
      {
        "name": "Chainlink",
        "symbol": "LINK",
        "amount": "\$1484.488",
        "change": 5.23,
        "icon": Icons.link,
      },
      {
        "name": "Maple Finance",
        "symbol": "MPL",
        "amount": "\$2784.4",
        "change": -0.78,
        "icon": Icons.local_fire_department,
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
          IconButton(
            icon: const Icon(Icons.person, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body:
          hasCoins
              ? _buildPortfolioContent(context, coins, walletTrend)
              : _buildEmptyState(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.green[700],
        child: const Icon(Icons.chat),
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
            height: 184,
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
                        height: 80,
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
                const SizedBox(height: 16),

                // Profit Box
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
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
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "My Portfolio",
                  style: TextStyle(
                    color: Color(0xFF000000),
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                Text(
                  "+Add Coin",
                  style: TextStyle(color: Color(0xFF348F6C), fontSize: 12),
                ),
              ],
            ),
          ),

          // Coin Tiles
          ...coins.map((coin) => _buildCoinTile(context, coin)),

          const SizedBox(height: 80),
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
                  trend: [
                    12.1,
                    12.3,
                    12.6,
                    12.5,
                    12.8,
                    13.2,
                    13.57,
                  ], // sample trend data
                ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black.withOpacity(0.1), width: 0.2),
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
            CircleAvatar(
              backgroundColor: Colors.grey.shade100,
              child: Icon(coin['icon'], color: Colors.black),
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
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
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
    );
  }
}
