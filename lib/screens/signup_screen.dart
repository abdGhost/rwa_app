import 'package:flutter/material.dart';
import 'package:rwa_app/api/api_service.dart';
import 'package:rwa_app/controllers/signup_controller.dart';
import 'package:rwa_app/models/signup_response_model.dart';
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
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;

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
                iconPath: 'assets/apple-icon.png',
                onPressed: () {},
                textColor: isDark ? Colors.white : const Color(0xFF1D1D1D),
              ),
              const SizedBox(height: 20),
              const AuthDivider(),
              const SizedBox(height: 20),

              _label("Email Address", textTheme),
              const SizedBox(height: 2),
              CustomTextField(
                controller: _emailController,
                hint: 'example@gmail.com',
                borderColor: borderColor,
                borderWidth: 0.6,
              ),

              const SizedBox(height: 14),
              _label("Username", textTheme),
              const SizedBox(height: 2),
              CustomTextField(
                controller: _usernameController,
                hint: 'Username',
                borderColor: borderColor,
                borderWidth: 0.6,
              ),

              const SizedBox(height: 14),
              _label("Password", textTheme),
              const SizedBox(height: 2),
              CustomTextField(
                controller: _passwordController,
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
                controller: _confirmPasswordController,
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
                  onPressed: _isLoading ? null : _onSignupPressed,
                  child:
                      _isLoading
                          ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                          : const Text('Sign Up'),
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

  Future<void> _onSignupPressed() async {
    final email = _emailController.text.trim();
    final username = _usernameController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (email.isEmpty ||
        username.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      _showSnackBar("Please fill in all fields");
      return;
    }

    if (password != confirmPassword) {
      _showSnackBar("Passwords do not match");
      return;
    }

    setState(() => _isLoading = true);

    try {
      final result = await SignupController().handleSignup(
        context,
        email: email,
        username: username,
        password: password,
        confirmPassword: confirmPassword,
      );

      if (result.status) {
        _showSnackBar(result.message); // Success message
      } else {
        _showSnackBar(
          result.message,
        ); // Backend error message (like "Email already exist!")
      }
    } catch (e) {
      // Attempt to decode the error response if it's a server error
      final errorMessage = _extractErrorMessage(e.toString());
      _showSnackBar(errorMessage);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  String _extractErrorMessage(String error) {
    // Try to extract the backend message from Exception text
    try {
      final match = RegExp(r'"message"\s*:\s*"([^"]+)"').firstMatch(error);
      if (match != null) {
        return match.group(1) ?? "Something went wrong";
      }
    } catch (_) {}
    return "Something went wrong";
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}
