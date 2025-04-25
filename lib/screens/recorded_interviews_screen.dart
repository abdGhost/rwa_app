import 'package:flutter/material.dart';
import 'package:rwa_app/widgets/video_widegt.dart';

class RecordedInterviewsScreen extends StatelessWidget {
  const RecordedInterviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final interviews = [
      {
        "title": "Goldfinch: Driving Innovation in Real-World Lending",
        "guest": "Guest: Mike Sall, Co-Founder of Goldfinch",
        "image": "assets/thumbnail1.png",
      },
      {
        "title": "Tokeny: Unlocking Capital in Private Markets",
        "guest": "Guest: Luc Falempin, CEO of Tokeny",
        "image": "assets/thumbnail1.png",
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("All Recorded Interviews"),
        backgroundColor: theme.appBarTheme.backgroundColor ?? theme.cardColor,
        foregroundColor: theme.textTheme.titleLarge?.color,
        elevation: 1,
      ),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: interviews.length,
        itemBuilder: (context, index) {
          final item = interviews[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: videoCard(item["image"]!, item["title"]!, item["guest"]!),
          );
        },
      ),
    );
  }
}
