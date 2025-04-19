import 'package:flutter/material.dart';

class NewsCardMain extends StatelessWidget {
  final Map<String, dynamic> item;
  final VoidCallback? onTap;

  const NewsCardMain({super.key, required this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    final bool hasSubtitle =
        item['subtitle'] != null && item['subtitle'].toString().isNotEmpty;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
            child: Image.asset(
              item['image'],
              width: double.infinity,
              height: 140,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 8, 4, 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['title'],
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    height: 1.3,
                    color: Colors.black,
                  ),
                ),
                if (hasSubtitle) ...[
                  const SizedBox(height: 2),
                  Text(
                    item['subtitle'],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ),
                ],
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      item['source'],
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
                      item['time'],
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
}
