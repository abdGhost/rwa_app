import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:rwa_app/screens/chat_screen.dart';
import 'package:rwa_app/widgets/blogs/blog_detail_screen.dart';
import 'package:rwa_app/widgets/blogs/blogs_card.dart';
import 'package:rwa_app/widgets/news/news_appbar_title_row.dart';
import 'package:rwa_app/widgets/news/news_card_main.dart';
import 'package:rwa_app/widgets/news/news_card_side.dart';
import 'package:rwa_app/widgets/news/news_detail_screen.dart';
import 'package:rwa_app/widgets/news/news_tab_buttons.dart';
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

  List<Map<String, dynamic>> newsItems = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  Future<void> fetchNews() async {
    const url =
        'https://rwa-f1623a22e3ed.herokuapp.com/api/currencies/rwa/news';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List newsList = data['news'];

        setState(() {
          newsItems =
              newsList.map<Map<String, dynamic>>((news) {
                return {
                  'image': news['thumbnail'],
                  'title': news['title'],
                  'subtitle': news['subTitle'],
                  'source': news['author'],
                  'time': news['publishDate'],
                  'content': news['content'],
                  'quote': null,
                  'bulletPoints': [],
                };
              }).toList();
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load news');
      }
    } catch (e) {
      print('❌ Error fetching news: $e');
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: theme.appBarTheme.backgroundColor ?? theme.cardColor,
        elevation: theme.appBarTheme.elevation ?? 1,
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
            child:
                _selectedTab == 0
                    ? _buildNewsList(theme)
                    : _buildBlogsList(theme),
          ),
        ],
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

  Widget _buildNewsList(ThemeData theme) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.green),
      );
    }

    if (newsItems.isEmpty) {
      return const Center(
        child: Text(
          'No news available.',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

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

  Widget _buildBlogsList(ThemeData theme) {
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
          blogs
              .map(
                (blog) => BlogCard(
                  blog: blog,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlogDetailScreen(blog: blog),
                      ),
                    );
                  },
                ),
              )
              .toList(),
    );
  }
}
