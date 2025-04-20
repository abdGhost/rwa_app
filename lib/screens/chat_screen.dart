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
      backgroundColor: Colors.white,
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
              const Text(
                "Quick Questions",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              ..._quickReplies.map(
                (text) => ListTile(
                  title: Text(text),
                  onTap: () {
                    Navigator.pop(context);
                    Future.delayed(const Duration(milliseconds: 100), () {
                      FocusManager.instance.primaryFocus?.unfocus();
                    });
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
    final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(247, 247, 247, 1),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          automaticallyImplyLeading: false,
          toolbarHeight: 60,
          title: Text(
            'RWA ChatBot',
            style: GoogleFonts.inter(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.flash_on, color: Colors.green),
              tooltip: "Quick Questions",
              onPressed: _showQuickQuestionsSheet,
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Column(
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
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment:
                                isUser
                                    ? MainAxisAlignment.end
                                    : MainAxisAlignment.start,
                            children: [
                              if (!isUser) ...[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: msg['color'],
                                          radius: 14,
                                          child: Text(
                                            msg['sender'][0],
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          msg['sender'],
                                          style: TextStyle(
                                            color: msg['color'],
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 20,
                                        right: 40,
                                      ),
                                      child: _chatBubble(
                                        msg['text'],
                                        false,
                                        screenWidth,
                                        msg['time'],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                              if (isUser) ...[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      children: const [
                                        Text(
                                          "You",
                                          style: TextStyle(
                                            color: Colors.blueAccent,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                        SizedBox(width: 6),
                                        CircleAvatar(
                                          backgroundColor: Colors.blueAccent,
                                          radius: 14,
                                          child: Icon(
                                            Icons.person,
                                            size: 16,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 40,
                                        right: 20,
                                      ),
                                      child: _chatBubble(
                                        msg['text'],
                                        true,
                                        screenWidth,
                                        msg['time'],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ],
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
                            child: Icon(
                              Icons.smart_toy,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: const AnimatedDots(),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),

            // Input field
            if (_showInput)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                color: const Color.fromRGBO(247, 247, 247, 1),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        cursorColor: Colors.green,
                        style: const TextStyle(color: Colors.green),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Type your message...",
                          hintStyle: const TextStyle(
                            color: Color.fromARGB(255, 155, 155, 155),
                            fontSize: 12,
                          ),
                          suffixIcon: IconButton(
                            onPressed: _sendMessage,
                            icon: const Icon(Icons.send, color: Colors.green),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 0,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(color: Colors.green),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                              color: Colors.green,
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
      ),
    );
  }

  Widget _chatBubble(String text, bool isUser, double width, String time) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: width * 0.75),
      child: Container(
        margin: const EdgeInsets.only(top: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: const TextStyle(
                color: Color.fromRGBO(23, 20, 15, 1),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              time,
              style: const TextStyle(fontSize: 10, color: Colors.grey),
            ),
          ],
        ),
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
          style: const TextStyle(fontSize: 12, color: Colors.grey),
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
