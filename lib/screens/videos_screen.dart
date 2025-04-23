import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rwa_app/screens/chat_screen.dart';
import 'package:rwa_app/screens/educational_videos_screen.dart';
import 'package:rwa_app/screens/upcoming_interviews_screen.dart';
import 'package:rwa_app/screens/recorded_interviews_screen.dart';

class VideosScreen extends StatelessWidget {
  const VideosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth * 0.4;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        automaticallyImplyLeading: false,
        toolbarHeight: 40,
        title: Row(
          children: [
            Text(
              'Video',
              style: GoogleFonts.inter(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: SvgPicture.asset(
              'assets/profile_outline.svg',
              width: 30,
              height: 30,
            ),
          ),
        ],
      ),

      floatingActionButton: SizedBox(
        width: 56,
        height: 56,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ChatScreen()),
            );
          },
          backgroundColor: const Color(0xFF348F6C),
          shape: const CircleBorder(),
          child: SvgPicture.asset(
            'assets/bot_light.svg',
            width: 40,
            height: 40,
            fit: BoxFit.contain,
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionTitle("Educational Videos", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const EducationalVideosScreen(),
                  ),
                );
              }),
              const SizedBox(height: 8),
              _videoSlider(cardWidth, [
                {
                  "title": "What Are Real World Assets (RWAs)?",
                  "image": "assets/thumbnail1.png",
                },
                {
                  "title": "Why Invest in RWA Tokens?",
                  "image": "assets/thumbnail2.png",
                },
              ]),
              _videoSlider(cardWidth, [
                {
                  "title": "How Tokenization Works",
                  "image": "assets/thumbnail2.png",
                },
                {
                  "title": "RWA vs DeFi: What's the Difference?",
                  "image": "assets/thumbnail2.png",
                },
              ]),
              _sectionTitle("Upcoming Interviews", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const UpcomingInterviewsScreen(),
                  ),
                );
              }),
              _interviewTile(
                "Chat with Condo CEO",
                "April 21 at 5:00 PM",
                "LIVE",
              ),
              _interviewTile(
                "How RealT Fractionalizes Real Estate",
                "April 27 at 5:00 PM",
                "Scheduled",
              ),
              const SizedBox(height: 10),
              _sectionTitle("Recorded Interviews", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const RecordedInterviewsScreen(),
                  ),
                );
              }),
              _recordedInterviewCard(
                "Goldfinch: Driving Innovation in Real-World Lending",
                "Guest: Mike Sall, Co-Founder of Goldfinch",
                "assets/thumbnail1.png",
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _sectionTitle(String title, VoidCallback onSeeAll) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF000000),
            ),
          ),
        ),
        GestureDetector(
          onTap: onSeeAll,
          child: const Text(
            "See all",
            style: TextStyle(color: Colors.blue, fontSize: 12),
          ),
        ),
      ],
    );
  }

  static Widget _videoSlider(
    double cardWidth,
    List<Map<String, String>> videos,
  ) {
    return SizedBox(
      height: 160,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: videos.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final video = videos[index];
          return SizedBox(
            width: cardWidth,
            child: _videoCard(video['image']!, video['title']!, "8:20"),
          );
        },
      ),
    );
  }

  static Widget _videoCard(String imagePath, String title, String duration) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  imagePath,
                  width: double.infinity,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 4,
                right: 4,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  color: Colors.black87,
                  child: Text(
                    duration,
                    style: const TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0xFF000000),
              height: 1.2,
            ),
          ),
          const SizedBox(height: 2),
          const Text(
            "Subtitle here",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w400,
              color: Color(0xFF818181),
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  static Widget _interviewTile(String title, String time, String badge) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 26,
            backgroundImage: AssetImage("assets/interview1.png"),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Color(0xFF000000),
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF525252),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 8),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: badge == "LIVE" ? Colors.red : Colors.grey,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              badge,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _recordedInterviewCard(
    String title,
    String guest,
    String imagePath, {
    String subtitle =
        "Exclusive discussion on unlocking credit for emerging markets through real-world lending protocols.",
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(33, 236, 236, 236),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
              child: Image.asset(imagePath, width: 120, fit: BoxFit.cover),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Color(0xFF000000),
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      guest,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF348f6c),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF818181),
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
