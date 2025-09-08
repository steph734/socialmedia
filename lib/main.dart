import 'package:flutter/material.dart';
import 'package:socialmedia_clone/views/featuredstory.view.dart';
import 'package:socialmedia_clone/views/login.dart';
import 'package:socialmedia_clone/views/register.dart';
import 'package:socialmedia_clone/views/glowing_story_circle.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Social Media Clone',
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => const Login(),
        '/home': (context) => const HomeScreen(), // 👈 new home screen
        '/register': (context) => const Register(),
      },
    );
  }
}

/// 👇 New Home Screen with Instagram-like glowing featured stories
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Featured Stories"),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GlowingStoryCircle(
              image: "assets/images/story1.jpg",
              title: "Beach",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FeaturedStoryView(
                      title: "Beach",
                      images: [
                        "assets/images/story1.jpg",
                        "assets/images/story2.jpg",
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(width: 16),
            GlowingStoryCircle(
              image: "assets/images/story3.jpg",
              title: "Trip",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FeaturedStoryView(
                      title: "Trip",
                      images: [
                        "assets/images/story3.jpg",
                        "assets/images/story4.jpg",
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
