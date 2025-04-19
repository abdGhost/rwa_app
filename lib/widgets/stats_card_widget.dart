import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

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
