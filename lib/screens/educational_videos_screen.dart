import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EducationalVideosScreen extends StatelessWidget {
  const EducationalVideosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final titles = [
      "What Are Real World Assets (RWAs)?",
      "Why Invest in RWA Tokens?",
      "How Tokenization Works",
      "RWA vs DeFi: What's the Difference?",
    ];

    final subtitles = [
      "An easy-to-understand introduction to RWAs, how they work, and their benefits.",
      "Learn why investors are turning to RWAs for stability, yield, and real value.",
      "A step-by-step breakdown of how RWAs are converted into digital tokens.",
      "Explore the key differences and overlaps between Real World Assets and DeFi.",
    ];

    final images = [
      "assets/thumbnail1.png",
      "assets/thumbnail2.png",
      "assets/thumbnail2.png",
      "assets/thumbnail1.png",
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F7F7),
        elevation: 0,
        toolbarHeight: 50,
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          'Educational Videos',
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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        images[index],
                        width: 140,
                        height: 90,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              titles[index],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                height: 1.1,
                                color: Color(0xFF000000),
                              ),
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            Icons.more_vert,
                            size: 20,
                            color: Colors.grey[700],
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitles[index],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF818181),
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        "CryptoHub",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF818181),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: const [
                          Text(
                            "563 Views",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF818181),
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            "2 days ago",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF818181),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
