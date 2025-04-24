import 'package:flutter/material.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const OnboardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final textTheme = Theme.of(context).textTheme;
    final isDark = brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              isDark ? 'assets/splash-screen.png' : 'assets/splash-screen.png',
              width: 150,
              height: 150,
              fit: BoxFit.contain,
            ),
            // const SizedBox(height: 16),
            // Text(
            //   'Loading RWA CAMP...',
            //   style: textTheme.bodyMedium?.copyWith(
            //     fontWeight: FontWeight.w500,
            //     fontSize: 14,
            //   ),
            // ),
            const SizedBox(height: 12),
            CircularProgressIndicator(
              strokeWidth: 2.5,
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFF348F6C), // App green
              ),
            ),
          ],
        ),
      ),
    );
  }
}
