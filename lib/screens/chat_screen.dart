import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final List<Map<String, dynamic>> _messages = [
    {
      "sender": "AI",
      "text":
          "Hi there! 👋 I'm your RWA AI assistant. Ask me anything or choose a quick option below.",
      "time": "10:20 AM",
      "isUser": false,
      "color": Colors.green,
    },
  ];

  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isTyping = false;
  bool _showInput = true;

  final List<String> _quickReplies = [
    "What are RWAs?",
    "Give me examples of RWAs.",
    "Why are RWAs trending?",
    "Tell me about Centrifuge.",
    "How do I invest in RWAs?",
  ];

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _sendMessage({String? textOverride}) {
    final text = textOverride ?? _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add({
        "sender": "You",
        "text": text,
        "time": TimeOfDay.now().format(context),
        "isUser": true,
        "color": Colors.blueAccent,
      });
      _isTyping = true;
      _showInput = false;
    });

    _scrollToBottom();

    if (textOverride == null) _controller.clear();

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _messages.add({
          "sender": "AI",
          "text": _generateBotReply(text),
          "time": TimeOfDay.now().format(context),
          "isUser": false,
          "color": Colors.green,
        });
        _isTyping = false;
        _showInput = true;
      });
      _scrollToBottom();
    });
  }

  String _generateBotReply(String input) {
    final lower = input.toLowerCase();
    if (lower.contains("rwa")) {
      return "RWAs (Real World Assets) are tokenized versions of real-world items like real estate, invoices, and precious metals.";
    } else if (lower.contains("example")) {
      return "Examples of RWAs include PAX Gold (PAXG), real estate tokens, and invoice-backed tokens via Centrifuge.";
    } else if (lower.contains("centrifuge")) {
      return "Centrifuge is a DeFi protocol that brings real-world assets like invoices and mortgages onto the blockchain.";
    } else if (lower.contains("invest")) {
      return "You can invest in RWAs through platforms like Goldfinch, Maple Finance, or RealT, depending on asset type.";
    } else if (lower.contains("trending")) {
      return "RWAs are trending because they bridge traditional finance with DeFi, offering yield and stability.";
    } else {
      return "That's interesting! Ask me anything about RWAs, or select a quick question below.";
    }
  }

  void _showQuickQuestionsSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Quick Questions",
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              ..._quickReplies.map(
                (text) => ListTile(
                  title: Text(text),
                  onTap: () {
                    Navigator.pop(context);
                    _sendMessage(textOverride: text);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor ?? theme.cardColor,
        elevation: 1,
        automaticallyImplyLeading: false,
        title: Text(
          'RWA ChatBot',
          style: GoogleFonts.inter(
            color: theme.textTheme.titleLarge?.color,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.flash_on, color: Color(0xFF16C784)),
            tooltip: "Quick Questions",
            onPressed: _showQuickQuestionsSheet,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(12),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                final isUser = msg['isUser'] == true;

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Align(
                    alignment:
                        isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment:
                          isUser
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (!isUser)
                              CircleAvatar(
                                radius: 14,
                                backgroundColor: msg['color'],
                                child: const Icon(
                                  Icons.smart_toy,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
                            if (!isUser) const SizedBox(width: 6),
                            if (!isUser)
                              Text(
                                msg['sender'],
                                style: TextStyle(
                                  color: msg['color'],
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                            if (isUser)
                              Text(
                                "You",
                                style: TextStyle(
                                  color: msg['color'],
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                            if (isUser) const SizedBox(width: 6),
                            if (isUser)
                              CircleAvatar(
                                radius: 14,
                                backgroundColor: msg['color'],
                                child: const Icon(
                                  Icons.person,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Container(
                          margin: EdgeInsets.only(
                            left: isUser ? 40 : 0,
                            right: isUser ? 0 : 40,
                          ),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: theme.cardColor,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                msg['text'],
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                msg['time'],
                                style: TextStyle(
                                  fontSize: 10,
                                  color: theme.textTheme.bodySmall?.color
                                      ?.withOpacity(0.5),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          if (_isTyping)
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 6, 20, 20),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 14,
                    backgroundColor: Colors.green,
                    child: Icon(Icons.smart_toy, size: 16, color: Colors.white),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: theme.cardColor,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const AnimatedDots(),
                  ),
                ],
              ),
            ),
          if (_showInput)
            Container(
              color: theme.scaffoldBackgroundColor,
              padding: const EdgeInsets.fromLTRB(8, 4, 8, 12),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      cursorColor: const Color(0xFF16C784),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.textTheme.bodyLarge?.color,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: theme.cardColor,
                        hintText: "Type your message...",
                        hintStyle: TextStyle(
                          color: theme.hintColor.withOpacity(
                            isDark ? 0.6 : 0.9,
                          ),
                          fontSize: 12,
                        ),
                        suffixIcon: IconButton(
                          onPressed: _sendMessage,
                          icon: const Icon(
                            Icons.send,
                            color: Color(0xFF16C784),
                            size: 20,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 0,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: theme.dividerColor,
                            width: 0.8,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: theme.dividerColor,
                            width: 0.4,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Color(0xFF16C784),
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class AnimatedDots extends StatefulWidget {
  const AnimatedDots({super.key});

  @override
  State<AnimatedDots> createState() => _AnimatedDotsState();
}

class _AnimatedDotsState extends State<AnimatedDots>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<int> _dotCount;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    )..repeat();

    _dotCount = StepTween(begin: 1, end: 3).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _dotCount,
      builder: (_, __) {
        return Text(
          "AI is typing${'.' * _dotCount.value}",
          style: TextStyle(
            fontSize: 12,
            color: Theme.of(context).textTheme.bodySmall?.color,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
