import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CoinDetailScreen extends StatefulWidget {
  final String coin; // coin ID like 'chainlink'

  const CoinDetailScreen({super.key, required this.coin});

  @override
  State<CoinDetailScreen> createState() => _CoinDetailScreenState();
}

class _CoinDetailScreenState extends State<CoinDetailScreen> {
  int selectedIndex = 1;
  bool isFavorite = false;
  bool isLoading = true;
  Map<String, dynamic>? coin;
  List<double> trend = [];

  @override
  void initState() {
    super.initState();
    _fetchCoinDetails();
  }

  Future<void> _fetchCoinDetails() async {
    final detailUrl = Uri.parse(
      'https://rwa-f1623a22e3ed.herokuapp.com/api/currencies/rwa/coin/${widget.coin}',
    );
    final chartUrl = Uri.parse(
      'https://rwa-f1623a22e3ed.herokuapp.com/api/currencies/rwa/graph/coinOHLC/${widget.coin}',
    );

    try {
      final detailRes = await http.get(detailUrl);
      final chartRes = await http.get(chartUrl);

      debugPrint('🟢 Detail Response: ${detailRes.body}');
      debugPrint('🟢 Chart Response: ${chartRes.body}');

      if (detailRes.statusCode == 200 && chartRes.statusCode == 200) {
        final coinData = json.decode(detailRes.body)['detail'];
        final List<dynamic> chartRaw = json.decode(chartRes.body)['graphData'];
        final List<double> closePrices =
            chartRaw.map((e) => (e[4] as num).toDouble()).toList();

        setState(() {
          coin = coinData;
          trend = closePrices;
          isLoading = false;
        });
      } else {
        debugPrint(
          '❌ API failed with status: ${detailRes.statusCode}, ${chartRes.statusCode}',
        );
        setState(() => isLoading = false);
      }
    } catch (e) {
      debugPrint('❌ Exception while fetching data: $e');
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        titleSpacing: 0,
        iconTheme: theme.iconTheme,
        title: Row(
          children: [
            if (coin != null && coin?['image']?['small'] != null)
              Image.network(
                coin?['image']['small'],
                width: 24,
                height: 24,
                errorBuilder: (_, __, ___) => const Icon(Icons.error, size: 18),
              ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  coin?['symbol']?.toUpperCase() ?? '',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(coin?['name'] ?? '', style: theme.textTheme.bodySmall),
              ],
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 4),
            child: Image.asset(
              'assets/share.png',
              width: 36,
              height: 36,
              color: isDark ? Colors.white : null,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () => setState(() => isFavorite = !isFavorite),
              child: Image.asset(
                'assets/like.png',
                width: 36,
                height: 36,
                color:
                    isFavorite
                        ? const Color(0xFF16C784)
                        : (isDark ? Colors.white : null),
              ),
            ),
          ),
        ],
      ),
      body:
          isLoading
              ? const Center(
                child: CircularProgressIndicator(color: Colors.green),
              )
              : _buildBody(theme),
    );
  }

  Widget _buildBody(ThemeData theme) {
    final chartData = List.generate(
      trend.length,
      (i) => FlSpot(i.toDouble(), trend[i]),
    );

    return ListView(
      padding: const EdgeInsets.only(top: 16),
      children: [
        _buildPriceSection(theme),
        const SizedBox(height: 12),
        _buildChartSection(theme, chartData),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 16, bottom: 12),
          child: Text(
            'Overview',
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: theme.textTheme.bodyLarge?.color,
              fontSize: 14,
            ),
          ),
        ),
        _buildOverviewSection(theme),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildPriceSection(ThemeData theme) {
    final price = coin?['market_data']['current_price']['usd'] ?? 0;
    final change = coin?['market_data']['price_change_percentage_24h'] ?? 0;
    final isUp = change >= 0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '\$${price.toStringAsFixed(2)}',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 6),
          Row(
            children: [
              Icon(
                isUp ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                color: isUp ? Colors.green : Colors.red,
                size: 20,
              ),
              Text(
                '${change.toStringAsFixed(2)}%',
                style: TextStyle(
                  fontSize: 14,
                  color: isUp ? Colors.green : Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChartSection(ThemeData theme, List<FlSpot> chartData) {
    final minPrice = trend.isEmpty ? 0 : trend.reduce((a, b) => a < b ? a : b);
    final maxPrice = trend.isEmpty ? 0 : trend.reduce((a, b) => a > b ? a : b);

    return SizedBox(
      height: 220,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: LineChart(
          LineChartData(
            backgroundColor: Colors.transparent,
            gridData: FlGridData(
              show: true,
              drawVerticalLine: false,
              getDrawingHorizontalLine:
                  (_) => FlLine(
                    color: Colors.grey.withOpacity(0.2),
                    strokeWidth: 1,
                  ),
            ),
            borderData: FlBorderData(show: false),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: (maxPrice - minPrice) / 3,
                  reservedSize: 60,
                  getTitlesWidget:
                      (value, _) => Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: Text(
                          "\$${value.toStringAsFixed(2)}",
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
            ),
            minY: minPrice * 0.98,
            maxY: maxPrice * 1.02,
            lineBarsData: [
              LineChartBarData(
                spots: chartData,
                isCurved: true,
                gradient: const LinearGradient(
                  colors: [Color(0xFF16C784), Color(0xFF30D987)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                barWidth: 2,
                dotData: FlDotData(show: false),
                belowBarData: BarAreaData(
                  show: true,
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF16C784).withOpacity(0.25),
                      Colors.transparent,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOverviewSection(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.withOpacity(0.2), width: 0.5),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildOverviewRow(
              "Market Cap",
              "\$${coin?['market_data']['market_cap']['usd'] ?? '--'}",
              "Fully Diluted Value",
              "\$${_abbreviateNumber(coin?['market_data']['fully_diluted_valuation']['usd'])}",
            ),
            _buildOverviewRow(
              "Circulating Supply",
              _abbreviateNumber(coin?['market_data']['circulating_supply']),
              "Total Supply",
              _abbreviateNumber(coin?['market_data']['total_supply']),
            ),
            _buildOverviewRow(
              "ATH",
              "\$${coin?['market_data']['ath']['usd']?.toStringAsFixed(2) ?? '--'}",
              "ATL",
              "\$${coin?['market_data']['atl']['usd']?.toStringAsFixed(2) ?? '--'}",
            ),
          ],
        ),
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
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.bodySmall?.copyWith(
            color: Colors.grey,
            fontWeight: FontWeight.w400,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.textTheme.bodyLarge?.color,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  String _abbreviateNumber(dynamic numVal) {
    if (numVal == null) return "--";
    final num number =
        (numVal is int || numVal is double)
            ? numVal
            : double.tryParse(numVal.toString()) ?? 0;
    if (number >= 1e12) return '${(number / 1e12).toStringAsFixed(2)}T';
    if (number >= 1e9) return '${(number / 1e9).toStringAsFixed(2)}B';
    if (number >= 1e6) return '${(number / 1e6).toStringAsFixed(2)}M';
    if (number >= 1e3) return '${(number / 1e3).toStringAsFixed(2)}K';
    return number.toStringAsFixed(2);
  }
}
