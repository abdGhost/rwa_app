import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({super.key});

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        toolbarHeight: 60,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'My Account',
          style: GoogleFonts.inter(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                const Text(
                  "Hi, Ghost",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  "Login to track your favorite coins easily.",
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),
                const SizedBox(height: 8),

                SizedBox(height: 8),
                const Text(
                  "Settings",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 6),

                // Preferences
                Container(
                  decoration: boxDecoration(),
                  child: Column(
                    children: [
                      settingTile(
                        title: "Email",
                        trailing: const Text(
                          "ghost@gmail.com",
                          style: TextStyle(color: Colors.black54, fontSize: 13),
                        ),
                      ),
                      divider(),
                      settingTile(
                        title: "Email",
                        trailing: const Text(
                          "ghost@gmail.com",
                          style: TextStyle(color: Colors.black54, fontSize: 13),
                        ),
                      ),
                      divider(),
                      settingTile(
                        title: "Subcription",
                        trailing: const Text(
                          "Free",
                          style: TextStyle(color: Colors.black54, fontSize: 13),
                        ),
                      ),
                      divider(),
                      settingTile(
                        title: "Delete Account",
                        trailing: const Text(
                          "Delete",
                          style: TextStyle(color: Colors.red, fontSize: 13),
                        ),
                      ),
                      divider(),
                    ],
                  ),
                ),

                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget settingTile({required String title, required Widget trailing}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          const Spacer(),
          trailing,
        ],
      ),
    );
  }

  Widget othersTile({required String title}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w300,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget divider() {
    return const Divider(
      height: 0,
      thickness: 0.4,
      color: Color.fromRGBO(70, 85, 104, 0.3),
    );
  }

  BoxDecoration boxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(5),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          offset: const Offset(0, .1),
          blurRadius: 1,
        ),
      ],
    );
  }
}
