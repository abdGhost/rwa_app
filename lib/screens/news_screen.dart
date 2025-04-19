import 'package:flutter/material.dart';
import 'package:rwa_app/widgets/search_appbar_field_widget.dart';
import 'package:rwa_app/widgets/news/news_appbar_title_row.dart';
import 'package:rwa_app/widgets/news/news_tab_buttons.dart';
import 'package:rwa_app/widgets/news/news_card_main.dart';
import 'package:rwa_app/widgets/news/news_card_side.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  bool _isSearching = false;
  int _selectedTab = 0;
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(247, 247, 247, 1),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 1,
        toolbarHeight: 60,
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child:
              _isSearching
                  ? SearchAppBarField(
                    controller: _searchController,
                    onCancel: () {
                      setState(() {
                        _isSearching = false;
                        _searchController.clear();
                      });
                    },
                  )
                  : NewsAppBarTitleRow(
                    onSearchTap: () => setState(() => _isSearching = true),
                  ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 4),
          NewsTabButtons(
            selectedTab: _selectedTab,
            onTabSelected: (index) {
              setState(() {
                _selectedTab = index;
              });
            },
          ),
          const SizedBox(height: 6),
          Expanded(
            child: _selectedTab == 0 ? _buildNewsList() : _buildBlogsList(),
          ),
        ],
      ),
    );
  }

  Widget _buildNewsList() {
    final newsItems = [
      {
        'image': 'assets/news_blogs/news_1.png',
        'title':
            'RWA Protocols Cross \$10B in Total Value Locked - Rise over regulatory risks, liquidity, and inves',
        'subtitle':
            'Concerns rise over regulatory risks, liquidity, and investor protection. Rise over regulatory risks, liquidity, and inves,Rise over regulatory risks, liquidity, and inves',
        'source': 'CryptoSlate',
        'time': '21 minutes ago',
      },
      {
        'image': 'assets/news_blogs/news_2.png',
        'title': 'China’s CPIC Launches \$100M Tokenized RWA Fund with HashKey',
        'subtitle': 'CPIC and HashKey bring institutional capital to RWA.',
        'source': 'CoinDesk',
        'time': '42 minutes ago',
      },
      {
        'image': 'assets/news_blogs/news_1.png',
        'title': 'Top RWA Projects by Development Activity',
        'subtitle': '',
        'source': 'Blockchain.News',
        'time': '1 hour ago',
      },
      {
        'image': 'assets/news_blogs/news_1.png',
        'title': 'Top 5 RWA Projects You Can’t Miss in 2024',
        'subtitle': '',
        'source': 'Blockchain.News',
        'time': '2 hours ago',
      },
    ];

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      children: [
        NewsCardMain(item: newsItems.first),
        const SizedBox(height: 10),
        ...newsItems.skip(1).map((item) => NewsCardSide(item: item)),
      ],
    );
  }

  Widget _buildBlogsList() {
    final blogs = [
      {
        'title': 'The Hidden Risks in RWA Protocols You Need to Know',
        'author': 'Alex Foster',
        'time': '7 Minutes read',
      },
      {
        'title': 'RWA Airdrops: The Next Big Opportunity in DeFi?',
        'author': 'Vanessa Liu',
        'time': '4 Minutes read',
      },
      {
        'title': 'Real Estate on the Blockchain: A Quiet Revolution',
        'author': 'Priya Desai',
        'time': '6 Minutes read',
      },
    ];

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      children:
          blogs
              .map(
                (blog) => _blogCard(
                  title: blog['title']!,
                  author: blog['author']!,
                  time: blog['time']!,
                ),
              )
              .toList(),
    );
  }

  Widget _blogCard({
    required String title,
    required String author,
    required String time,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
            ),
            const SizedBox(height: 6),
            Text(
              '$author · $time',
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
