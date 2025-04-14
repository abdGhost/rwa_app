import 'package:flutter/material.dart';
import 'package:rwa_app/widgets/auth_divider_widget.dart';
import 'package:rwa_app/widgets/back_title_appbar_widget.dart';
import 'package:rwa_app/widgets/custom_textfield_widget.dart';
import 'package:rwa_app/widgets/social_auth_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BackTitleAppBar(title: 'Login'),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              SocialAuthButton(
                label: 'Continue with Google',
                iconPath: 'assets/google-icon.png',
                onPressed: () {},
                textColor: const Color.fromRGBO(29, 29, 29, 1),
              ),

              const SizedBox(height: 12),

              SocialAuthButton(
                label: 'Continue with Apple',
                iconPath: 'assets/apple-icon.png',
                onPressed: () {},
                textColor: const Color.fromRGBO(29, 29, 29, 1),
              ),

              const SizedBox(height: 20),
              const AuthDivider(),
              const SizedBox(height: 20),

              const Text(
                'Email Address',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              const CustomTextField(hint: 'example@gmail.com'),

              const SizedBox(height: 16),
              const Text(
                'Password',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              const CustomTextField(
                hint: 'Enter your password',
                obscure: true,
                suffix: Padding(
                  padding: EdgeInsets.only(right: 12),
                  child: Icon(Icons.visibility, size: 20),
                ),
              ),
              const SizedBox(height: 4),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size(0, 0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Forget Password?',
                    style: TextStyle(
                      color: Color(0xFF348F6C),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),
              SizedBox(
                height: 48,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF348F6C),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Log In',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    "Don't have an Account? ",
                    style: TextStyle(fontSize: 12),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      'SIGNUP',
                      style: TextStyle(
                        decorationThickness: 1,
                        decoration: TextDecoration.underline,
                        decorationColor: Color(0xFF348F6C),
                        fontSize: 12,
                        color: Color(0xFF348F6C),
                        fontWeight: FontWeight.w600,
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
