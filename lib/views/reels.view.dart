import 'package:flutter/material.dart';

class ReelsView extends StatelessWidget {
  final List<String> reels = [
    "assets/videos/reel1.mp4",
    "assets/videos/reel2.mp4",
    "assets/videos/reel3.mp4",
  ];

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.vertical,
      itemCount: reels.length,
      itemBuilder: (context, index) {
        return Stack(
          fit: StackFit.expand,
          children: [
            // placeholder for video
            Container(
              color: Colors.black,
              child: Center(
                child: Text(
                  "Reel ${index + 1}",
                  style: const TextStyle(color: Colors.white, fontSize: 22),
                ),
              ),
            ),
            Positioned(
              right: 16,
              bottom: 80,
              child: Column(
                children: const [
                  Icon(Icons.favorite, color: Colors.white, size: 32),
                  SizedBox(height: 12),
                  Icon(Icons.comment, color: Colors.white, size: 32),
                  SizedBox(height: 12),
                  Icon(Icons.share, color: Colors.white, size: 32),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
