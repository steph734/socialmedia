import 'package:flutter/material.dart';
import '../model/friend.dart'; // reuse the Friend model

class FollowersListView extends StatelessWidget {
  final List<Friend> followers;

  const FollowersListView({super.key, required this.followers});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Followers"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: followers.length,
        itemBuilder: (context, index) {
          final friend = followers[index];
          return ListTile(
            leading: CircleAvatar(backgroundImage: AssetImage(friend.img)),
            title: Text(friend.name),
            subtitle: Text("@${friend.username}"),
          );
        },
      ),
    );
  }
}
