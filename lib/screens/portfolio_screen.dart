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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

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
        "icon": Icons.ac_unit,
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
        "icon": Icons.flash_on,
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

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: theme.cardColor,
        elevation: 1,
        titleSpacing: coins.isNotEmpty ? 16 : 0,
        title: Text(
          coins.isNotEmpty ? "Hi, John Doe" : "Portfolio",
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: coins.isEmpty,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfileScreen(),
                    ),
                  ),
              child: SvgPicture.asset(
                'assets/profile_outline.svg',
                width: 30,
                height: 30,
                colorFilter: ColorFilter.mode(
                  theme.iconTheme.color!,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ],
      ),
      body:
          coins.isEmpty
              ? _buildEmptyState(theme)
              : _buildPortfolioContent(context, theme, coins, walletTrend),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF348F6C),
        shape: const CircleBorder(),
        onPressed:
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ChatScreen()),
            ),
        child: SvgPicture.asset(
          'assets/bot_light.svg',
          width: 40,
          height: 40,
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        ),
      ),
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/portfolio.png', height: 200),
          const SizedBox(height: 20),
          Text(
            "Almost there!\nJust few steps left",
            textAlign: TextAlign.center,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              "Add your first coin to begin tracking your assets.",
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.hintColor,
              ),
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF348F6C),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Text(
                "Add Coin",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPortfolioContent(
    BuildContext context,
    ThemeData theme,
    List<Map<String, dynamic>> coins,
    List<double> walletTrend,
  ) {
    final List<FlSpot> graphSpots = List.generate(
      walletTrend.length,
      (i) => FlSpot(i.toDouble(), walletTrend[i] / 1000),
    );

    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 12),
      children: [
        // Wallet Summary Card
        Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          height: 146,
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: theme.dividerColor.withOpacity(0.1),
              width: 0.2,
            ),
            boxShadow: [
              BoxShadow(
                color: theme.shadowColor.withOpacity(0.05),
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
                      children: [
                        Text(
                          "Total Wallet Balance",
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "\$23,245.87",
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w600,
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
                  color: theme.cardColor,

                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: theme.dividerColor.withOpacity(0.4),
                    width: 0.2,
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      "Total Profit/Loss",
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.hintColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: const [
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

        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "My Portfolio",
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              InkWell(
                onTap:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const AddCoinToPortfolioScreen(),
                      ),
                    ),
                child: const Text(
                  "+Add Coin",
                  style: TextStyle(color: Color(0xFF348F6C), fontSize: 12),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        ...coins.map((coin) => _buildCoinTile(context, theme, coin)).toList(),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildCoinTile(
    BuildContext context,
    ThemeData theme,
    Map<String, dynamic> coin,
  ) {
    final double change = coin['change'];
    final Color changeColor = change >= 0 ? Colors.green : Colors.red;
    final IconData changeIcon =
        change >= 0 ? Icons.arrow_drop_up : Icons.arrow_drop_down;

    return GestureDetector(
      onTap:
          () => Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (_) => ProfilioCoinDetailScreen(
                    coin: coin,
                    trend: [12.1, 12.3, 12.6, 12.5, 12.8, 13.2, 13.57],
                  ),
            ),
          ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.withOpacity(0.1)),
        ),
        child: Row(
          children: [
            Icon(coin['icon'], size: 36, color: theme.iconTheme.color),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    coin['name'],
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    coin['amount'],
                    style: theme.textTheme.bodySmall?.copyWith(
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
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.grey,
                  ),
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
