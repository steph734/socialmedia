import 'package:flutter/material.dart';
import '../model/friend.dart'; // assuming you have a Friend model

class FollowingListView extends StatelessWidget {
  final List<Friend> following;

  const FollowingListView({super.key, required this.following});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Following"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: following.length,
        itemBuilder: (context, index) {
          final friend = following[index];
          return ListTile(
            leading: CircleAvatar(backgroundImage: AssetImage(friend.img)),
            title: Text(friend.name),
            subtitle: Text(friend.username),
          );
        },
      ),
    );
  }
}
