import 'package:flutter/material.dart';

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
          thickness: .6,
          color: Color.fromARGB(255, 194, 194, 194),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: coins.length,
            itemBuilder: (context, index) {
              final coin = coins[index];
              final priceRaw = (coin['price'] as String).replaceAll(
                RegExp(r'[^\d.]'),
                '',
              );
              final changeRaw = (coin['change'] as String).replaceAll(
                RegExp(r'[^\d.]'),
                '',
              );
              final isNegative = (coin['change'] as String)
                  .toString()
                  .startsWith('-');
              final isPositive = (coin['change'] as String)
                  .toString()
                  .startsWith('+');

              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) => CoinDetailScreen(
                            coinName: coin['name'].toString(),
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
                            coin['icon'] as String,
                            width: 20,
                            height: 20,
                          ),
                          SizedBox(
                            width: 40,
                            child: Center(
                              child: Text(
                                coin['name'] as String,
                                style: _rowStyle,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: 60,
                            child: Center(
                              child: Text(
                                '\$${double.parse(priceRaw).toStringAsFixed(2)}',
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
                                    : ''}${double.parse(changeRaw).toStringAsFixed(2)}%',
                                style: _rowStyle.copyWith(
                                  color: coin['changeColor'] as Color,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: 110,
                            child: Text(
                              coin['marketCap'] as String,
                              textAlign: TextAlign.center,
                              style: _rowStyle,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      height: 1,
                      thickness: .6,
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

class CoinDetailScreen extends StatelessWidget {
  final String coinName;
  const CoinDetailScreen({super.key, required this.coinName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$coinName Details')),
      body: Center(
        child: Text(
          'Details for $coinName',
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
