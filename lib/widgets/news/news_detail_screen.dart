import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewsDetailScreen extends StatelessWidget {
  final Map<String, dynamic> news;

  const NewsDetailScreen({super.key, required this.news});

  String formatTime(String time) {
    try {
      String cleanTime = time.split(' GMT').first;
      final dateTime = DateFormat('EEE MMM dd yyyy HH:mm:ss').parse(cleanTime);
      return DateFormat(
        'MMM d, yyyy',
      ).format(dateTime); // Example: Apr 26, 2025
    } catch (e) {
      return time;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final String? image = news['thumbnail'] ?? news['image']; // safe fallback
    final String? title = news['title'];
    final String? source = news['author'] ?? news['source'];
    final String? publishDate = news['publishDate'];
    final String? createdAt = news['createdAt'];
    final String? updatedAt = news['updatedAt'];
    final String? slug = news['slug'];
    final String? content = news['content'];
    final String? quote = news['quote'];
    final List<dynamic> tags = news['tags'] ?? [];
    final List<String> bulletPoints = List<String>.from(
      news['bulletPoints'] ?? [],
    );

    final String formattedPublishDate =
        (publishDate != null && publishDate.isNotEmpty)
            ? formatTime(publishDate)
            : '';
    final String formattedCreatedAt =
        (createdAt != null && createdAt.isNotEmpty)
            ? formatTime(createdAt)
            : '';
    final String formattedUpdatedAt =
        (updatedAt != null && updatedAt.isNotEmpty)
            ? formatTime(updatedAt)
            : '';

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: theme.appBarTheme.backgroundColor,
        leading: BackButton(color: theme.iconTheme.color),
        title: Text(
          "News Details",
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: ListView(
        children: [
          if (image != null && image.isNotEmpty)
            Image.network(
              image,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 200,
                  color: Colors.grey.shade300,
                  child: const Icon(
                    Icons.broken_image,
                    size: 60,
                    color: Colors.grey,
                  ),
                );
              },
            ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                if (title != null && title.isNotEmpty)
                  Text(
                    title,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                const SizedBox(height: 8),

                // Source, Author and Publish Time
                Row(
                  children: [
                    if (source != null)
                      Text(
                        source.toUpperCase(),
                        style: const TextStyle(
                          color: Color(0xFF1CB379),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    if (source != null && formattedPublishDate.isNotEmpty) ...[
                      const SizedBox(width: 8),
                      const Icon(Icons.circle, size: 4, color: Colors.grey),
                      const SizedBox(width: 8),
                    ],
                    if (formattedPublishDate.isNotEmpty)
                      Text(
                        formattedPublishDate,
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),

                // Slug
                if (slug != null && slug.isNotEmpty)
                  Text(
                    slug,
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontSize: 11,
                      color: Colors.grey,
                      fontStyle: FontStyle.italic,
                    ),
                  ),

                // CreatedAt and UpdatedAt
                if (formattedCreatedAt.isNotEmpty ||
                    formattedUpdatedAt.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Row(
                      children: [
                        if (formattedCreatedAt.isNotEmpty)
                          Text(
                            "Created: $formattedCreatedAt",
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontSize: 11,
                              color: Colors.grey,
                            ),
                          ),
                        if (formattedUpdatedAt.isNotEmpty) ...[
                          const SizedBox(width: 10),
                          Text(
                            "Updated: $formattedUpdatedAt",
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontSize: 11,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),

                const SizedBox(height: 12),

                // Tags
                if (tags.isNotEmpty) ...[
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children:
                        tags.map<Widget>((tag) {
                          return Chip(
                            label: Text(tag.toString()),
                            backgroundColor:
                                isDark
                                    ? Colors.grey.shade800
                                    : Colors.grey.shade200,
                            labelStyle: theme.textTheme.bodySmall,
                          );
                        }).toList(),
                  ),
                  const SizedBox(height: 12),
                ],

                // Content
                if (content != null && content.isNotEmpty)
                  ...content
                      .trim()
                      .split('\n\n')
                      .map(
                        (para) => Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Text(
                            para.trim(),
                            style: theme.textTheme.bodyMedium?.copyWith(
                              height: 1.5,
                            ),
                          ),
                        ),
                      ),

                // Quote block
                if (quote != null && quote.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color:
                          isDark ? Colors.grey.shade900 : Colors.grey.shade100,
                      border: const Border(
                        left: BorderSide(color: Color(0xFF1CB379), width: 4),
                      ),
                    ),
                    child: Text(
                      quote,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],

                // Bullet Points
                if (bulletPoints.isNotEmpty) ...[
                  const SizedBox(height: 20),
                  Text(
                    "Key Takeaways:",
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...bulletPoints.map(
                    (point) => Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "• ",
                            style: TextStyle(fontSize: 14, height: 1.5),
                          ),
                          Expanded(
                            child: Text(
                              point,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
