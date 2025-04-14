import 'package:flutter/material.dart';
import 'package:rwa_app/widgets/social_auth_widget.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/onboarding.png', width: 240),
              const SizedBox(height: 8),
              const Text(
                'The most Trusted app for\nReal World Assets',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(129, 129, 129, 70), // 70% opacity
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
                  // Navigate to Login
                },
                backgroundColor: const Color(0xFF348F6C),
                textColor: Colors.white,
                // borderColor: Colors.grey,
                iconPath: null,
              ),

              const SizedBox(height: 20),

              // Divider
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  SizedBox(
                    width: 40,
                    child: Divider(
                      color: Color.fromRGBO(0, 0, 0, .2),
                      thickness: .5,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      "OR",
                      style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, .2),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 40,
                    child: Divider(
                      color: Color.fromRGBO(0, 0, 0, .2),
                      thickness: .5,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Google Button
              SocialAuthButton(
                label: 'Continue with Google',
                iconPath: 'assets/google-icon.png',
                onPressed: () {},
                textColor: Color.fromRGBO(29, 29, 29, 1),
              ),

              const SizedBox(height: 12),

              // Apple Button
              SocialAuthButton(
                label: 'Continue with Apple',
                iconPath: 'assets/apple-icon.png',
                onPressed: () {},
                textColor: Color.fromRGBO(29, 29, 29, 1),
              ),

              const SizedBox(height: 20),

              // Terms and Privacy
              const Text.rich(
                TextSpan(
                  text: 'By proceeding, you agree to RWA CAMP’s ',
                  style: TextStyle(
                    fontSize: 10,
                    color: Color.fromRGBO(29, 29, 29, 1),
                  ),
                  children: [
                    TextSpan(
                      text: 'Terms of Service',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationColor: Color(0xFF348F6C),
                        decorationThickness: 1.5,
                        color: Color(0xFF348F6C),
                      ),
                    ),
                    TextSpan(text: ' and '),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationColor: Color(0xFF348F6C),
                        decorationThickness: 1.5,
                        color: Color(0xFF348F6C),
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
