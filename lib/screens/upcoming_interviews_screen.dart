import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UpcomingInterviewsScreen extends StatelessWidget {
  const UpcomingInterviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
        backgroundColor: const Color(0xFFF7F7F7),
        elevation: 0,
        toolbarHeight: 50,
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          'Upcoming Interviews',
          style: GoogleFonts.inter(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      backgroundColor: const Color(0xFFF7F7F7),
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
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF000000),
                          ),
                        ),
                        Text(
                          roles[index],
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF818181),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 12),
                    // Text section
                    Expanded(
                      child: SizedBox(
                        height: 90, // match image height
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              titles[index],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                height: 1.3,
                                color: Color(0xFF000000),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Expanded(
                              child: Text(
                                subtitles[index],
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF818181),
                                  height: 1.3,
                                ),
                              ),
                            ),
                            const SizedBox(height: 2),
                            const Text(
                              "Link: https://googlemeet.com",
                              style: TextStyle(
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
