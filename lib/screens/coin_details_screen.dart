import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share_plus/share_plus.dart';

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
    _checkIfFavorite();
  }

  Future<void> _checkIfFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    final favList = prefs.getStringList('favorites') ?? [];
    setState(() {
      isFavorite = favList.contains(widget.coin);
    });
  }

  Future<void> _toggleFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    final favList = prefs.getStringList('favorites') ?? [];
    if (favList.contains(widget.coin)) {
      favList.remove(widget.coin);
    } else {
      favList.add(widget.coin);
    }
    await prefs.setStringList('favorites', favList);
    setState(() => isFavorite = !isFavorite);
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
        setState(() => isLoading = false);
      }
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  Future<void> _shareCoin() async {
    if (coin == null) return;
    final message =
        'Check out ${coin?['name']} (${coin?['symbol']?.toUpperCase()})!\nPrice: \$${coin?['market_data']['current_price']['usd']}';
    await Share.share(message);
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
          IconButton(
            icon: Icon(
              Icons.share,
              color: isDark ? Colors.white : Colors.black,
            ),
            onPressed: _shareCoin,
          ),
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color:
                  isFavorite
                      ? const Color(0xFF16C784)
                      : (isDark ? Colors.white : Colors.black),
            ),
            onPressed: _toggleFavorite,
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
    return SizedBox(
      height: 220,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: LineChart(
          LineChartData(
            gridData: FlGridData(show: false),
            borderData: FlBorderData(show: false),
            titlesData: FlTitlesData(show: false),
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
                belowBarData: BarAreaData(show: false),
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
      child: Column(
        children: [
          _buildOverviewRow(
            'Market Cap',
            '\$${coin?['market_data']['market_cap']['usd'] ?? '--'}',
          ),
          _buildOverviewRow(
            'Fully Diluted Value',
            '\$${_abbreviateNumber(coin?['market_data']['fully_diluted_valuation']['usd'])}',
          ),
          _buildOverviewRow(
            'Circulating Supply',
            _abbreviateNumber(coin?['market_data']['circulating_supply']),
          ),
          _buildOverviewRow(
            'Total Supply',
            _abbreviateNumber(coin?['market_data']['total_supply']),
          ),
          _buildOverviewRow(
            'ATH',
            '\$${coin?['market_data']['ath']['usd']?.toStringAsFixed(2) ?? '--'}',
          ),
          _buildOverviewRow(
            'ATL',
            '\$${coin?['market_data']['atl']['usd']?.toStringAsFixed(2) ?? '--'}',
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewRow(String title, String value) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: theme.textTheme.bodyMedium,
            ),
          ),
        ],
      ),
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
