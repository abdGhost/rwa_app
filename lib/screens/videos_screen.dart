import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rwa_app/screens/chat_screen.dart';
import 'package:rwa_app/screens/educational_videos_screen.dart';
import 'package:rwa_app/screens/profile_screen.dart';
import 'package:rwa_app/screens/upcoming_interviews_screen.dart';
import 'package:rwa_app/screens/recorded_interviews_screen.dart';

class VideosScreen extends StatelessWidget {
  const VideosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth * 0.4;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: isDark ? Colors.black : theme.scaffoldBackgroundColor,
        elevation: 1,
        automaticallyImplyLeading: false,
        toolbarHeight: 40,
        title: Row(
          children: [
            Text(
              'Video',
              style: GoogleFonts.inter(
                color: theme.textTheme.titleLarge?.color ?? Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: SvgPicture.asset(
                'assets/profile_outline.svg',
                width: 30,
                height: 30,
                colorFilter: ColorFilter.mode(
                  theme.iconTheme.color ?? Colors.black,
                  BlendMode.srcIn,
                ),
              ),
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
              _sectionTitle(context, "Educational Videos", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const EducationalVideosScreen(),
                  ),
                );
              }),
              const SizedBox(height: 8),
              _videoSlider(context, cardWidth, [
                {
                  "title": "What Are Real World Assets (RWAs)?",
                  "image": "assets/thumbnail1.png",
                },
                {
                  "title": "Why Invest in RWA Tokens?",
                  "image": "assets/thumbnail2.png",
                },
              ]),
              _videoSlider(context, cardWidth, [
                {
                  "title": "How Tokenization Works",
                  "image": "assets/thumbnail2.png",
                },
                {
                  "title": "RWA vs DeFi: What's the Difference?",
                  "image": "assets/thumbnail2.png",
                },
              ]),
              const SizedBox(height: 8),

              _sectionTitle(context, "Upcoming Interviews", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const UpcomingInterviewsScreen(),
                  ),
                );
              }),
              _interviewTile(
                context,
                "Chat with Condo CEO",
                "April 21 at 5:00 PM",
                "LIVE",
              ),
              _interviewTile(
                context,
                "How RealT Fractionalizes Real Estate",
                "April 27 at 5:00 PM",
                "Scheduled",
              ),
              const SizedBox(height: 10),
              _sectionTitle(context, "Recorded Interviews", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const RecordedInterviewsScreen(),
                  ),
                );
              }),
              _recordedInterviewCard(
                context,
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

  Widget _sectionTitle(
    BuildContext context,
    String title,
    VoidCallback onSeeAll,
  ) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            title,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
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

  Widget _videoSlider(
    BuildContext context,
    double cardWidth,
    List<Map<String, String>> videos,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:
            videos.map((video) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: SizedBox(
                  width: cardWidth,
                  child: _videoCard(
                    context,
                    video['image']!,
                    video['title']!,
                    "8:20",
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }

  Widget _videoCard(
    BuildContext context,
    String imagePath,
    String title,
    String duration,
  ) {
    final theme = Theme.of(context);
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
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            "Subtitle here",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodySmall?.copyWith(
              fontSize: 10,
              fontWeight: FontWeight.w400,
              color: theme.hintColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _interviewTile(
    BuildContext context,
    String title,
    String time,
    String badge,
  ) {
    final theme = Theme.of(context);
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
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(time, style: theme.textTheme.bodySmall),
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

  Widget _recordedInterviewCard(
    BuildContext context,
    String title,
    String guest,
    String imagePath, {
    String subtitle =
        "Exclusive discussion on unlocking credit for emerging markets through real-world lending protocols.",
  }) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: theme.cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
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
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
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
                      style: theme.textTheme.bodySmall?.copyWith(height: 1.3),
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
