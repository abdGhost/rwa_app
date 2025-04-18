import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rwa_app/screens/coin_search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCoin = 'None';

  @override
  Widget build(BuildContext context) {
    final double totalSpacing = 2 * 3;
    final double cardWidth =
        (MediaQuery.of(context).size.width - 24 - totalSpacing) / 4;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(247, 247, 247, 1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        automaticallyImplyLeading: false,
        toolbarHeight: 60,
        title: Row(
          children: [
            Image.asset('assets/logo.png', width: 32, height: 32),
            const SizedBox(width: 8),
            Text(
              'RWA CAMP',
              style: GoogleFonts.inter(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CoinSearch()),
              );
              if (result != null) {
                setState(() {
                  selectedCoin = result;
                });
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: SvgPicture.asset(
                'assets/search_outline.svg',
                width: 24,
                height: 24,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: SvgPicture.asset(
              'assets/profile_outline.svg',
              width: 30,
              height: 30,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                StatCard(
                  title: 'Market Cap',
                  value: '\$2.79 T',
                  change: '+5.78%',
                  changeColor: const Color.fromARGB(255, 109, 247, 114),
                  width: cardWidth,
                  isFirst: true,
                ),
                const SizedBox(width: 2),
                StatCard(
                  title: 'Volume',
                  value: '\$3.48 T',
                  change: '+8.59%',
                  changeColor: const Color.fromARGB(255, 109, 247, 114),
                  width: cardWidth,
                ),
                const SizedBox(width: 2),
                StatCard(
                  title: 'Dominance',
                  value: '26.46%',
                  subtitle: 'LINK',
                  changeColor: Colors.blue,
                  width: cardWidth,
                ),
                const SizedBox(width: 2),
                StatCard(
                  title: 'Fear & Greed',
                  value: '31',
                  changeColor: Colors.red,
                  width: cardWidth,
                  isLast: true,
                  isFearGreed: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Center(
              child: Text(
                'Selected Coin: $selectedCoin',
                style: GoogleFonts.inter(fontSize: 16, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String? subtitle;
  final String? change;
  final Color changeColor;
  final double width;
  final bool isFirst;
  final bool isLast;
  final bool isFearGreed;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    this.subtitle,
    this.change,
    required this.changeColor,
    required this.width,
    this.isFirst = false,
    this.isLast = false,
    this.isFearGreed = false,
  });

  String _getFearGreedSvg(int index) {
    if (index < 20) return 'assets/fear_greed/fear-1.svg';
    if (index < 40) return 'assets/fear_greed/fear-2.svg';
    if (index < 60) return 'assets/fear_greed/neutral.svg';
    if (index < 80) return 'assets/fear_greed/greed-1.svg';
    return 'assets/fear_greed/greed-2.svg';
  }

  @override
  Widget build(BuildContext context) {
    final int indexValue =
        int.tryParse(value.replaceAll(RegExp(r'\D'), '')) ?? 0;

    return Container(
      width: width,
      height: 90,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 63, 167, 127),
        borderRadius: BorderRadius.horizontal(
          left: isFirst ? const Radius.circular(12) : Radius.zero,
          right: isLast ? const Radius.circular(12) : Radius.zero,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment:
            isFearGreed ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.inter(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          if (isFearGreed)
            Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset(
                  _getFearGreedSvg(indexValue),
                  width: 42,
                  height: 42,
                  fit: BoxFit.contain,
                ),
                Text(
                  '$indexValue',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            )
          else ...[
            Text(
              value,
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 1),
            if (subtitle != null && subtitle!.isNotEmpty)
              Row(
                children: [
                  Image.asset(
                    'assets/icons/${subtitle!.toLowerCase()}.png',
                    width: 14,
                    height: 14,
                    errorBuilder:
                        (_, __, ___) => Image.asset(
                          'assets/default-coin.png',
                          width: 16,
                          height: 16,
                        ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    subtitle!,
                    style: GoogleFonts.inter(fontSize: 12, color: Colors.white),
                  ),
                ],
              ),
            if (change != null)
              Row(
                children: [
                  Icon(
                    change!.startsWith('+')
                        ? Icons.arrow_upward
                        : Icons.arrow_downward,
                    size: 12,
                    color: changeColor,
                  ),
                  const SizedBox(width: 2),
                  Text(
                    change!.replaceAll(RegExp(r'^[\+\-]'), ''),
                    style: GoogleFonts.inter(fontSize: 12, color: changeColor),
                  ),
                ],
              ),
          ],
        ],
      ),
    );
  }
}
