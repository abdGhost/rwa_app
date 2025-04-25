import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';

class BlogDetailScreen extends StatelessWidget {
  final Map<String, dynamic> blog;

  const BlogDetailScreen({super.key, required this.blog});

  String formatTime(String rawTime) {
    try {
      final cleanTime = rawTime.split(' GMT')[0];
      final formatter = DateFormat('EEE MMM dd yyyy HH:mm:ss');
      final parsedDate = formatter.parse(cleanTime);
      return DateFormat('MMM d, yyyy').format(parsedDate);
    } catch (e) {
      return rawTime;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final String? image = blog['image'];
    final String? title = blog['title'];
    final String? subtitle = blog['subtitle'];
    final String? author = blog['author'];
    final String? time = blog['time'];
    final String? content = blog['content']; // HTML content
    final Map<String, dynamic>? blockQuote = blog['blockQuote'];
    final List<String> bulletPoints = List<String>.from(
      blog['bulletPoints'] ?? [],
    );

    final formattedTime = time != null ? formatTime(time) : '';

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: theme.appBarTheme.backgroundColor ?? theme.cardColor,
        leading: BackButton(color: theme.iconTheme.color),
        title: Text("Blog", style: theme.textTheme.bodyLarge),
      ),
      body: ListView(
        children: [
          if (image != null && image.isNotEmpty)
            image.startsWith('http')
                ? Image.network(
                  image,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                )
                : Image.asset(
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
                      TextSpan(text: ' · $formattedTime'),
                    ],
                  ),
                ),
                SizedBox(height: 12),

                if (blockQuote != null && blockQuote.isNotEmpty) ...[
                  Container(
                    padding: const EdgeInsets.only(left: 12, right: 12),
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
                      blockQuote['text'] ?? '',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],

                // Render HTML content
                if (content != null && content.isNotEmpty) ...[
                  Html(
                    data: content,
                    style: {
                      'p': Style(
                        margin: Margins.only(bottom: 12),
                        fontSize: FontSize(12),
                        lineHeight: LineHeight(1.5),
                        color: theme.textTheme.bodyMedium?.color,
                      ),
                      'h2': Style(
                        fontSize: FontSize(20),
                        fontWeight: FontWeight.bold,
                        margin: Margins.only(bottom: 12),
                      ),
                      'li': Style(
                        fontSize: FontSize(16),
                        lineHeight: LineHeight(1.5),
                      ),
                    },
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
