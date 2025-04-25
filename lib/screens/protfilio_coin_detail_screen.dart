// updated_profilio_coin_detail_screen.dart
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ProfilioCoinDetailScreen extends StatefulWidget {
  final Map<String, dynamic> coin;
  final List<double> trend;

  const ProfilioCoinDetailScreen({
    super.key,
    required this.coin,
    required this.trend,
  });

  @override
  State<ProfilioCoinDetailScreen> createState() =>
      _ProfilioCoinDetailScreenState();
}

class _ProfilioCoinDetailScreenState extends State<ProfilioCoinDetailScreen> {
  int selectedIndex = 1;
  final List<String> filters = ["1H", "24H", "7D", "1M", "1Y", "All"];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final List<FlSpot> chartData = List.generate(
      widget.trend.length,
      (i) => FlSpot(i.toDouble(), widget.trend[i]),
    );

    final bool isProfit = widget.coin['change'] >= 0;
    final Color changeColor =
        isProfit ? const Color(0xFF16C784) : const Color(0xFFFF3B30);
    final IconData changeIcon =
        isProfit ? Icons.arrow_drop_up : Icons.arrow_drop_down;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.cardColor,
        elevation: 1,
        iconTheme: theme.iconTheme,
        titleSpacing: 0,
        title: Row(
          children: [
            Image.asset('assets/logo.png', width: 20, height: 20),
            const SizedBox(width: 8),
            Text(
              "${widget.coin['name']} / ${widget.coin['symbol']}",
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        actions: const [Icon(Icons.bookmark_border), SizedBox(width: 12)],
      ),
      body: ListView(
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Text(
                  widget.coin['amount'],
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(changeIcon, color: changeColor, size: 18),
                Text(
                  "${widget.coin['change'].abs().toStringAsFixed(2)}%",
                  style: TextStyle(
                    color: changeColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: 180,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: LineChart(
                LineChartData(
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
                              style: theme.textTheme.bodySmall,
                            ),
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  gridData: FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: chartData,
                      isCurved: true,
                      barWidth: 2,
                      color: changeColor,
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
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                color: isDark ? Colors.grey.shade900 : const Color(0xFFEFF2F5),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:
                    filters.asMap().entries.map((entry) {
                      int idx = entry.key;
                      String label = entry.value;
                      bool isSelected = idx == selectedIndex;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = idx;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color:
                                isSelected
                                    ? theme.scaffoldBackgroundColor
                                    : Colors.transparent,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            label,
                            style: TextStyle(
                              fontSize: 12,
                              color:
                                  isSelected
                                      ? theme.textTheme.bodyLarge?.color
                                      : Colors.grey,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Wrap(
                spacing: 14,
                runSpacing: 8,
                children: [
                  _buildSummaryCard(context, "Total Spent", "\$1484.488"),
                  _buildSummaryCard(context, "Avg Buy Price", "\$10.24"),
                  _buildSummaryCard(
                    context,
                    "All-time P/L",
                    "\$758.12",
                    sub: "+5.23%",
                    subColor: Colors.green,
                  ),
                  _buildSummaryCard(
                    context,
                    "Holdings",
                    "\$2242.60",
                    sub: "144.92 LINK",
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Transactions",
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Text(
                  "+Add Transaction",
                  style: TextStyle(color: Color(0xFF348F6C), fontSize: 12),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          ..._buildTransactionList(context, [
            {
              "date": "April 15, 2025",
              "type": "Sell",
              "qty": "37.61 AVAX",
              "amount": "\$489.89",
              "isBuy": false,
            },
            {
              "date": "April 11, 2025",
              "type": "Buy",
              "qty": "42.11 AVAX",
              "amount": "\$547.44",
              "isBuy": true,
            },
            {
              "date": "April 11, 2025",
              "type": "Buy",
              "qty": "8.61 AVAX",
              "amount": "\$122.50",
              "isBuy": true,
            },
          ]),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(
    BuildContext context,
    String title,
    String value, {
    String? sub,
    Color? subColor,
  }) {
    final theme = Theme.of(context);
    return Container(
      width: 140,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          if (sub != null)
            Text(
              sub,
              style: TextStyle(
                fontSize: 10,
                color: subColor ?? Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
        ],
      ),
    );
  }

  List<Widget> _buildTransactionList(
    BuildContext context,
    List<Map<String, dynamic>> transactions,
  ) {
    final theme = Theme.of(context);

    return List.generate(transactions.length, (index) {
      final tx = transactions[index];
      final bool isBuy = tx["isBuy"];
      final Color typeColor =
          isBuy ? const Color(0xFF348F6C) : const Color(0xFFFF3B30);
      final Color qtyColor =
          isBuy ? const Color(0xFF4CAF50) : const Color(0xFFFF3B30);

      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset('assets/logo.png', width: 24, height: 24),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tx["type"],
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: typeColor,
                          ),
                        ),
                        Text(
                          tx["date"],
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          tx["qty"],
                          style: TextStyle(
                            fontSize: 10,
                            color: qtyColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          tx["amount"],
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 10),
                    Image.asset('assets/edit.png', width: 24, height: 24),
                  ],
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.grey.withOpacity(0.3),
            height: 1,
            thickness: 0.8,
          ),
        ],
      );
    });
  }
}
