import 'package:flutter/material.dart';
import 'package:socialmedia_clone/model/friend.dart';
import '../model/userdata.dart';

// ignore: must_be_immutable
class Friendlist extends StatelessWidget {
  Friendlist({super.key, required this.userdata});

  final Userdata userdata;

  final headerStyle = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  // Each friend (circle avatar + name, Instagram style)
  Widget friend(Friend friend) => Column(
    children: [
      Container(
        padding: const EdgeInsets.all(2), // thin border like Instagram
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey.shade300, width: 1.5),
        ),
        child: CircleAvatar(
          backgroundImage: AssetImage(friend.img),
          radius: 35,
        ),
      ),
      const SizedBox(height: 6),
      SizedBox(
        width: 80,
        child: Text(
          friend.name,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 12),
        ),
      ),
    ],
  );

  // Grid of friends (like Instagram followers preview)
  Widget friendListGrid() => GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      mainAxisExtent: 120,
    ),
    itemCount: userdata.friendList.length > 9
        ? 9 // show only 9 like IG preview
        : userdata.friendList.length,
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
              Row(
                children: [
                  Text('Friends', style: headerStyle),
                  const SizedBox(width: 6),
                  Text(
                    '${userdata.friendList.length}',
                    style: const TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  // TODO: Navigate to full friend list page
                },
                child: const Text(
                  'See all',
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Friends grid preview
        SizedBox(height: 280, child: friendListGrid()),

        const Divider(color: Colors.grey, height: 1),
      ],
    );
  }
}
