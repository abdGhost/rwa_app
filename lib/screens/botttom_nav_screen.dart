import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rwa_app/screens/airdrop_screen.dart';
import 'package:rwa_app/screens/home_screen.dart';
import 'package:rwa_app/screens/news_screen.dart';
import 'package:rwa_app/screens/portfolio_screen.dart';
import 'package:rwa_app/screens/videos_screen.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomeScreen(),
    NewsScreen(),
    AirdropScreen(),
    PortfolioScreen(),
    VideosScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: theme.primaryColor,
        unselectedItemColor: isDark ? Colors.white60 : const Color(0xFF818181),
        backgroundColor:
            theme.bottomNavigationBarTheme.backgroundColor ??
            theme.scaffoldBackgroundColor,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: const TextStyle(fontSize: 12),
        onTap: (index) => setState(() => _selectedIndex = index),
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              _selectedIndex == 0
                  ? 'assets/market_fill.svg'
                  : 'assets/market_outline.svg',
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                _selectedIndex == 0
                    ? theme.primaryColor
                    : (isDark ? Colors.white60 : const Color(0xFF818181)),
                BlendMode.srcIn,
              ),
            ),
            label: 'Market',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              _selectedIndex == 1
                  ? 'assets/news_fill.svg'
                  : 'assets/news_outline.svg',
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                _selectedIndex == 1
                    ? theme.primaryColor
                    : (isDark ? Colors.white60 : const Color(0xFF818181)),
                BlendMode.srcIn,
              ),
            ),
            label: 'News',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              _selectedIndex == 2
                  ? 'assets/airdrop_fill.svg'
                  : 'assets/airdrop_outline.svg',
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                _selectedIndex == 2
                    ? theme.primaryColor
                    : (isDark ? Colors.white60 : const Color(0xFF818181)),
                BlendMode.srcIn,
              ),
            ),
            label: 'Airdrop',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              _selectedIndex == 3
                  ? 'assets/portfolio_fill.svg'
                  : 'assets/portfolio_outline.svg',
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                _selectedIndex == 3
                    ? theme.primaryColor
                    : (isDark ? Colors.white60 : const Color(0xFF818181)),
                BlendMode.srcIn,
              ),
            ),
            label: 'Portfolio',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              _selectedIndex == 4
                  ? 'assets/video_fill.svg'
                  : 'assets/video_outline.svg',
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                _selectedIndex == 4
                    ? theme.primaryColor
                    : (isDark ? Colors.white60 : const Color(0xFF818181)),
                BlendMode.srcIn,
              ),
            ),
            label: 'Video',
          ),
        ],
      ),
    );
  }
}
