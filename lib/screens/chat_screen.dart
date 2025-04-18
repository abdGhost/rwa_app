import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromRGBO(247, 247, 247, 1),
      body: Center(
        child: Text(
          "🏠 Chat",
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}
