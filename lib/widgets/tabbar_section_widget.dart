import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TabBarSection extends StatelessWidget {
  final void Function(int)? onTap;

  const TabBarSection({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: TabBar(
        onTap: onTap,
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        labelPadding: const EdgeInsets.only(right: 12),
        indicator: const UnderlineTabIndicator(
          borderSide: BorderSide(
            color: Color.fromARGB(255, 63, 167, 127),
            width: 2,
          ),
          insets: EdgeInsets.only(bottom: 10),
        ),
        indicatorSize: TabBarIndicatorSize.label,
        dividerColor: Colors.transparent,
        labelColor: Colors.black,
        unselectedLabelColor: Colors.grey,
        labelStyle: GoogleFonts.inter(
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
        unselectedLabelStyle: GoogleFonts.inter(fontSize: 13),
        tabs: const [
          Tab(text: "All Coins"),
          Tab(text: "Top Coins"),
          Tab(text: "Watchlist"),
          Tab(text: "Trending"),
          Tab(text: "Top Gainers"),
        ],
      ),
    );
  }
}
