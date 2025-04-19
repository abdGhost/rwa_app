import 'package:flutter/material.dart';

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
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Center(
              child: Image.asset(
                'assets/airdrop_banner.png',
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8),

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
                        ),
                      );
                    }).toList(),
              ),
            ),

            const SizedBox(height: 4),

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
                              ),
                            );
                          },
                        ),
              ),
            ),
          ],
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

  const FilterTab({
    super.key,
    required this.text,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF1CB379) : Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: const Color(0xFF1CB379)),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: isActive ? Colors.white : const Color(0xFF1CB379),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

// 🪂 Airdrop Card Widget
class AirdropCard extends StatelessWidget {
  final String project;
  final String token;
  final String chain;
  final String reward;
  final String date;
  final String eligibility;
  final String status;

  const AirdropCard({
    super.key,
    required this.project,
    required this.token,
    required this.chain,
    required this.reward,
    required this.date,
    required this.eligibility,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final bool isLive = status == "Live";
    final bool isEnded = status == "Ended";

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title + Status
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("🎯 ", style: TextStyle(fontSize: 18)),
              Expanded(
                child: Text(
                  project,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color:
                      isLive
                          ? const Color(0xFFDFFBEA)
                          : isEnded
                          ? const Color(0xFFFEE9E9)
                          : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    Icon(
                      isLive ? Icons.check_circle : Icons.cancel,
                      size: 14,
                      color: isLive ? const Color(0xFF1CB379) : Colors.red,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      status,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: isLive ? const Color(0xFF1CB379) : Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            "Token: $token  |  Chain: $chain",
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          Text.rich(
            TextSpan(
              children: [
                const TextSpan(
                  text: "🎁 Reward: ",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: reward,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 4),
          Text(
            "🗓️ $date",
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          Text.rich(
            TextSpan(
              children: [
                const TextSpan(
                  text: "✅ Eligibility: ",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: eligibility,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "🔍 View Details",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(48, 96, 184, 1),
                ),
              ),
              Text(
                "⏰ Set Reminder",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
