import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NewsAppBarTitleRow extends StatelessWidget {
  final VoidCallback onSearchTap;

  const NewsAppBarTitleRow({super.key, required this.onSearchTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          'News',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: onSearchTap,
          child: SvgPicture.asset(
            'assets/search_outline.svg',
            width: 24,
            height: 24,
          ),
        ),
        const SizedBox(width: 16),
        SvgPicture.asset('assets/profile_outline.svg', width: 28, height: 28),
      ],
    );
  }
}
