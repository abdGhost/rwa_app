// custom_text_field.dart
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final bool obscure;
  final Widget? suffix;

  const CustomTextField({
    super.key,
    required this.hint,
    this.obscure = false,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: TextField(
        obscureText: obscure,
        cursorColor: const Color(0xFF348F6C),
        cursorHeight: 20,
        cursorWidth: 1,
        style: const TextStyle(color: Colors.grey, fontSize: 14),
        decoration: InputDecoration(
          hintText: hint,
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 14,
          ),
          suffixIcon: suffix,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF348F6C), width: 1),
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black12),
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
        ),
      ),
    );
  }
}
