import 'package:flutter/material.dart';

class GlowingStoryCircle extends StatelessWidget {
  final String image;
  final String title;
  final VoidCallback onTap;

  const GlowingStoryCircle({
    super.key,
    required this.image,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(3), // glowing border
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF833AB4), // purple
                  Color(0xFFF77737), // orange
                  Color(0xFFE1306C), // pink
                  Color(0xFFFCAF45), // yellow
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.pinkAccent.withOpacity(0.6),
                  blurRadius: 15,
                  spreadRadius: 3,
                ),
              ],
            ),
            child: CircleAvatar(radius: 35, backgroundImage: AssetImage(image)),
          ),
        ),
        const SizedBox(height: 6),
        Text(title, style: const TextStyle(color: Colors.white, fontSize: 12)),
      ],
    );
  }
}
