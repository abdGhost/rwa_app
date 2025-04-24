import 'package:flutter/material.dart';
import 'package:rwa_app/screens/botttom_nav_screen.dart';
import 'package:rwa_app/screens/signup_screen.dart';
import 'package:rwa_app/theme/theme.dart';
import 'package:rwa_app/widgets/auth_divider_widget.dart';
import 'package:rwa_app/widgets/custom_textfield_widget.dart';
import 'package:rwa_app/widgets/social_auth_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            isDark ? Colors.black : theme.appBarTheme.backgroundColor,
        elevation: isDark ? 0 : theme.appBarTheme.elevation ?? 1,
        iconTheme: theme.appBarTheme.iconTheme,
        title: Text(
          'Login',
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Google
              SocialAuthButton(
                label: 'Continue with Google',
                iconPath: 'assets/google-icon.png',
                onPressed: () {},
                textColor: isDark ? Colors.white : const Color(0xFF1D1D1D),
              ),
              const SizedBox(height: 12),

              /// Apple
              SocialAuthButton(
                label: 'Continue with Apple',
                iconPath: 'assets/apple-icon.png',
                onPressed: () {},
                textColor: isDark ? Colors.white : const Color(0xFF1D1D1D),
              ),

              const SizedBox(height: 20),
              const AuthDivider(),
              const SizedBox(height: 20),

              Text(
                'Email Address',
                style: textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              CustomTextField(
                hint: 'example@gmail.com',
                borderColor: isDark ? Colors.white : Colors.black12,
                borderWidth: 0.6,
              ),

              const SizedBox(height: 16),
              Text(
                'Password',
                style: textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              CustomTextField(
                hint: 'Enter your password',
                obscure: _obscurePassword,
                borderColor: isDark ? Colors.white : Colors.black12,
                borderWidth: 0.6,
                suffix: IconButton(
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    size: 20,
                    color: Colors.grey,
                  ),
                ),
              ),

              const SizedBox(height: 4),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    'Forget Password?',
                    style: textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryLight,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              /// Login Button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryLight,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const BottomNavScreen(),
                      ),
                    );
                  },
                  child: const Text('Log In'),
                ),
              ),

              const SizedBox(height: 12),
              Row(
                children: [
                  Text("Don't have an Account? ", style: textTheme.bodySmall),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const SignupScreen()),
                      );
                    },
                    child: Text(
                      'SIGNUP',
                      style: textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryLight,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.primaryLight,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
