import 'package:flutter/material.dart';
import 'package:socialmedia_clone/model/friend.dart';
import '../model/userdata.dart';

// ignore: must_be_immutable
class Friendlist extends StatelessWidget {
  Friendlist({super.key, required this.userdata});

  final Userdata userdata;

  final headerStyle = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  // each friend (avatar + name)
  Widget friend(Friend friend) => Column(
    children: [
      CircleAvatar(backgroundImage: AssetImage(friend.img), radius: 40),
      const SizedBox(height: 5),
      Text(
        friend.name,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontSize: 13),
      ),
    ],
  );

  // grid of friends (3 per row, like Instagram highlights/followers preview)
  Widget friendListGrid() => GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      mainAxisExtent: 120,
    ),
    itemCount: userdata.friendList.length,
    itemBuilder: (BuildContext ctx, index) {
      return friend(userdata.friendList[index]);
    },
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Friends header row
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Friends', style: headerStyle),
              Text(
                '${userdata.friendList.length}',
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),

        // Friends grid preview
        SizedBox(height: 280, child: friendListGrid()),

        const Divider(color: Colors.grey),
      ],
    );
  }
}
