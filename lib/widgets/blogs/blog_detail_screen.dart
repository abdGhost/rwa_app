import 'package:flutter/material.dart';

class BlogDetailScreen extends StatelessWidget {
  final Map<String, dynamic> blog;

  const BlogDetailScreen({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final String? image = blog['image'];
    final String? title = blog['title'];
    final String? subtitle = blog['subtitle'];
    final String? author = blog['author'];
    final String? time = blog['time'];
    final String? content = blog['content'];
    final String? quote = blog['quote'];
    final List<String> bulletPoints = List<String>.from(
      blog['bulletPoints'] ?? [],
    );

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: theme.appBarTheme.backgroundColor ?? theme.cardColor,
        leading: BackButton(color: theme.iconTheme.color),
        title: Text("Blog", style: theme.textTheme.titleMedium),
      ),
      body: ListView(
        children: [
          if (image != null && image.isNotEmpty)
            Image.asset(
              image,
              width: double.infinity,
              fit: BoxFit.cover,
              height: 200,
            ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title ?? '',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 6),
                if (subtitle != null && subtitle.isNotEmpty)
                  Text(
                    subtitle,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.textTheme.bodySmall?.color,
                      height: 1.5,
                    ),
                  ),
                const SizedBox(height: 12),
                RichText(
                  text: TextSpan(
                    style: theme.textTheme.bodySmall,
                    children: [
                      const TextSpan(text: 'Written by - '),
                      TextSpan(
                        text: author ?? '',
                        style: const TextStyle(
                          color: Color(0xFF1CB379),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(text: ' · ${time ?? ''}'),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

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

                if (quote != null && quote.isNotEmpty) ...[
                  const SizedBox(height: 20),
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

                if (bulletPoints.isNotEmpty) ...[
                  const SizedBox(height: 20),
                  Text(
                    "Key Insights:",
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
                          const Text("• "),
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
