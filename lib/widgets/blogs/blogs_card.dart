import 'package:flutter/material.dart';

class BlogCard extends StatelessWidget {
  final Map<String, String> blog;

  const BlogCard({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    final bool hasImage = blog['image'] != null && blog['image']!.isNotEmpty;
    final bool hasSubtitle =
        blog['subtitle'] != null && blog['subtitle']!.isNotEmpty;

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (hasImage)
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.asset(
                      blog['image']!,
                      width: 90,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      blog['title']!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        height: 1.3,
                        color: Color.fromRGBO(23, 20, 15, 1),
                      ),
                    ),
                  ),
                ],
              )
            else
              Text(
                blog['title']!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  height: 1.3,
                  color: Color.fromRGBO(23, 20, 15, 1),
                ),
              ),
            if (hasSubtitle) ...[
              const SizedBox(height: 6),
              Text(
                blog['subtitle']!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 11, color: Colors.grey),
              ),
            ],
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  blog['author']!,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Color.fromRGBO(28, 179, 121, 1),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 6),
                const Text(
                  '·',
                  style: TextStyle(
                    fontSize: 10,
                    color: Color.fromRGBO(28, 179, 121, 1),
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  blog['time']!,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Color.fromRGBO(28, 179, 121, 1),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
