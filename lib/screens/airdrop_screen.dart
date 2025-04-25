import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rwa_app/screens/chat_screen.dart';
import 'package:rwa_app/widgets/airdrop/airdrop_card.dart';

class AirdropScreen extends StatefulWidget {
  const AirdropScreen({super.key});

  @override
  State<AirdropScreen> createState() => _AirdropScreenState();
}

class _AirdropScreenState extends State<AirdropScreen> {
  String _selectedTab = "Recently Added";

  final List<Map<String, String>> allAirdrops = [
    {
      'project': "Chainlink Airdrop",
      'token': "LINK",
      'chain': "ETH",
      'reward': "2000 LINK",
      'date': "March 15 – March 30, 2025",
      'eligibility': "Hold ≥ 0.5 ETH by March 28",
      'status': "Live",
      'category': "Live",
    },
    {
      'project': "Maple Airdrop",
      'token': "MPL",
      'chain': "ETH & SOL",
      'reward': "30,000 MPL",
      'date': "March 01 – March 10, 2025",
      'eligibility': "Hold ≥ 0.2 ETH & MPL by March 08",
      'status': "Ended",
      'category': "Ended",
    },
    {
      'project': "XYZ Free Airdrop",
      'token': "XYZ",
      'chain': "BNB",
      'reward': "Free Mint",
      'date': "April 01 – April 15, 2025",
      'eligibility': "Sign up required",
      'status': "Live",
      'category': "Free",
    },
  ];

  final List<String> tabs = [
    "Recently Added",
    "Upcoming",
    "Live",
    "Ended",
    "Free",
  ];

  List<Map<String, String>> get filteredAirdrops {
    if (_selectedTab == "Recently Added") return allAirdrops;
    return allAirdrops
        .where((drop) => drop['category'] == _selectedTab)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : const Color(0xFFF7F7F7),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            Center(
              child: Image.asset(
                'assets/airdrop.gif',
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 12),

            // Scrollable Filter Tabs
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children:
                    tabs.map((tab) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: FilterTab(
                          text: tab,
                          isActive: _selectedTab == tab,
                          onTap: () {
                            setState(() {
                              _selectedTab = tab;
                            });
                          },
                          isDarkMode: isDark, // Pass dark mode flag
                        ),
                      );
                    }).toList(),
              ),
            ),

            const SizedBox(height: 10),

            // Scrollable Card Section
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child:
                    filteredAirdrops.isEmpty
                        ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.air, size: 40, color: Colors.grey),
                              SizedBox(height: 10),
                              Text(
                                'No airdrop available',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        )
                        : ListView.builder(
                          itemCount: filteredAirdrops.length,
                          itemBuilder: (context, index) {
                            final airdrop = filteredAirdrops[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: AirdropCard(
                                project: airdrop['project']!,
                                token: airdrop['token']!,
                                chain: airdrop['chain']!,
                                reward: airdrop['reward']!,
                                date: airdrop['date']!,
                                eligibility: airdrop['eligibility']!,
                                status: airdrop['status']!,
                                isDarkMode: isDark, // Pass dark mode flag
                              ),
                            );
                          },
                        ),
              ),
            ),
          ],
        ),
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
    );
  }
}

// 🔘 Filter Tab Widget
class FilterTab extends StatelessWidget {
  final String text;
  final bool isActive;
  final VoidCallback onTap;
  final bool isDarkMode; // To handle dark mode

  const FilterTab({
    super.key,
    required this.text,
    required this.isActive,
    required this.onTap,
    required this.isDarkMode, // Dark mode flag
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        isDarkMode
            ? (isActive
                ? const Color(0xFF348F6C) // Dark mode active color
                : const Color(0xFF2A2A2A)) // Dark mode inactive color
            : (isActive
                ? const Color(0xFF348F6C) // Light mode active color
                : const Color(0xFFF1F1F1)); // Light mode inactive color

    final textColor =
        isDarkMode
            ? (isActive
                ? Colors
                    .white // Dark mode active text
                : Colors.grey[400]!) // Dark mode inactive text
            : (isActive
                ? const Color(0xFF1CB379) // Light mode active text
                : const Color(0xFF888888)); // Light mode inactive text

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color:
                isActive
                    ? const Color.fromRGBO(52, 143, 108, 0.3)
                    : const Color.fromRGBO(
                      0,
                      0,
                      0,
                      0.1,
                    ), // Thin border for unselected
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: textColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
