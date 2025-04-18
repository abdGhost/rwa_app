import 'package:flutter/material.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromRGBO(247, 247, 247, 1),
      body: Center(
        child: Text(
          "🏠 News",
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}
