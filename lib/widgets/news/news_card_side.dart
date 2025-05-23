import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For time formatting

class NewsCardSide extends StatelessWidget {
  final Map<String, dynamic> item;
  final VoidCallback? onTap;

  const NewsCardSide({super.key, required this.item, this.onTap});

  String formatTime(String time) {
    try {
      // Fix weird "GMT" string manually
      String cleanTime = time.split(' GMT').first;
      final dateTime = DateFormat('EEE MMM dd yyyy HH:mm:ss').parse(cleanTime);
      return DateFormat('MMM d, yyyy').format(dateTime); // Ex: Apr 26, 2025
    } catch (e) {
      print('❌ Error parsing date: $e');
      return time; // fallback
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasSubtitle =
        item['subtitle'] != null && item['subtitle'].toString().isNotEmpty;
    final image = item['image']?.toString();
    final imageHeight = hasSubtitle ? 80.0 : 70.0;

    final titleColor = theme.textTheme.bodyLarge?.color ?? Colors.black;
    final subtitleColor =
        theme.textTheme.bodySmall?.color?.withOpacity(0.7) ?? Colors.grey;
    final borderColor = theme.dividerColor.withOpacity(0.15);
    final highlightColor = const Color(0xFF1CB379);

    final String rawTime = item['time'] ?? '';
    final String formattedTime = rawTime.isNotEmpty ? formatTime(rawTime) : '';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 4),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: borderColor),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (image != null && image.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.network(
                    image,
                    width: 70,
                    height: imageHeight,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 70,
                        height: imageHeight,
                        color: Colors.grey.shade300,
                        child: const Icon(
                          Icons.broken_image,
                          size: 30,
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),
                ),
              if (image != null && image.isNotEmpty) const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['title'] ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 13.5,
                        height: 1.25,
                        color: titleColor,
                      ),
                    ),
                    if (hasSubtitle) ...[
                      const SizedBox(height: 4),
                      Text(
                        item['subtitle'],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontSize: 10,
                          color: subtitleColor,
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
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '·',
                          style: TextStyle(fontSize: 12, color: subtitleColor),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          formattedTime,
                          style: TextStyle(fontSize: 12, color: subtitleColor),
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
