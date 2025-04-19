import 'package:flutter/material.dart';

class NewsDetailScreen extends StatelessWidget {
  final Map<String, dynamic> news;

  const NewsDetailScreen({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
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
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: Colors.white,
        leading: const BackButton(color: Colors.black),
        title: const Text("News", style: TextStyle(color: Colors.black)),
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
                const SizedBox(height: 8),
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
                    if (source != null && time != null) ...[
                      const SizedBox(width: 8),
                      const Icon(Icons.circle, size: 4, color: Colors.grey),
                      const SizedBox(width: 8),
                    ],
                    if (time != null)
                      Text(
                        time,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 10),

                // ⬇ Render paragraphs with tighter spacing
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

                // ⬇ Quote block
                if (quote != null && quote.isNotEmpty) ...[
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      border: Border(
                        left: BorderSide(
                          color: Colors.green.shade400,
                          width: 4,
                        ),
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

                // ⬇ Bullet Points
                if (bulletPoints.isNotEmpty) ...[
                  const SizedBox(height: 20),
                  const Text(
                    "Key Takeaways:",
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
