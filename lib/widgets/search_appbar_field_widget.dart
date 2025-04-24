import 'package:flutter/material.dart';

class SearchAppBarField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onCancel;

  const SearchAppBarField({
    super.key,
    required this.controller,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Row(
      children: [
        Expanded(
          child: Container(
            height: 44,
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFF16C784), width: 0.8),
            ),
            alignment: Alignment.center,
            child: TextField(
              controller: controller,
              autofocus: true,
              cursorColor: const Color(0xFF16C784),
              style: theme.textTheme.bodyMedium?.copyWith(
                color: const Color(0xFF16C784),
              ),
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                hintText: "Search...",
                hintStyle: TextStyle(
                  fontSize: 14,
                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  size: 20,
                  color: Colors.grey,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: onCancel,
          child: Text(
            'Cancel',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF16C784),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
