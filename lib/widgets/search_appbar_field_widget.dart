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
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade400, width: 0.4),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                const Icon(
                  Icons.search,
                  color: Color.fromRGBO(149, 149, 149, 1),
                  size: 24,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: controller,
                    autofocus: true,
                    cursorColor: Colors.green,
                    style: const TextStyle(fontSize: 16, color: Colors.green),
                    decoration: const InputDecoration(
                      hintText: 'Search for Articles',
                      hintStyle: TextStyle(
                        color: Color.fromRGBO(149, 149, 149, 1),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: onCancel,
          child: const Text(
            'Cancel',
            style: TextStyle(
              color: Colors.green,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
