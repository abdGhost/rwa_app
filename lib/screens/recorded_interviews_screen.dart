import 'package:flutter/material.dart';
import 'package:rwa_app/screens/video_player_modal.dart';
import 'package:rwa_app/widgets/video_widegt.dart';
import 'package:rwa_app/screens/videos_screen.dart'; // for Interview class

class RecordedInterviewsScreen extends StatelessWidget {
  final List<Interview> interviews;

  const RecordedInterviewsScreen({super.key, required this.interviews});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
          final i = interviews[index];
          return GestureDetector(
            onTap: () {
              if (i.videoLinkUrl != null) {
                showDialog(
                  context: context,
                  barrierColor: Colors.black.withOpacity(0.95),
                  builder:
                      (_) => Dialog(
                        backgroundColor: Colors.transparent,
                        insetPadding: EdgeInsets.zero,
                        child: VideoPlayerModal(
                          videoUrl: i.videoLinkUrl!,
                          title: i.topicTitle,
                        ),
                      ),
                );
              }
            },
            child: recordedInterviewCard(
              i.topicTitle,
              "Guest: ${i.founderName}, ${i.designation}",
              i.videoThumbnail ?? '',
              subtitle:
                  i.topicDescription ?? '', // or any other description field
              isAsset: false,
            ),
          );
        },
      ),
    );
  }
}
