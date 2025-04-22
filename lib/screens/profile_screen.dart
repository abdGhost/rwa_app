import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rwa_app/screens/my_account_screen.dart';
import 'package:rwa_app/screens/select_language_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
          'Profile',
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

                // Login + Logout buttons
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MyAccountScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF348F6C),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          minimumSize: const Size.fromHeight(
                            44,
                          ), // ✅ consistent height
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: const Text(
                          "My Account",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          minimumSize: const Size.fromHeight(
                            46,
                          ), // ✅ consistent height
                          side: const BorderSide(color: Colors.grey),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: const Text(
                          "Logout",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 8),
                const Text(
                  "Preferences",
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
                        title: "Dark Mode",
                        trailing: FlutterSwitch(
                          width: 40,
                          height: 20,
                          toggleSize: 16,
                          value: isDarkMode,
                          activeColor: const Color(0xFF348F6C),
                          inactiveColor: const Color.fromRGBO(91, 91, 91, 1),
                          toggleColor: Colors.white,
                          onToggle: (val) {
                            setState(() {
                              isDarkMode = val;
                            });
                          },
                        ),
                      ),
                      divider(),
                      settingTile(
                        title: "Currency",
                        trailing: const Text(
                          "USD",
                          style: TextStyle(color: Colors.black54, fontSize: 13),
                        ),
                      ),
                      divider(),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const SelectLanguageScreen(),
                            ),
                          );
                        },
                        child: settingTile(
                          title: "Language",
                          trailing: const Text(
                            "English",
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  "Others",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 10),

                // Others
                Container(
                  decoration: boxDecoration(),
                  child: Column(
                    children: [
                      othersTile(title: "Privacy Policy"),
                      divider(),
                      othersTile(title: "Cookie Preference"),
                      divider(),
                      othersTile(title: "Terms of Service"),
                      divider(),
                      othersTile(title: "Disclaimer"),
                      divider(),
                      othersTile(title: "Rate the RWA App"),
                      divider(),
                      othersTile(title: "Share the RWA App"),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // Social icons row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                      List.generate(
                          4,
                          (_) => _socialIcon(),
                        ).expand((e) => [e, const SizedBox(width: 8)]).toList()
                        ..removeLast(),
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

  Widget _socialIcon() {
    return Container(
      decoration: boxDecoration(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset('assets/logo.png', width: 18, height: 18),
      ),
    );
  }
}
