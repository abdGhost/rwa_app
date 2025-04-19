import 'package:flutter/material.dart';

class NewsCardSide extends StatelessWidget {
  final Map<String, dynamic> item;
  final VoidCallback? onTap;

  const NewsCardSide({super.key, required this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    final hasSubtitle =
        item['subtitle'] != null && item['subtitle'].toString().isNotEmpty;
    final image = item['image']?.toString();
    final imageHeight = hasSubtitle ? 80.0 : 70.0;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (image != null && image.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.asset(
                    image,
                    width: 70,
                    height: imageHeight,
                    fit: BoxFit.cover,
                  ),
                ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['title'] ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        height: 1.25,
                      ),
                    ),
                    if (hasSubtitle) ...[
                      const SizedBox(height: 4),
                      Text(
                        item['subtitle'],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          item['source'] ?? '',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color.fromRGBO(28, 179, 121, 1),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Text(
                          '·',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          item['time'] ?? '',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
