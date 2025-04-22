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
    final List<FlSpot> chartData = List.generate(
      widget.trend.length,
      (i) => FlSpot(i.toDouble(), widget.trend[i]),
    );

    final bool isProfit = widget.coin['change'] >= 0;
    final Color changeColor = isProfit ? Colors.green : Colors.red;
    final IconData changeIcon =
        isProfit ? Icons.arrow_drop_up : Icons.arrow_drop_down;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
        titleSpacing: 0, // 🟢 Pushes content to the left
        title: Row(
          children: [
            Image.asset(
              'assets/logo.png', // replace with actual coin icon path
              width: 20,
              height: 20,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 8),
            Text(
              "${widget.coin['name']} / ${widget.coin['symbol']}",
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ],
        ),
        actions: const [
          Icon(Icons.bookmark_border, color: Colors.black),
          SizedBox(width: 12),
        ],
      ),

      body: ListView(
        children: [
          const SizedBox(height: 16),

          // 💵 Price + Change
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Text(
                  widget.coin['amount'],
                  style: const TextStyle(
                    fontSize: 24,
                    color: Color(0xFF000000),
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

          // 📈 Chart
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
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            "\$${value.toStringAsFixed(0)}",
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                          );
                        },
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 24,
                        interval: 1,
                        getTitlesWidget: (value, meta) {
                          final labels = [
                            "03:05",
                            "09:35",
                            "12:05",
                            "13:55",
                            "16:15",
                            "20:30",
                            "23:00",
                          ];
                          int index = value.toInt();
                          return Text(
                            index < labels.length ? labels[index] : '',
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                          );
                        },
                      ),
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

          // 🕒 Filter Tabs
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF2F5),
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
                                isSelected ? Colors.white : Colors.transparent,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            label,
                            style: TextStyle(
                              fontSize: 12,
                              color:
                                  isSelected
                                      ? const Color(0xFF000000)
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

          // 🧾 Summary Cards
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Wrap(
                spacing: 14,
                runSpacing: 8,
                children: [
                  _buildSummaryCard("Total Spent", "\$1484.488"),
                  _buildSummaryCard("Avg Buy Price", "\$10.24"),
                  _buildSummaryCard(
                    "All-time P/L",
                    "\$758.12",
                    sub: "+5.23%",
                    subColor: Colors.green,
                  ),
                  _buildSummaryCard(
                    "Holdings",
                    "\$2242.60",
                    sub: "144.92 LINK",
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // 📜 Transactions Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Transactions",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF000000),
                  ),
                ),
                Text(
                  "+Add Transaction",
                  style: TextStyle(color: Color(0xFF348F6C), fontSize: 12),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // 📄 Transaction Cards
          ..._buildTransactionList([
            {
              "date": "April 15, 2025",
              "type": "Sell",
              "icon": Icons.link,
              "qty": "37.61 AVAX",
              "amount": "\$489.89",
              "isBuy": false,
            },
            {
              "date": "April 11, 2025",
              "type": "Buy",
              "icon": Icons.link,
              "qty": "42.11 AVAX",
              "amount": "\$547.44",
              "isBuy": true,
            },
            {
              "date": "April 11, 2025",
              "type": "Buy",
              "icon": Icons.link,
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
    String title,
    String value, {
    String? sub,
    Color? subColor,
  }) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF000000),
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

  List<Widget> _buildTransactionList(List<Map<String, dynamic>> transactions) {
    return List.generate(transactions.length, (index) {
      final tx = transactions[index];
      final bool isBuy = tx["isBuy"];
      final Color typeColor =
          isBuy ? const Color(0xFF348F6C) : const Color(0xFFFF3B30);
      final Color qtyColor =
          isBuy ? const Color(0xFF4CAF50) : const Color(0xFFFF3B30);

      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Main Row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Left: Icon + Type + Date
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                            const SizedBox(height: 2),
                            Text(
                              tx["date"],
                              style: const TextStyle(
                                fontSize: 10,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    // Right: Qty + Amount + Edit
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
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF000000),
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
              ],
            ),
          ),

          // ✅ Always show divider (including after the last item)
          const Divider(color: Color(0xFFDDDDDD), height: 1, thickness: 0.8),
        ],
      );
    });
  }
}
