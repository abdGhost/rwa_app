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
          _buildTabButton("Industry News", 0),
          const SizedBox(width: 8),
          _buildTabButton("Editorial Blogs", 1),
        ],
      ),
    );
  }

  Widget _buildTabButton(String label, int index) {
    final bool isSelected = selectedTab == index;

    return Expanded(
      child: ElevatedButton(
        onPressed: () => onTabSelected(index),
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor:
              isSelected
                  ? const Color.fromRGBO(28, 179, 121, 0.3)
                  : Colors.white,
          foregroundColor:
              isSelected
                  ? const Color.fromRGBO(34, 113, 82, 1)
                  : const Color.fromRGBO(136, 136, 136, 1),
          side: const BorderSide(
            color: Color.fromRGBO(52, 143, 108, 0.3),
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
