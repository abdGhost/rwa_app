import 'package:flutter/material.dart';
import 'package:rwa_app/screens/login_screen.dart';
import 'package:rwa_app/theme/theme.dart';
import 'package:rwa_app/widgets/social_auth_widget.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor =
        Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;
    final primaryColor = Theme.of(context).primaryColor;
    final cardColor = Theme.of(context).cardColor;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            // Main content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    isDark ? 'assets/onboarding.png' : 'assets/onboarding.png',
                    width: 240,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'The most Trusted app for\nReal World Assets',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: textColor.withOpacity(0.7),
                      fontSize: 14,
                      letterSpacing: 0.3,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 60),

                  // Email Button
                  SocialAuthButton(
                    label: 'Continue with Email & Password',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                      );
                    },
                    backgroundColor: AppColors.primaryDark,
                    textColor: Colors.white,
                  ),

                  const SizedBox(height: 20),

                  // Divider
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(width: 40, child: Divider(thickness: 0.5)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          "OR",
                          style: TextStyle(
                            color: textColor.withOpacity(0.3),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const SizedBox(width: 40, child: Divider(thickness: 0.5)),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Google Button
                  SocialAuthButton(
                    label: 'Continue with Google',
                    iconPath: 'assets/google-icon.png',
                    onPressed: () {},
                    textColor: textColor,
                  ),

                  const SizedBox(height: 12),

                  // Apple Button
                  SocialAuthButton(
                    label: 'Continue with Apple',
                    iconPath: 'assets/apple-icon.png',
                    onPressed: () {},
                    textColor: textColor,
                  ),

                  const SizedBox(height: 20),

                  // Terms and Privacy
                  Text.rich(
                    TextSpan(
                      text: 'By proceeding, you agree to RWA CAMP’s ',
                      style: TextStyle(fontSize: 10, color: textColor),
                      children: [
                        TextSpan(
                          text: 'Terms of Service',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            decorationColor: primaryColor,
                            decorationThickness: 1.5,
                            color: primaryColor,
                          ),
                        ),
                        const TextSpan(text: ' and '),
                        TextSpan(
                          text: 'Privacy Policy',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            decorationColor: primaryColor,
                            decorationThickness: 1.5,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            // Skip Button
            Positioned(
              top: 16,
              right: 16,
              child: TextButton(
                onPressed: () {
                  // Handle skip logic
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Skip',
                      style: TextStyle(
                        fontSize: 14,
                        color: textColor.withOpacity(0.6),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16,
                      color: textColor.withOpacity(0.6),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
