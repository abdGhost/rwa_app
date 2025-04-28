import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class CoinDetailScreen extends StatefulWidget {
  final String coin;

  const CoinDetailScreen({super.key, required this.coin});

  @override
  State<CoinDetailScreen> createState() => _CoinDetailScreenState();
}

class _CoinDetailScreenState extends State<CoinDetailScreen> {
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
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: _buildAppBar(theme),
      body:
          isLoading
              ? const Center(
                child: CircularProgressIndicator(color: Colors.green),
              )
              : _buildBody(theme),
    );
  }

  PreferredSizeWidget _buildAppBar(ThemeData theme) {
    return AppBar(
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
          Expanded(
            // 🔥 Added Expanded here to prevent overflow
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize:
                  MainAxisSize.min, // important for tight vertical space
              children: [
                Text(
                  coin?['symbol']?.toUpperCase() ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis, // ✨ show "..." if too long
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  coin?['name'] ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis, // ✨ show "..." if too long
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.share, color: Colors.grey),
          onPressed: _shareCoin,
        ),
        IconButton(
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: isFavorite ? Colors.green : Colors.grey,
          ),
          onPressed: _toggleFavorite,
        ),
      ],
    );
  }

  Widget _buildBody(ThemeData theme) {
    final chartData = List.generate(
      trend.length,
      (i) => FlSpot(i.toDouble(), trend[i]),
    );
    final double minPrice =
        trend.isEmpty ? 0 : trend.reduce((a, b) => a < b ? a : b).toDouble();
    final double maxPrice =
        trend.isEmpty ? 0 : trend.reduce((a, b) => a > b ? a : b).toDouble();

    return ListView(
      padding: const EdgeInsets.only(top: 16),
      children: [
        _buildPriceSection(theme),
        const SizedBox(height: 12),
        _buildChartSection(theme, chartData, minPrice, maxPrice),
        const SizedBox(height: 24),
        _buildOverviewSection(theme),
        const SizedBox(height: 24),
        _buildAboutSection(theme),
        const SizedBox(height: 24),
        _buildLinksSection(theme),
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

  String _formatYAxisValue(double value) {
    if (value >= 1e12) return '${(value / 1e12).toStringAsFixed(2)}T';
    if (value >= 1e9) return '${(value / 1e9).toStringAsFixed(2)}B';
    if (value >= 1e6) return '${(value / 1e6).toStringAsFixed(2)}M';
    if (value >= 1e3) return '${(value / 1e3).toStringAsFixed(2)}K';
    return value.toStringAsFixed(2);
  }

  Widget _buildChartSection(
    ThemeData theme,
    List<FlSpot> chartData,
    double minPrice,
    double maxPrice,
  ) {
    return SizedBox(
      height: 250,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: LineChart(
          LineChartData(
            gridData: FlGridData(show: true, drawVerticalLine: true),
            borderData: FlBorderData(
              show: true,
              border: Border.all(color: Colors.grey.withOpacity(0.3)),
            ),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 40,
                  getTitlesWidget: (value, meta) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Text(
                        _formatYAxisValue(value),
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontSize: 10,
                          color: Colors.grey,
                        ),
                      ),
                    );
                  },
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 30,
                  interval: 8,
                  getTitlesWidget: (value, meta) {
                    if (value < 0 || value.toInt() >= trend.length)
                      return const SizedBox.shrink();
                    DateTime time = DateTime.now().subtract(
                      Duration(minutes: (trend.length - value.toInt()) * 30),
                    );
                    return Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text(
                        '${time.hour}:${time.minute.toString().padLeft(2, '0')}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontSize: 10,
                          color: Colors.grey,
                        ),
                      ),
                    );
                  },
                ),
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
                      Color(0xFF16C784).withOpacity(0.2),
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
          border: Border.all(color: Colors.grey.withOpacity(0.2)),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildOverviewRow(
              'Market Cap',
              '\$${_formatValue(coin?['market_data']['market_cap']['usd'])}',
              'Fully Diluted Value',
              '\$${_formatValue(coin?['market_data']['fully_diluted_valuation']['usd'])}',
            ),
            const SizedBox(height: 12),
            _buildOverviewRow(
              'Circulating Supply',
              _formatValue(coin?['market_data']['circulating_supply']),
              'Total Supply',
              _formatValue(coin?['market_data']['total_supply']),
            ),
            const SizedBox(height: 12),
            _buildOverviewRow(
              'ATH',
              '\$${coin?['market_data']['ath']['usd']?.toStringAsFixed(2) ?? '--'}',
              'ATL',
              '\$${coin?['market_data']['atl']['usd']?.toStringAsFixed(2) ?? '--'}',
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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title1,
                style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
              ),
              const SizedBox(height: 4),
              Text(
                value1,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title2,
                style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
              ),
              const SizedBox(height: 4),
              Text(
                value2,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAboutSection(ThemeData theme) {
    final about = coin?['description']?['en'] ?? '';
    if (about.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            about,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontSize: 12,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLinksSection(ThemeData theme) {
    final homepage = _safeFirst(coin?['links']?['homepage']);
    final whitepaper = coin?['links']?['whitepaper'] ?? '';
    final twitter = coin?['links']?['twitter_screen_name'] ?? '';

    if (homepage.isEmpty && whitepaper.isEmpty && twitter.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Important Links',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (homepage.isNotEmpty) _buildLinkItem('Website', homepage),
              if (whitepaper.isNotEmpty)
                _buildLinkItem(
                  'Docs',
                  whitepaper,
                ), // 📄 Docs icon for whitepaper
              if (twitter.isNotEmpty)
                _buildLinkItem('Twitter', 'https://twitter.com/$twitter'),
            ],
          ),
        ],
      ),
    );
  }

  String _safeFirst(dynamic listData) {
    if (listData is List && listData.isNotEmpty) {
      return listData.first ?? '';
    }
    return '';
  }

  Widget _buildLinkItem(String label, String url) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    Widget icon;

    switch (label.toLowerCase()) {
      case 'website':
        icon = Image.asset(
          'assets/web.png',
          width: 26,
          height: 26,
          color: isDark ? Colors.white : null,
          colorBlendMode: BlendMode.srcIn,
        );
        break;
      case 'docs':
        icon = Image.asset(
          'assets/google-docs.png',
          width: 26,
          height: 26,
          color: isDark ? Colors.white : null,
          colorBlendMode: BlendMode.srcIn,
        );
        break;
      case 'twitter':
        icon = Image.asset(
          'assets/twitter.png',
          width: 26,
          height: 26,
          color: isDark ? Colors.white : null,
          colorBlendMode: BlendMode.srcIn,
        );
        break;
      default:
        icon = Icon(Icons.link, size: 26, color: Colors.green);
    }

    return GestureDetector(
      onTap: () async {
        try {
          Uri uri = Uri.parse(url);
          if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
            await launchUrl(uri, mode: LaunchMode.inAppWebView);
          }
        } catch (e) {
          debugPrint('❌ Launch Error: $e');
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Could not open $label link')),
            );
          }
        }
      },
      child: Padding(padding: const EdgeInsets.only(right: 16), child: icon),
    );
  }
}

String _formatValue(dynamic numVal) {
  if (numVal == null) return "--";
  final num number =
      (numVal is num) ? numVal : double.tryParse(numVal.toString()) ?? 0;
  if (number >= 1e12) return '${(number / 1e12).toStringAsFixed(2)}T';
  if (number >= 1e9) return '${(number / 1e9).toStringAsFixed(2)}B';
  if (number >= 1e6) return '${(number / 1e6).toStringAsFixed(2)}M';
  if (number >= 1e3) return '${(number / 1e3).toStringAsFixed(2)}K';
  return number.toStringAsFixed(2);
}
