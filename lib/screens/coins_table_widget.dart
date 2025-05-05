import 'package:flutter/material.dart';
import 'package:rwa_app/models/coin_model.dart';
import 'package:rwa_app/screens/coin_details_screen.dart';

class CoinsTable extends StatefulWidget {
  final List<Coin> coins;
  final ScrollController? scrollController;

  const CoinsTable({super.key, required this.coins, this.scrollController});

  @override
  State<CoinsTable> createState() => _CoinsTableState();
}

class _CoinsTableState extends State<CoinsTable> {
  late List<Coin> _sortedCoins;
  String _sortBy = 'rank';
  bool _isAscending = true;

  @override
  void initState() {
    super.initState();
    _sortedCoins = List.from(widget.coins);
  }

  @override
  void didUpdateWidget(covariant CoinsTable oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.coins != widget.coins) {
      _sortedCoins = List.from(widget.coins);
      _sortCoins();
    }
  }

  void _onSort(String column) {
    setState(() {
      if (_sortBy == column) {
        _isAscending = !_isAscending;
      } else {
        _sortBy = column;
        _isAscending = true;
      }
      _sortCoins();
    });
  }

  void _sortCoins() {
    _sortedCoins.sort((a, b) {
      int compare;
      switch (_sortBy) {
        case 'price':
          compare = a.currentPrice.compareTo(b.currentPrice);
          break;
        case 'marketCap':
          compare = a.marketCap.compareTo(b.marketCap);
          break;
        case 'name':
          compare = a.name.toLowerCase().compareTo(b.name.toLowerCase());
          break;
        default:
          compare = a.marketCapRank.compareTo(b.marketCapRank);
      }
      return _isAscending ? compare : -compare;
    });
  }

  String formatNumber(num? value) {
    if (value == null) return '...';
    if (value >= 1e12) return '\$${(value / 1e12).toStringAsFixed(2)}T';
    if (value >= 1e9) return '\$${(value / 1e9).toStringAsFixed(2)}B';
    if (value >= 1e6) return '\$${(value / 1e6).toStringAsFixed(2)}M';
    if (value >= 1e3) return '\$${(value / 1e3).toStringAsFixed(2)}K';
    return '\$${value.toStringAsFixed(2)}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final headerStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 12,
      color: theme.textTheme.bodySmall?.color ?? Colors.grey,
    );
    final rowStyle = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 12,
      color: theme.textTheme.bodyLarge?.color ?? Colors.black,
    );

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: _buildHeaderRow(headerStyle),
        ),
        Divider(
          height: 1,
          thickness: 0.6,
          color: theme.dividerColor.withOpacity(0.4),
        ),
        Expanded(
          child: ListView.builder(
            controller: widget.scrollController,
            itemCount: _sortedCoins.length,
            itemBuilder: (context, index) {
              final coin = _sortedCoins[index];
              final isNegative = coin.priceChange24h < 0;
              final isPositive = coin.priceChange24h > 0;

              return InkWell(
                onTap:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CoinDetailScreen(coin: coin.id),
                      ),
                    ),
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
                            width: 24,
                            child: Center(
                              child: Text('${index + 1}', style: rowStyle),
                            ),
                          ),
                          const SizedBox(width: 14),
                          _buildCoinIcon(coin.image),
                          SizedBox(
                            width: 40,
                            child: Center(
                              child: Text(
                                coin.symbol.toUpperCase(),
                                style: rowStyle,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: 60,
                            child: Center(
                              child: Text(
                                '\$${coin.currentPrice.toStringAsFixed(2)}',
                                style: rowStyle,
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          SizedBox(
                            width: 48,
                            child: Center(
                              child: Text(
                                '${isNegative
                                    ? '-'
                                    : isPositive
                                    ? '+'
                                    : ''}${coin.priceChange24h.abs().toStringAsFixed(2)}%',
                                style: rowStyle.copyWith(
                                  color:
                                      isNegative
                                          ? Colors.red
                                          : isPositive
                                          ? Colors.green
                                          : theme.textTheme.bodyLarge?.color,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          SizedBox(
                            width: 110,
                            child: Text(
                              formatNumber(coin.marketCap),
                              textAlign: TextAlign.center,
                              style: rowStyle,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 1,
                      thickness: 0.6,
                      color: theme.dividerColor.withOpacity(0.3),
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

  Widget _buildHeaderRow(TextStyle style) {
    return SizedBox(
      height: 40,
      child: Row(
        children: [
          SizedBox(width: 24, child: Center(child: Text('#', style: style))),
          const SizedBox(width: 14),
          const SizedBox(width: 20),
          _headerCell('Coin', 'name', style, 40),
          const SizedBox(width: 10),
          _headerCell('Price', 'price', style, 60),
          const SizedBox(width: 5),
          SizedBox(width: 48, child: Center(child: Text('24H', style: style))),
          const SizedBox(width: 5),
          _headerCell('Market Cap', 'marketCap', style, 110),
        ],
      ),
    );
  }

  Widget _headerCell(String title, String key, TextStyle style, double width) {
    final isActive = _sortBy == key;
    final icon = _isAscending ? Icons.arrow_upward : Icons.arrow_downward;

    return GestureDetector(
      onTap: () => _onSort(key),
      child: SizedBox(
        width: width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: style.copyWith(
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            if (isActive) Icon(icon, size: 12, color: style.color),
          ],
        ),
      ),
    );
  }

  Widget _buildCoinIcon(String icon) {
    if (icon.startsWith('http')) {
      return Image.network(
        icon,
        width: 20,
        height: 20,
        errorBuilder: (_, __, ___) => const Icon(Icons.error, size: 14),
      );
    }
    return Image.asset(
      icon,
      width: 20,
      height: 20,
      errorBuilder: (_, __, ___) => const Icon(Icons.error, size: 14),
    );
  }
}
