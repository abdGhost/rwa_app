import 'package:flutter/material.dart';

class NewsMainCard extends StatelessWidget {
  const NewsMainCard({super.key});

  @override
  Widget build(BuildContext context) {
    return  _mainNewsCard(Map<String, String> item) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
            child: Image.asset(
              item['image']!,
              width: double.infinity,
              height: 140,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['title']!,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    height: 1.2,
                    color: Colors.black,
                  ),
                ),
                if (item['subtitle'] != null &&
                    item['subtitle']!.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    item['subtitle']!,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ),
                ],
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      item['source']!,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color.fromRGBO(28, 179, 121, 1),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      '·',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color.fromRGBO(28, 179, 121, 1),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      item['time']!,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color.fromRGBO(28, 179, 121, 1),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
;
  }
}
