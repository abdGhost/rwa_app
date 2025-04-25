import 'package:flutter/material.dart';
import 'package:rwa_app/screens/coin_details_screen.dart';

class CoinsTable extends StatelessWidget {
  final List<Map<String, Object>> coins;
  const CoinsTable({super.key, required this.coins});

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
        const SizedBox(height: 8),
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
            itemCount: coins.length,
            itemBuilder: (context, index) {
              final coin = coins[index];

              final name = coin['name']?.toString() ?? "Unknown";
              final symbol = coin['symbol']?.toString().toUpperCase() ?? "N/A";
              final icon = coin['image']?.toString() ?? 'assets/logo.png';
              final price = coin['current_price'];
              final change =
                  coin['price_change_percentage_24h']?.toString() ?? "0";
              final rank = coin['market_cap_rank']?.toString() ?? "-";
              final marketCap = coin['market_cap']?.toString() ?? "-";

              print(price);
              final changeRaw = change.replaceAll(RegExp(r'[^\d.-]'), '');
              final isNegative = change.startsWith("-");
              final isPositive =
                  change.startsWith("+") ||
                  double.tryParse(change) != null && double.parse(change) > 0;

              // ** NEW ** format price to 6 decimals
              final priceValue =
                  (coin['current_price'] as num?)?.toDouble() ?? 0.0;
              final priceText = priceValue.toStringAsFixed(2);

              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) => CoinDetailScreen(
                            coin: {
                              "name": name,
                              "symbol": symbol,
                              "logo": icon,
                              "amount": "\$$price",
                              "change": double.tryParse(changeRaw) ?? 0.0,
                            },
                            trend: [20, 22, 21, 25, 24, 28, 30],
                          ),
                    ),
                  );
                },
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
                            child: Center(child: Text(rank, style: rowStyle)),
                          ),
                          const SizedBox(width: 14),
                          _buildCoinIcon(icon),
                          SizedBox(
                            width: 40,
                            child: Center(child: Text(symbol, style: rowStyle)),
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: 60,
                            child: Center(
                              child: Text('\$$priceText', style: rowStyle),
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
                                    : ''}'
                                '${double.tryParse(changeRaw)?.toStringAsFixed(2) ?? '0.00'}%',
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
                              marketCap,
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
          const SizedBox(
            width: 20,
            child: Center(
              child: Text(
                '#',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          const SizedBox(width: 20),
          SizedBox(width: 40, child: Center(child: Text('Coin', style: style))),
          const SizedBox(width: 20),
          SizedBox(
            width: 50,
            child: Center(child: Text('Price', style: style)),
          ),
          const SizedBox(width: 8),
          SizedBox(width: 50, child: Center(child: Text('24H', style: style))),
          const SizedBox(width: 10),
          SizedBox(
            width: 110,
            child: Center(child: Text('Market Cap', style: style)),
          ),
        ],
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
