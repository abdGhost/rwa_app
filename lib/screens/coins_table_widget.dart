import 'package:flutter/material.dart';
import 'package:rwa_app/screens/coin_details_screen.dart';

class CoinsTable extends StatelessWidget {
  final List<Map<String, Object>> coins;
  const CoinsTable({super.key, required this.coins});

  static const TextStyle _headerStyle = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 12,
    color: Colors.grey,
  );

  static const TextStyle _rowStyle = TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 12,
    color: Colors.black,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: _buildHeaderRow(),
        ),
        const Divider(
          height: 1,
          thickness: 0.6,
          color: Color.fromARGB(255, 194, 194, 194),
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
                            trend: [20, 22, 21, 25, 24, 28, 30], // dummy trend
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
                              child: Text('${coin['rank']}', style: _rowStyle),
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
                                style: _rowStyle,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: 60,
                            child: Center(
                              child: Text(
                                '\$${double.tryParse(priceRaw)?.toStringAsFixed(2) ?? '0.00'}',
                                style: _rowStyle,
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
                                style: _rowStyle.copyWith(
                                  color:
                                      coin['changeColor'] as Color? ??
                                      Colors.grey,
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
                              style: _rowStyle,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      height: 1,
                      thickness: 0.6,
                      color: Color.fromARGB(255, 194, 194, 194),
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

  Widget _buildHeaderRow() {
    return SizedBox(
      height: 40,
      child: Row(
        children: const [
          SizedBox(
            width: 20,
            child: Center(child: Text('#', style: _headerStyle)),
          ),
          SizedBox(width: 8),
          SizedBox(width: 20),
          SizedBox(
            width: 40,
            child: Center(child: Text('Coin', style: _headerStyle)),
          ),
          SizedBox(width: 10),
          SizedBox(
            width: 50,
            child: Center(child: Text('Price', style: _headerStyle)),
          ),
          SizedBox(width: 10),
          SizedBox(
            width: 50,
            child: Center(child: Text('24H', style: _headerStyle)),
          ),
          SizedBox(width: 10),
          SizedBox(
            width: 110,
            child: Center(child: Text('Market Cap', style: _headerStyle)),
          ),
        ],
      ),
    );
  }
}
