import 'package:flutter/material.dart';

class NewsDetailScreen extends StatelessWidget {
  final Map<String, dynamic> news;

  const NewsDetailScreen({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final String? image = news['image'];
    final String? title = news['title'];
    final String? source = news['source'];
    final String? time = news['time'];
    final String? content = news['content'];
    final String? quote = news['quote'];
    final List<String> bulletPoints = List<String>.from(
      news['bulletPoints'] ?? [],
    );

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: theme.appBarTheme.backgroundColor,
        leading: BackButton(color: theme.iconTheme.color),
        title: Text(
          "News",
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        // centerTitle: true,
      ),
      body: ListView(
        children: [
          if (image != null && image.isNotEmpty)
            Image.asset(
              image,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title ?? '',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    if (source != null)
                      Text(
                        source.toUpperCase(),
                        style: TextStyle(
                          color: const Color(0xFF1CB379),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    if (source != null && time != null) ...[
                      const SizedBox(width: 8),
                      const Icon(Icons.circle, size: 4, color: Colors.grey),
                      const SizedBox(width: 8),
                    ],
                    if (time != null)
                      Text(
                        time,
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 12),

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
                      border: Border(
                        left: BorderSide(
                          color: const Color(0xFF1CB379),
                          width: 4,
                        ),
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
