import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
import 'package:shared_preferences/shared_preferences.dart';

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
  List<Map<String, dynamic>> blogItems = [];
  List<Map<String, dynamic>> filteredNews = [];
  List<Map<String, dynamic>> filteredBlogs = [];

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAllData();
  }

  Future<void> fetchAllData() async {
    await Future.wait([fetchNews(), fetchBlogs()]);
    _applySearch(); // Apply initial search
    setState(() => _isLoading = false);
  }

  Future<void> fetchNews() async {
    const url =
        'https://rwa-f1623a22e3ed.herokuapp.com/api/currencies/rwa/news';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List newsList = data['news'];

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
      }
    } catch (e) {
      print('❌ Error fetching news: $e');
    }
  }

  Future<void> fetchBlogs() async {
    const url =
        'https://rwa-f1623a22e3ed.herokuapp.com/api/currencies/rwa/blog';
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token'); // Don't default to ''

      Map<String, String> headers = {};

      if (token != null && token.isNotEmpty) {
        headers['Authorization'] = 'Bearer $token';
      }

      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List blogsList = data['blog'];

        blogItems =
            blogsList.map<Map<String, dynamic>>((blog) {
              return {
                'image': blog['thumbnail'],
                'title': blog['title'],
                'subtitle': blog['subTitle'],
                'author': blog['author'],
                'time': blog['publishDate'],
                'category': blog['category'],
                'content': blog['sections'],
                'blockQuote': blog['blockQuote'],
              };
            }).toList();
      } else {
        print('❌ Failed to load blogs: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Error fetching blogs: $e');
    }
  }

  void _applySearch() {
    final query = _searchController.text.toLowerCase();
    if (query.isEmpty) {
      filteredNews = List.from(newsItems);
      filteredBlogs = List.from(blogItems);
    } else {
      filteredNews =
          newsItems.where((item) {
            final title = (item['title'] ?? '').toLowerCase();
            final subtitle = (item['subtitle'] ?? '').toLowerCase();
            final source = (item['source'] ?? '').toLowerCase();
            return title.contains(query) ||
                subtitle.contains(query) ||
                source.contains(query);
          }).toList();

      filteredBlogs =
          blogItems.where((item) {
            final title = (item['title'] ?? '').toLowerCase();
            final subtitle = (item['subtitle'] ?? '').toLowerCase();
            final author = (item['author'] ?? '').toLowerCase();
            return title.contains(query) ||
                subtitle.contains(query) ||
                author.contains(query);
          }).toList();
    }
    setState(() {}); // Update UI
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
                    onChanged: (_) => _applySearch(), // 🔥 Search live
                    onCancel: () {
                      setState(() {
                        _isSearching = false;
                        _searchController.clear();
                        _applySearch();
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
                _isLoading
                    ? const Center(
                      child: CircularProgressIndicator(color: Colors.green),
                    )
                    : _selectedTab == 0
                    ? _buildNewsList()
                    : _buildBlogsList(),
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

  Widget _buildNewsList() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      children: [
        if (filteredNews.isNotEmpty) ...[
          GestureDetector(
            onTap:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => NewsDetailScreen(news: filteredNews.first),
                  ),
                ),
            child: NewsCardMain(item: filteredNews.first),
          ),
          const SizedBox(height: 10),
          ...filteredNews
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
        ] else
          const Center(
            child: Padding(
              padding: EdgeInsets.only(top: 100),
              child: Text(
                'No news found.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildBlogsList() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      children:
          filteredBlogs.isNotEmpty
              ? filteredBlogs
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
                  .toList()
              : [
                const Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 100),
                    child: Text(
                      'No blogs found.',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                ),
              ],
    );
  }
}
