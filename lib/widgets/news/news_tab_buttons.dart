import 'package:flutter/material.dart';

class NewsTabButtons extends StatelessWidget {
  final int selectedTab;
  final void Function(int) onTabSelected;

  const NewsTabButtons({
    super.key,
    required this.selectedTab,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          _buildTabButton(context, "Industry News", 0),
          const SizedBox(width: 8),
          _buildTabButton(context, "Editorial Blogs", 1),
        ],
      ),
    );
  }

  Widget _buildTabButton(BuildContext context, String label, int index) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final bool isSelected = selectedTab == index;

    final Color selectedBg =
        isDark
            ? const Color.fromRGBO(28, 179, 121, 0.2)
            : const Color.fromRGBO(28, 179, 121, 0.3);

    final Color selectedFg =
        isDark ? const Color(0xFF1CB379) : const Color.fromRGBO(34, 113, 82, 1);

    final Color unselectedFg =
        isDark ? Colors.grey[400]! : const Color(0xFF888888);
    final Color unselectedBg = theme.cardColor;

    return Expanded(
      child: ElevatedButton(
        onPressed: () => onTabSelected(index),
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: isSelected ? selectedBg : unselectedBg,
          foregroundColor: isSelected ? selectedFg : unselectedFg,
          side: BorderSide(
            color: const Color.fromRGBO(52, 143, 108, 0.3),
            width: 1,
          ),
          padding: const EdgeInsets.symmetric(vertical: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
        ),
        child: Text(label),
      ),
    );
  }
}
