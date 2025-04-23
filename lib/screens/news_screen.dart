import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rwa_app/screens/chat_screen.dart';
import 'package:rwa_app/widgets/blogs/blog_detail_screen.dart';
import 'package:rwa_app/widgets/blogs/blogs_card.dart';
import 'package:rwa_app/widgets/news/news_appbar_title_row.dart';
import 'package:rwa_app/widgets/news/news_detail_screen.dart';
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

  Widget _buildNewsList() {
    final newsItems = [
      {
        'image': 'assets/news_blogs/news_1.png',
        'title': 'RWA Protocols Cross \$10B in Total Value Locked...',
        'subtitle': 'Concerns rise over regulatory risks...',
        'source': 'CryptoSlate',
        'time': 'April 27, 2025 10:12 PM',
        'content':
            '''The total value locked (TVL) in RWA protocols has crossed the \$10B milestone...

"Tokenized RWAs are now a foundational layer in DeFi," said James Walton.''',
        'quote': 'Tokenized RWAs are now a foundational layer in DeFi.',
        'bulletPoints': [
          'Regulatory risks are rising.',
          'Liquidity concerns are real.',
          'Some platforms lack investor protection.',
        ],
      },
      {
        'image': 'assets/news_blogs/news_2.png',
        'title': 'China’s CPIC Launches \$100M Tokenized RWA Fund...',
        'subtitle': 'CPIC and HashKey bring institutional capital...',
        'source': 'CoinDesk',
        'time': 'April 12, 2025 10:12 PM',
        'content':
            '''The \$100M fund will tokenize assets like real estate, bonds, and infrastructure...

HashKey will provide custody and compliance.''',
        'quote': 'Tokenization is the future of financial assets.',
        'bulletPoints': [],
      },
    ];

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      children: [
        GestureDetector(
          onTap:
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => NewsDetailScreen(news: newsItems.first),
                ),
              ),
          child: NewsCardMain(item: newsItems.first),
        ),
        const SizedBox(height: 10),
        ...newsItems
            .skip(1)
            .map(
              (item) => NewsCardSide(
                item: item,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => NewsDetailScreen(news: item),
                    ),
                  );
                },
              ),
            ),
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
        'content':
            '''RWAs bring stability but off-chain enforcement is still weak.

Analysts warn that investor protection is lacking.''',
        'quote': 'RWAs are only as strong as their legal enforcement.',
        'bulletPoints': [
          'Legal clarity is lacking.',
          'Insurance coverage is inconsistent.',
        ],
      },
      {
        'title': 'RWA Airdrops: The Next Big Opportunity in DeFi?',
        'subtitle': 'Token airdrops are becoming a powerful tool...',
        'author': 'Vanessa Liu',
        'time': '4 Minutes read',
        'image': '',
        'content':
            '''Major RWA protocols are planning token airdrops to boost participation.''',
        'quote': null,
        'bulletPoints': [],
      },
    ];

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      children:
          blogs.map((blog) {
            return BlogCard(
              blog: blog,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlogDetailScreen(blog: blog),
                  ),
                );
              },
            );
          }).toList(),
    );
  }
}
