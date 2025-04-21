import 'package:flutter/material.dart';

class VideosScreen extends StatelessWidget {
  const VideosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF348F6C),
        child: const Icon(Icons.chat),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Videos",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF000000),
                    ),
                  ),
                  Icon(Icons.more_vert),
                ],
              ),
              const SizedBox(height: 20),

              // Section: Educational Videos
              _sectionTitle("Educational Videos"),
              const SizedBox(height: 8),
              GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: .9,
                children: [
                  _videoCard(
                    "assets/thumbnail1.png",
                    "What Are Real World Assets (RWAs)?",
                    "8:20",
                  ),
                  _videoCard(
                    "assets/thumbnail2.png",
                    "Why Invest in RWA Tokens?",
                    "8:20",
                  ),
                  _videoCard(
                    "assets/thumbnail2.png",
                    "How Tokenization Works",
                    "8:20",
                  ),
                  _videoCard(
                    "assets/thumbnail2.png",
                    "RWA vs DeFi: What's the Difference?",
                    "8:20",
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Section: Upcoming Interviews
              _sectionTitle("Upcoming Interviews"),
              const SizedBox(height: 4),
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

              const SizedBox(height: 24),

              // Section: Recorded Interviews
              _sectionTitle("Recorded Interviews"),
              const SizedBox(height: 8),
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
              color: Color(0XFF000000),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w400,
              color: Color(0XFF818181),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _interviewTile(String title, String time, String badge) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Profile Image
          const CircleAvatar(
            radius: 26,
            backgroundImage: AssetImage("assets/interview1.png"),
          ),
          const SizedBox(width: 10),

          // Text Content
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2, // ✅ Allow 2 lines max
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    height: 1.2, // ✅ Adjust line height
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

          // Badge Button
          Container(
            margin: const EdgeInsets.only(left: 8),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            // constraints: const BoxConstraints(
            //   minWidth: 70, // ✅ Ensures all badges are same width
            //   minHeight: 26,
            // ),
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
    String imagePath,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              imagePath,
              width: 100,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Color(0xFF000000),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  guest,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF818181),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
