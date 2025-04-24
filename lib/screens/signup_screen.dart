import 'package:flutter/material.dart';
import 'package:rwa_app/screens/setting_screen.dart';
import 'package:rwa_app/theme/theme.dart';
import 'package:rwa_app/widgets/auth_divider_widget.dart';
import 'package:rwa_app/widgets/back_title_appbar_widget.dart';
import 'package:rwa_app/widgets/custom_textfield_widget.dart';
import 'package:rwa_app/widgets/social_auth_widget.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final isDark = theme.brightness == Brightness.dark;

    final borderColor = isDark ? Colors.white : Colors.black12;

    return Scaffold(
      appBar: const BackTitleAppBar(title: 'Signup'),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SocialAuthButton(
                label: 'Continue with Google',
                iconPath: 'assets/google-icon.png',
                onPressed: () {},
                textColor: isDark ? Colors.white : const Color(0xFF1D1D1D),
              ),
              const SizedBox(height: 12),
              SocialAuthButton(
                label: 'Continue with Apple',
                iconPath:
                    isDark ? 'assets/apple-icon.png' : 'assets/apple-icon.png',
                onPressed: () {},
                textColor: isDark ? Colors.white : const Color(0xFF1D1D1D),
              ),
              const SizedBox(height: 20),
              const AuthDivider(),
              const SizedBox(height: 20),

              _label("Email Address", textTheme),
              const SizedBox(height: 2),
              CustomTextField(
                hint: 'example@gmail.com',
                borderColor: borderColor,
                borderWidth: 0.6,
              ),

              const SizedBox(height: 14),
              _label("Username", textTheme),
              const SizedBox(height: 2),
              CustomTextField(
                hint: 'Username',
                borderColor: borderColor,
                borderWidth: 0.6,
              ),

              const SizedBox(height: 14),
              _label("Password", textTheme),
              const SizedBox(height: 2),
              CustomTextField(
                hint: 'Enter your password',
                obscure: _obscurePassword,
                borderColor: borderColor,
                borderWidth: 0.6,
                suffix: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    size: 20,
                    color: borderColor,
                  ),
                  onPressed:
                      () =>
                          setState(() => _obscurePassword = !_obscurePassword),
                ),
              ),

              const SizedBox(height: 14),
              _label("Confirm Password", textTheme),
              const SizedBox(height: 2),
              CustomTextField(
                hint: 'Confirm Password',
                obscure: _obscureConfirmPassword,
                borderColor: borderColor,
                borderWidth: 0.6,
                suffix: IconButton(
                  icon: Icon(
                    _obscureConfirmPassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                    size: 20,
                    color: borderColor,
                  ),
                  onPressed:
                      () => setState(
                        () =>
                            _obscureConfirmPassword = !_obscureConfirmPassword,
                      ),
                ),
              ),

              const SizedBox(height: 30),

              /// Sign Up Button
              SizedBox(
                height: 48,
                width: double.infinity,
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
                      MaterialPageRoute(builder: (_) => const SettingsScreen()),
                    );
                  },
                  child: const Text('Sign Up'),
                ),
              ),

              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Already have an account? ", style: textTheme.bodySmall),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Text(
                      'LOGIN',
                      style: textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                        color: AppColors.primaryLight,
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

  Widget _label(String text, TextTheme textTheme) {
    return Text(
      text,
      style: textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500),
    );
  }
}
