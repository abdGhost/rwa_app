import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rwa_app/provider/settings_provider.dart';
import 'package:rwa_app/screens/my_account_screen.dart';
import 'package:rwa_app/screens/select_language_screen.dart';
import 'package:rwa_app/screens/login_screen.dart'; // 👈 Import LoginScreen to redirect

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isDarkMode = ref.watch(themeModeProvider) == ThemeMode.dark;
    final selectedCurrency = ref.watch(currencyProvider);
    final selectedLanguage = ref.watch(languageProvider);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: theme.appBarTheme.elevation,
        automaticallyImplyLeading: false,
        toolbarHeight: 60,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.iconTheme.color),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Profile',
          style: GoogleFonts.inter(
            color: theme.textTheme.titleLarge?.color,
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
                Text(
                  "Hi, Ghost", // (optionally replace with actual user name)
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "Login to track your favorite coins easily.",
                  style: theme.textTheme.bodySmall,
                ),
                const SizedBox(height: 8),
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
                          minimumSize: const Size.fromHeight(44),
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
                        onPressed: () => _logout(context),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: theme.cardColor,
                          foregroundColor: theme.textTheme.bodyLarge?.color,
                          minimumSize: const Size.fromHeight(46),
                          side: BorderSide(color: theme.dividerColor),
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
                const SizedBox(height: 8),
                Text(
                  "Preferences",
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  decoration: boxDecoration(theme),
                  child: Column(
                    children: [
                      settingTile(
                        context,
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
                            ref.read(themeModeProvider.notifier).toggle(val);
                          },
                        ),
                      ),
                      divider(theme),
                      settingTile(
                        context,
                        title: "Currency",
                        trailing: Text(
                          selectedCurrency,
                          style: theme.textTheme.bodySmall,
                        ),
                      ),
                      divider(theme),
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
                          context,
                          title: "Language",
                          trailing: Text(
                            selectedLanguage,
                            style: theme.textTheme.bodySmall,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Others",
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: boxDecoration(theme),
                  child: Column(
                    children: [
                      othersTile(title: "Privacy Policy", theme: theme),
                      divider(theme),
                      othersTile(title: "Cookie Preference", theme: theme),
                      divider(theme),
                      othersTile(title: "Terms of Service", theme: theme),
                      divider(theme),
                      othersTile(title: "Disclaimer", theme: theme),
                      divider(theme),
                      othersTile(title: "Rate the RWA App", theme: theme),
                      divider(theme),
                      othersTile(title: "Share the RWA App", theme: theme),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                      List.generate(
                          4,
                          (_) => _socialIcon(theme),
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

  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // ✅ Clear all saved user data

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  Widget settingTile(
    BuildContext context, {
    required String title,
    required Widget trailing,
  }) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Text(
            title,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          trailing,
        ],
      ),
    );
  }

  Widget othersTile({required String title, required ThemeData theme}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(title, style: theme.textTheme.bodySmall),
      ),
    );
  }

  Widget divider(ThemeData theme) {
    return Divider(height: 0, thickness: 0.2, color: theme.dividerColor);
  }

  BoxDecoration boxDecoration(ThemeData theme) {
    return BoxDecoration(
      color: theme.cardColor,
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

  Widget _socialIcon(ThemeData theme) {
    return Container(
      decoration: boxDecoration(theme),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset('assets/logo.png', width: 18, height: 18),
      ),
    );
  }
}
