import 'package:flutter/material.dart';
import 'package:rwa_app/screens/coin_details_screen.dart';

class CoinsTable extends StatelessWidget {
  final List<Map<String, Object>> coins;
  const CoinsTable({super.key, required this.coins});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final headerStyle = TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 12,
      color: theme.textTheme.bodySmall?.color ?? Colors.grey,
    );
    final rowStyle = TextStyle(
      fontWeight: FontWeight.normal,
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

              final price = (coin['price'] as String?) ?? "\$0.00";
              final priceRaw = price.replaceAll(RegExp(r'[^\d.]'), '');

              final change = (coin['change'] as String?) ?? "0.00";
              final changeRaw = change.replaceAll(RegExp(r'[^\d.-]'), '');

              final isNegative = change.startsWith("-");
              final isPositive = change.startsWith("+");

              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) => CoinDetailScreen(
                            coin: {
                              "name": coin['name'] ?? "Unknown",
                              "symbol": coin['symbol'] ?? "N/A",
                              "logo": coin['icon'] ?? "assets/logo.png",
                              "amount": price,
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
                            width: 20,
                            child: Center(
                              child: Text('${coin['rank']}', style: rowStyle),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Image.asset(
                            coin['icon'] as String? ?? 'assets/logo.png',
                            width: 20,
                            height: 20,
                            errorBuilder:
                                (_, __, ___) =>
                                    const Icon(Icons.error, size: 16),
                          ),
                          SizedBox(
                            width: 40,
                            child: Center(
                              child: Text(
                                coin['name'] as String? ?? "",
                                style: rowStyle,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: 60,
                            child: Center(
                              child: Text(
                                '\$${double.tryParse(priceRaw)?.toStringAsFixed(2) ?? '0.00'}',
                                style: rowStyle,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
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
                                      coin['changeColor'] as Color? ??
                                      (isNegative
                                          ? Colors.red
                                          : isPositive
                                          ? Colors.green
                                          : theme.textTheme.bodyLarge?.color),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: 110,
                            child: Text(
                              coin['marketCap'] as String? ?? "-",
                              textAlign: TextAlign.center,
                              style: rowStyle,
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
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
              ),
            ),
          ),
          const SizedBox(width: 8),
          const SizedBox(width: 20),
          SizedBox(width: 40, child: Center(child: Text('Coin', style: style))),
          const SizedBox(width: 10),
          SizedBox(
            width: 50,
            child: Center(child: Text('Price', style: style)),
          ),
          const SizedBox(width: 10),
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
}
