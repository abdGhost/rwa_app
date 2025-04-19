import 'package:flutter/material.dart';
import 'package:rwa_app/widgets/blogs/blogs_card.dart';
import 'package:rwa_app/widgets/news/news_appbar_title_row.dart';
import 'package:rwa_app/widgets/news/news_tab_buttons.dart';
import 'package:rwa_app/widgets/news/news_card_main.dart';
import 'package:rwa_app/widgets/news/news_card_side.dart';
import 'package:rwa_app/widgets/search_appbar_field_widget.dart';

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
        'title': 'RWA Protocols Cross \$10B in Total Value Locked...',
        'subtitle': 'Concerns rise over regulatory risks...',
        'source': 'CryptoSlate',
        'time': '21 minutes ago',
      },
      {
        'image': 'assets/news_blogs/news_2.png',
        'title': 'China’s CPIC Launches \$100M Tokenized RWA Fund...',
        'subtitle': 'CPIC and HashKey bring institutional capital...',
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
      {
        'image': 'assets/news_blogs/news_1.png',
        'title': 'Top 5 RWA Projects You Can’t Miss in 2024',
        'subtitle': '',
        'source': 'Blockchain.News',
        'time': '2 hours ago',
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
        'subtitle': 'RWAs promise stability and yield...',
        'author': 'Alex Foster',
        'time': '7 Minutes read',
        'image': 'assets/news_blogs/news_1.png',
      },
      {
        'title': 'RWA Airdrops: The Next Big Opportunity in DeFi?',
        'subtitle': 'Token airdrops are becoming a powerful way...',
        'author': 'Vanessa Liu',
        'time': '4 Minutes read',
      },
      {
        'title': 'Real Estate on the Blockchain: A Quiet Revolution',
        'subtitle': 'Lowering investment barriers...',
        'author': 'Priya Desai',
        'time': '6 Minutes read',
        'image': 'assets/news_blogs/news_1.png',
      },
    ];

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      children: blogs.map((blog) => BlogCard(blog: blog)).toList(),
    );
  }
}
