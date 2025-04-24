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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor ?? theme.cardColor,
        elevation: 1,
        toolbarHeight: 60,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.iconTheme.color),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'My Account',
          style: GoogleFonts.inter(
            color: theme.textTheme.titleLarge?.color ?? Colors.black,
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
                  "Hi, Ghost",
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color:
                        isDark
                            ? Colors.white
                            : Colors
                                .black, // Ensuring text visibility in dark mode
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "Login to track your favorite coins easily.",
                  style: theme.textTheme.bodySmall?.copyWith(
                    color:
                        isDark
                            ? Colors.white70
                            : Colors
                                .black54, // Text color adjustment for dark mode
                  ),
                ),
                const SizedBox(height: 8),
                const SizedBox(height: 8),
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
                  decoration: boxDecoration(theme),
                  child: Column(
                    children: [
                      settingTile(
                        title: "Email",
                        trailing: Text(
                          "ghost@gmail.com",
                          style: TextStyle(
                            color: theme.textTheme.bodySmall?.color,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      divider(theme),
                      settingTile(
                        title: "Subscription",
                        trailing: Text(
                          "Free",
                          style: TextStyle(
                            color: theme.textTheme.bodySmall?.color,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      divider(theme),
                      settingTile(
                        title: "Delete Account",
                        trailing: Text(
                          "Delete",
                          style: TextStyle(color: Colors.red, fontSize: 13),
                        ),
                      ),
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
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Text(
            title,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color:
                  theme.textTheme.bodyMedium?.color ??
                  Colors.black, // Ensure text is visible in both modes
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
        child: Text(
          title,
          style: theme.textTheme.bodySmall?.copyWith(
            color:
                theme.textTheme.bodySmall?.color ??
                Colors
                    .black, // Ensure left-aligned text is visible in dark mode
          ),
        ),
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
}
