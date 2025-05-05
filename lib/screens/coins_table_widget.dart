import 'package:flutter/material.dart';
import 'package:rwa_app/models/coin_model.dart';
import 'package:rwa_app/screens/coin_details_screen.dart';

class CoinsTable extends StatelessWidget {
  final List<Coin> coins;
  final ScrollController? scrollController; // ✅ Added

  const CoinsTable({
    super.key,
    required this.coins,
    this.scrollController, // ✅ Added
  });

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
            controller: scrollController, // ✅ Used for pagination
            itemCount: coins.length,
            itemBuilder: (context, index) {
              final coin = coins[index];
              final name = coin.name;
              final id = coin.id;
              final symbol = coin.symbol.toUpperCase();
              final icon = coin.image;
              final price = coin.currentPrice;
              final change = coin.priceChange24h;
              final rank = coin.marketCapRank.toString();
              final marketCap = coin.marketCap.toString();

              final isNegative = change < 0;
              final isPositive = change > 0;

              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CoinDetailScreen(coin: id),
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
                            child: Center(
                              child: Text('${index + 1}', style: rowStyle),
                            ),
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
                              child: Text(
                                '\$${price.toStringAsFixed(2)}',
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
                                    : ''}${change.abs().toStringAsFixed(2)}%',
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
          SizedBox(width: 24, child: Center(child: Text('#', style: style))),
          const SizedBox(width: 14),
          const SizedBox(width: 20),
          SizedBox(width: 40, child: Center(child: Text('Coin', style: style))),
          const SizedBox(width: 10),
          SizedBox(
            width: 60,
            child: Center(child: Text('Price', style: style)),
          ),
          const SizedBox(width: 5),
          SizedBox(width: 48, child: Center(child: Text('24H', style: style))),
          const SizedBox(width: 5),
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
