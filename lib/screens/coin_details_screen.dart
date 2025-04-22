import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CoinDetailScreen extends StatefulWidget {
  final Map<String, dynamic> coin;
  final List<double> trend;

  const CoinDetailScreen({super.key, required this.coin, required this.trend});

  @override
  State<CoinDetailScreen> createState() => _CoinDetailScreenState();
}

class _CoinDetailScreenState extends State<CoinDetailScreen> {
  int selectedIndex = 1;
  final List<String> filters = ["1H", "24H", "7D", "1M", "1Y", "All"];
  final List<String> trendLabels = ["24H", "7D", "14D", "30D", "60D", "1Y"];
  final List<double> trendValues = [1.0, 7.3, 2.1, 3.9, -11.6, 30.0];

  @override
  Widget build(BuildContext context) {
    final chartData = List.generate(
      widget.trend.length,
      (i) => FlSpot(i.toDouble(), widget.trend[i]),
    );

    final isProfit = widget.coin['change'] >= 0;
    final Color changeColor =
        isProfit ? const Color(0xFF16C784) : const Color(0xFFFF3B30);
    final IconData changeIcon =
        isProfit ? Icons.arrow_drop_up : Icons.arrow_drop_down;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F7F7),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        titleSpacing: 0,
        title: Row(
          children: [
            Image.asset(widget.coin['logo'], width: 24, height: 24),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.coin['symbol'],
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF111111),
                  ),
                ),
                Text(
                  widget.coin['name'],
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF666666),
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 0),
            child: Image.asset('assets/share.png', width: 40, height: 40),
          ),
          Padding(
            padding: EdgeInsets.only(right: 0),
            child: Image.asset('assets/like.png', width: 40, height: 40),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 16),
        children: [
          // Price
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  widget.coin['amount'] ?? "\$0.00",
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF111111),
                  ),
                ),
                const SizedBox(width: 6),
                Row(
                  children: [
                    Icon(changeIcon, color: changeColor, size: 20),
                    Text(
                      "${widget.coin['change'].abs().toStringAsFixed(2)}%",
                      style: TextStyle(
                        fontSize: 14,
                        color: changeColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Chart
          SizedBox(
            height: 200,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  minY: widget.trend.reduce((a, b) => a < b ? a : b) - 1,
                  maxY: widget.trend.reduce((a, b) => a > b ? a : b) + 1,
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 36,
                        getTitlesWidget:
                            (value, _) => Text(
                              "\$${value.toStringAsFixed(0)}",
                              style: const TextStyle(
                                fontSize: 10,
                                color: Color(0xFF8C8C8C),
                              ),
                            ),
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 28,
                        getTitlesWidget:
                            (_, __) =>
                                const Text("", style: TextStyle(fontSize: 10)),
                      ),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: chartData,
                      isCurved: true,
                      color: changeColor,
                      barWidth: 2,
                      dotData: FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        color: changeColor.withOpacity(0.1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Time Filters
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: const Color(0xFFEFF2F5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:
                    filters.asMap().entries.map((entry) {
                      final idx = entry.key;
                      final label = entry.value;
                      final selected = idx == selectedIndex;
                      return GestureDetector(
                        onTap: () => setState(() => selectedIndex = idx),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: selected ? Colors.white : Colors.transparent,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            label,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color:
                                  selected
                                      ? const Color(0xFF111111)
                                      : Colors.grey,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Trend Stats
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFE0E0E0), width: 0.4),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(trendLabels.length, (index) {
                  final label = trendLabels[index];
                  final value = trendValues[index];
                  final isUp = value >= 0;
                  return Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          label,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF111111),
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: double.infinity,
                          height: 0.5,
                          color: const Color(0xFFE0E0E0),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "${isUp ? '+' : ''}${value.toStringAsFixed(1)}%",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color:
                                isUp
                                    ? const Color(0xFF16C784)
                                    : const Color(0xFFFF3B30),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Overview
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const Text(
              "Overview",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF111111),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFE0E0E0), width: 0.5),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildOverviewRow(
                    "Market Cap",
                    "\$8.22B",
                    "Fully Diluted Market Cap",
                    "\$12.52B",
                  ),
                  _buildOverviewRow(
                    "Volume 24H",
                    "\$285.47M",
                    "Circulating Supply",
                    "657.09M LINK",
                  ),
                  _buildOverviewRow(
                    "Max Supply",
                    "--",
                    "Total Supply",
                    "1B LINK",
                  ),
                  _buildOverviewRow(
                    "All Time High",
                    "\$52.88",
                    "All Time Low",
                    "\$0.1263",
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildOverviewRow(
    String title1,
    String value1,
    String title2,
    String value2,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _buildOverviewItem(title1, value1)),
          const SizedBox(width: 16),
          Expanded(child: _buildOverviewItem(title2, value2)),
        ],
      ),
    );
  }

  Widget _buildOverviewItem(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                title,
                softWrap: false,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF888888),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(width: 4),
            GestureDetector(
              onTap: () {
                // ✅ Use ScaffoldMessenger correctly
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Color(0xFFF7F7F7),
                    content: Text(
                      "Info about $title",
                      style: TextStyle(fontSize: 12, color: Color(0xFF000000)),
                    ),
                    duration: const Duration(seconds: 2),
                    behavior: SnackBarBehavior.floating,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                  ),
                );
              },
              child: const Icon(
                Icons.info_outline,
                size: 12,
                color: Color(0xFFBBBBBB),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF111111),
          ),
        ),
      ],
    );
  }
}
