import 'package:flutter/material.dart';
import 'package:rwa_app/widgets/video_widegt.dart';

class RecordedInterviewsScreen extends StatelessWidget {
  const RecordedInterviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final interviews = [
      {
        "title": "Goldfinch: Driving Innovation in Real-World Lending",
        "guest": "Guest: Mike Sall, Co-Founder of Goldfinch",
        "image": "assets/thumbnail1.png",
      },
      {
        "title": "Tokeny: Unlocking Capital in Private Markets",
        "guest": "Guest: Luc Falempin, CEO of Tokeny",
        "image": "assets/thumbnail2.png",
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("All Recorded Interviews"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      backgroundColor: const Color(0xFFF7F7F7),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: interviews.length,
        itemBuilder: (context, index) {
          final item = interviews[index];
          return videoCard(item["title"]!, item["guest"]!, item["image"]!);
        },
      ),
    );
  }
}
