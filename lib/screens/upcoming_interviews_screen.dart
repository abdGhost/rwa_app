import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UpcomingInterviewsScreen extends StatelessWidget {
  const UpcomingInterviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final titles = [
      "Ondo Finance CEO on Tokenized Treasuries",
      "Ondo Finance CEO on Tokenized Treasuries",
      "Ondo Finance CEO on Tokenized Treasuries",
    ];

    final subtitles = [
      "In this exclusive conversation, Nathan breaks down how Ondo is bridging traditional finance and DeFi through tokenized U.S. Treasuries.",
      "In this exclusive conversation, Nathan breaks down how Ondo is bridging traditional finance and DeFi through tokenized U.S. Treasuries.",
      "In this exclusive conversation, Nathan breaks down how Ondo is bridging traditional finance and DeFi through tokenized U.S. Treasuries.",
    ];

    final names = ["Nathan Allman", "Nathan Allman", "Nathan Allman"];
    final roles = [
      "CEO of Ondo Finance",
      "CEO of Ondo Finance",
      "CEO of Ondo Finance",
    ];
    final images = [
      "assets/thumbnail1.png",
      "assets/thumbnail2.png",
      "assets/thumbnail2.png",
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        toolbarHeight: 50,
        automaticallyImplyLeading: true,
        iconTheme: theme.iconTheme,
        title: Text(
          'Upcoming Interviews',
          style: GoogleFonts.inter(
            color: theme.textTheme.titleLarge?.color,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        itemCount: titles.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile and info
                    Column(
                      children: [
                        ClipOval(
                          child: Image.asset(
                            images[index],
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          names[index],
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: theme.textTheme.bodyMedium?.color,
                          ),
                        ),
                        Text(
                          roles[index],
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: theme.hintColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 12),
                    // Text section
                    Expanded(
                      child: SizedBox(
                        height: 100, // match image height
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              titles[index],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w600,
                                height: 1.3,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Expanded(
                              child: Text(
                                subtitles[index],
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  height: 1.3,
                                  color: theme.hintColor,
                                ),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              "Link: https://googlemeet.com",
                              style: theme.textTheme.bodySmall?.copyWith(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
