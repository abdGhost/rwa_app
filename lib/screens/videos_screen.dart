import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rwa_app/screens/chat_screen.dart';

class VideosScreen extends StatelessWidget {
  const VideosScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
        width: 56, // Size of the button
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
              _sectionTitle("Educational Videos"),
              const SizedBox(height: 8),
              SizedBox(
                height: 160,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 2,
                  separatorBuilder:
                      (context, index) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final titles = [
                      "What Are Real World Assets (RWAs)?",
                      "Why Invest in RWA Tokens?",
                    ];
                    final images = [
                      "assets/thumbnail1.png",
                      "assets/thumbnail2.png",
                    ];
                    return SizedBox(
                      width: 160,
                      child: _videoCard(images[index], titles[index], "8:20"),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 160,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 2,
                  separatorBuilder:
                      (context, index) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final titles = [
                      "How Tokenization Works",
                      "RWA vs DeFi: What's the Difference?",
                    ];
                    final images = [
                      "assets/thumbnail2.png",
                      "assets/thumbnail2.png",
                    ];
                    return SizedBox(
                      width: 160,
                      child: _videoCard(images[index], titles[index], "8:20"),
                    );
                  },
                ),
              ),
              _sectionTitle("Upcoming Interviews"),
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
              _sectionTitle("Recorded Interviews"),
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

  static Widget _sectionTitle(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF000000),
          ),
        ),
        const Text(
          "See all",
          style: TextStyle(color: Colors.blue, fontSize: 12),
        ),
      ],
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
          Text(
            "Subtitle here",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
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
      padding: const EdgeInsets.only(top: 10, bottom: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 26,
            backgroundImage: AssetImage("assets/interview1.png"),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    height: 1.2,
                    color: Color(0xFF000000),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  time,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    height: 1.2,
                    color: Color(0xFF525252),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 8),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: badge == "LIVE" ? Colors.red : Colors.grey,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              badge,
              textAlign: TextAlign.center,
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
      margin: const EdgeInsets.only(bottom: 8, top: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(33, 236, 236, 236).withValues(),
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
                bottomRight: Radius.circular(8),
                topRight: Radius.circular(8),
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
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
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
