import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:rwa_app/screens/airdrop_details_screen.dart';
import 'package:rwa_app/screens/chat_screen.dart';
import 'package:rwa_app/widgets/airdrop/airdrop_card.dart';

class AirdropScreen extends StatefulWidget {
  const AirdropScreen({super.key});

  @override
  State<AirdropScreen> createState() => _AirdropScreenState();
}

class _AirdropScreenState extends State<AirdropScreen> {
  String _selectedTab = "Recently Added";
  bool _isLoading = true;

  List<Map<String, String>> airdrops = [];

  final List<String> tabs = ["Recently Added", "Live", "Ended", "Free"];

  @override
  void initState() {
    super.initState();
    fetchAirdrops();
  }

  Future<void> fetchAirdrops() async {
    final url = Uri.parse(
      'https://airdrop-production-61b7.up.railway.app/api/get/allAirdrop',
    );
    try {
      final response = await http.get(url);
      final data = json.decode(response.body);
      final List fetched = data["data"];

      setState(() {
        airdrops =
            fetched.map<Map<String, String>>((item) {
              DateTime start = DateTime.parse(item['airdropStart']);
              DateTime end = DateTime.parse(item['airdropEnd']);
              bool isLive =
                  DateTime.now().isAfter(start) && DateTime.now().isBefore(end);
              bool isEnded = DateTime.now().isAfter(end);

              String category =
                  isLive
                      ? "Live"
                      : isEnded
                      ? "Ended"
                      : "Free";

              return {
                'project': item['tokenName'].trim(),
                'token': item['tokenTicker'],
                'chain': item['chain'],
                'reward': item['airdropAmt'],
                'image': item['image'],
                'description': item['tokenDescription'],
                'date':
                    "${DateFormat('MMMM dd').format(start)} – ${DateFormat('MMMM dd, yyyy').format(end)}",
                'eligibility': item['airdropEligibility'],
                'status':
                    isLive
                        ? "Live"
                        : isEnded
                        ? "Ended"
                        : "Upcoming",
                'category': category,
              };
            }).toList();
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('Error fetching airdrops: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  List<Map<String, String>> get filteredAirdrops {
    if (_selectedTab == "Recently Added") return airdrops;
    return airdrops.where((drop) => drop['category'] == _selectedTab).toList();
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
                'assets/airdrop.png',
                width: double.infinity,
                height: 210,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 12),
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
                          isDarkMode: isDark,
                        ),
                      );
                    }).toList(),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child:
                  _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child:
                            filteredAirdrops.isEmpty
                                ? Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(
                                        Icons.air,
                                        size: 40,
                                        color: Colors.grey,
                                      ),
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
                                        isDarkMode: isDark,
                                        image: airdrop['image'] ?? '',
                                        description:
                                            airdrop['tokenDescription'] ?? '',
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder:
                                                  (_) => AirdropDetailScreen(
                                                    airdrop: airdrop,
                                                  ),
                                            ),
                                          );
                                        },
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
    );
  }
}

class FilterTab extends StatelessWidget {
  final String text;
  final bool isActive;
  final VoidCallback onTap;
  final bool isDarkMode;

  const FilterTab({
    super.key,
    required this.text,
    required this.isActive,
    required this.onTap,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        isDarkMode
            ? (isActive ? const Color(0xFF348F6C) : const Color(0xFF2A2A2A))
            : (isActive ? const Color(0xFF348F6C) : const Color(0xFFF1F1F1));

    final textColor =
        isDarkMode
            ? (isActive ? Colors.white : Colors.grey[400]!)
            : (isActive ? const Color(0xFF1CB379) : const Color(0xFF888888));

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
                    : const Color.fromRGBO(0, 0, 0, 0.1),
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
