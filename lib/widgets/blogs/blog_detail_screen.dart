import 'package:flutter/material.dart';

class BlogDetailScreen extends StatelessWidget {
  final Map<String, dynamic> blog;

  const BlogDetailScreen({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
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
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: Colors.white,
        leading: const BackButton(color: Colors.black),
        title: const Text("Blog", style: TextStyle(color: Colors.black)),
        centerTitle: true,
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
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    height: 1.3,
                    color: Color(0xFF17140F),
                  ),
                ),
                const SizedBox(height: 6),
                if (subtitle != null && subtitle.isNotEmpty)
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.5,
                      color: Colors.grey,
                    ),
                  ),
                const SizedBox(height: 12),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                    children: [
                      const TextSpan(text: 'Written by - '),
                      TextSpan(
                        text: author ?? '',
                        style: const TextStyle(
                          color: Color(0xFF1CB379), // ✅ Only author in green
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(text: ' · ${time ?? ''}'),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // 🟢 Reduced spacing between paragraphs
                if (content != null && content.isNotEmpty)
                  ...content
                      .trim()
                      .split('\n\n')
                      .map(
                        (para) => Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Text(
                            para.trim(),
                            style: const TextStyle(
                              fontSize: 14,
                              height: 1.5,
                              color: Color(0xFF17140F),
                            ),
                          ),
                        ),
                      ),

                if (quote != null && quote.isNotEmpty) ...[
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      border: Border(
                        left: BorderSide(color: Colors.green, width: 4),
                      ),
                    ),
                    child: Text(
                      quote,
                      style: const TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
                if (bulletPoints.isNotEmpty) ...[
                  const SizedBox(height: 20),
                  const Text(
                    "Key Insights:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
                              style: const TextStyle(fontSize: 14, height: 1.5),
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
