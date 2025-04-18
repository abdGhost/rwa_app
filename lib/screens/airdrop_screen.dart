import 'package:flutter/material.dart';

class AirdropScreen extends StatefulWidget {
  const AirdropScreen({super.key});

  @override
  State<AirdropScreen> createState() => _AirdropScreenState();
}

class _AirdropScreenState extends State<AirdropScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromRGBO(247, 247, 247, 1),
      body: Center(
        child: Text(
          "🏠 Airdrop",
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}
