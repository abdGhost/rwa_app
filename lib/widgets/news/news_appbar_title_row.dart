import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rwa_app/screens/profile_screen.dart'; // Make sure this import exists

class NewsAppBarTitleRow extends StatelessWidget {
  final VoidCallback onSearchTap;

  const NewsAppBarTitleRow({super.key, required this.onSearchTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconColor = theme.iconTheme.color ?? Colors.black;
    final textColor = theme.textTheme.titleLarge?.color ?? Colors.black;

    return Row(
      children: [
        Text(
          'News',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: onSearchTap,
          child: SvgPicture.asset(
            'assets/search_outline.svg',
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
          ),
        ),
        const SizedBox(width: 16),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ProfileScreen()),
            );
          },
          child: SvgPicture.asset(
            'assets/profile_outline.svg',
            width: 28,
            height: 28,
            colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
          ),
        ),
      ],
    );
  }
}
