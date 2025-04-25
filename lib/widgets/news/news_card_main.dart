import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For time formatting

class NewsCardMain extends StatelessWidget {
  final Map<String, dynamic> item;
  final VoidCallback? onTap;

  const NewsCardMain({super.key, required this.item, this.onTap});

  String formatTime(String time) {
    try {
      // Example input: Wed Oct 30 2024 10:35:34 GMT+0000 (UTC)
      List<String> parts = time.split(' ');
      if (parts.length < 6) return time;

      // Example parts = [Wed, Oct, 30, 2024, 10:35:34, GMT+0000, (UTC)]
      String month = parts[1];
      String day = parts[2];
      String year = parts[3];

      final dateString = '$day $month $year'; // Example: 30 Oct 2024
      final dateTime = DateFormat('d MMM yyyy').parse(dateString);

      return DateFormat(
        'MMM d, yyyy',
      ).format(dateTime); // Example: Oct 30, 2024
    } catch (e) {
      print('❌ Error parsing date: $e');
      return time; // fallback
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.textTheme.bodyLarge?.color ?? Colors.black;
    final subtitleColor =
        theme.textTheme.bodySmall?.color?.withOpacity(0.6) ?? Colors.grey;
    final highlightColor = const Color(0xFF1CB379);
    final bool hasSubtitle =
        item['subtitle'] != null && item['subtitle'].toString().isNotEmpty;
    final String imageUrl = item['image'] ?? '';
    final String rawTime = item['time'] ?? '';
    final String formattedTime = rawTime.isNotEmpty ? formatTime(rawTime) : '';

    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
            child:
                imageUrl.startsWith('http')
                    ? Image.network(
                      imageUrl,
                      width: double.infinity,
                      height: 140,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: double.infinity,
                          height: 140,
                          color: Colors.grey.shade300,
                          child: const Icon(
                            Icons.broken_image,
                            size: 48,
                            color: Colors.grey,
                          ),
                        );
                      },
                    )
                    : Container(
                      width: double.infinity,
                      height: 140,
                      color: Colors.grey.shade300,
                      child: const Icon(
                        Icons.image,
                        size: 48,
                        color: Colors.grey,
                      ),
                    ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 8, 4, 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['title'] ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    height: 1.3,
                    color: textColor,
                  ),
                ),
                if (hasSubtitle) ...[
                  const SizedBox(height: 2),
                  Text(
                    item['subtitle'],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontSize: 10,
                      color: subtitleColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      item['source'] ?? '',
                      style: TextStyle(
                        fontSize: 12,
                        color: highlightColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '·',
                      style: TextStyle(fontSize: 12, color: highlightColor),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      formattedTime,
                      style: TextStyle(fontSize: 12, color: highlightColor),
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
