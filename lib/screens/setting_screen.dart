import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:rwa_app/screens/botttom_nav_screen.dart';
import 'package:rwa_app/screens/select_language_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(247, 247, 247, 1),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              const Text(
                "Just one last thing",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                "Set up your preferred theme, currency, language and you’re good to go",
                style: TextStyle(fontSize: 12, color: Colors.black54),
              ),
              const SizedBox(height: 24),
              const Text(
                "App setting",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),

              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08), // Subtle shadow
                      offset: const Offset(0, 4), // Only bottom
                      blurRadius: 4,
                      spreadRadius: 0,
                    ),
                  ],
                ),
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
                            builder: (context) => const SelectLanguageScreen(),
                          ),
                        );
                      },

                      child: settingTile(
                        title: "Language",
                        trailing: const Text(
                          "English",
                          style: TextStyle(color: Colors.black54, fontSize: 13),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),
              const Center(
                child: Text(
                  "You can always change or customise these settings later",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 11, color: Colors.black45),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BottomNavScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF348F6C),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: const Text(
                    "Finish",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
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
  // rgba(70, 85, 104, 0.3)

  Widget divider() {
    return Divider(
      height: 0,
      color: Color.fromRGBO(70, 85, 104, 0.3),
      thickness: 0.4,
    );
  }
}
