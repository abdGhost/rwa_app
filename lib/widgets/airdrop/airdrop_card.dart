import 'package:flutter/material.dart';

class AirdropCard extends StatelessWidget {
  final String project;
  final String token;
  final String chain;
  final String reward;
  final String date;
  final String eligibility;
  final String status;

  const AirdropCard({
    super.key,
    required this.project,
    required this.token,
    required this.chain,
    required this.reward,
    required this.date,
    required this.eligibility,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final bool isLive = status == "Live";
    final bool isEnded = status == "Ended";

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // 🟩 Card
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFF7F7F7)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("🎯 ", style: TextStyle(fontSize: 18)),
                  Expanded(
                    child: Text(
                      project,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                "Token: $token  |  Chain: $chain",
                style: const TextStyle(fontSize: 14, color: Colors.black),
              ),
              const SizedBox(height: 4),
              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: "🎁 Reward: ",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: reward,
                      style: const TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "🗓️ $date",
                style: const TextStyle(fontSize: 14, color: Colors.black),
              ),
              const SizedBox(height: 4),
              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: "✅ Eligibility: ",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: eligibility,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
              ),

              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "🔍 View Details",
                    style: TextStyle(
                      fontSize: 14,
                      color: Color.fromRGBO(48, 96, 184, 1),
                    ),
                  ),
                  Text(
                    "⏰ Set Reminder",
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
        ),

        // 🟥 Positioned Status Badge (touching outer edge)
        Positioned(
          top: 14,
          right: 0, // Stick to outer right
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              bottomLeft: Radius.circular(30),
            ),
            child: Container(
              color:
                  isLive
                      ? const Color(0xFFDFFBEA)
                      : isEnded
                      ? const Color(0xFFFEE9E9)
                      : Colors.grey.shade200,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isLive ? Icons.check_circle : Icons.cancel,
                    size: 14,
                    color: isLive ? const Color(0xFF1CB379) : Colors.red,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    status,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: isLive ? const Color(0xFF1CB379) : Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
