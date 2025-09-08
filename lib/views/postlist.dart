import 'package:flutter/material.dart';
import 'package:socialmedia_clone/views/profile.view.dart';
import '../model/userdata.dart';
import '../model/userpost.dart';

class Postlist extends StatefulWidget {
  const Postlist({super.key, required this.userdata});

  final Userdata userdata;

  @override
  State<Postlist> createState() => _PostlistState();
}

class _PostlistState extends State<Postlist> {
  var nameTxtStyle = const TextStyle(fontSize: 16, fontWeight: FontWeight.bold);

  gotoPage(BuildContext context, dynamic page) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
  }

  // Favorite toggle
  void toggleFavorite(Userpost userpost) {
    setState(() {
      userpost.isFavorited = !userpost.isFavorited;
    });
  }

  // Show comment input dialog
  void showCommentDialog(Userpost userpost) {
    TextEditingController commentCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add a comment"),
        content: TextField(
          controller: commentCtrl,
          decoration: const InputDecoration(hintText: "Write a comment..."),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              if (commentCtrl.text.trim().isNotEmpty) {
                setState(() {
                  userpost.comments.add(commentCtrl.text.trim());
                });
              }
              Navigator.pop(context);
            },
            child: const Text("Post"),
          ),
        ],
      ),
    );
  }

  // Instagram-style action buttons
  Widget buttons(Userpost userpost) => Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      // Like
      IconButton(
        icon: Icon(
          userpost.isliked ? Icons.favorite : Icons.favorite_border,
          color: userpost.isliked ? Colors.red : Colors.black,
        ),
        onPressed: () {
          setState(() {
            userpost.isliked = !userpost.isliked;
            userpost.isliked ? userpost.numlikes++ : userpost.numlikes--;
          });
        },
      ),

      // Comment
      IconButton(
        icon: const Icon(Icons.chat_bubble_outline),
        onPressed: () => showCommentDialog(userpost),
      ),

      // Share (just placeholder)
      IconButton(icon: const Icon(Icons.send_outlined), onPressed: () {}),

      const Spacer(),

      // Favorite (Bookmark)
      IconButton(
        icon: Icon(
          userpost.isFavorited ? Icons.bookmark : Icons.bookmark_border,
          color: userpost.isFavorited ? Colors.blue : Colors.black,
        ),
        onPressed: () => toggleFavorite(userpost),
      ),
    ],
  );

  // Likes text
  Widget likes(Userpost userpost) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12),
    child: Align(
      alignment: Alignment.centerLeft,
      child: Text(
        "${userpost.numlikes} likes",
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
  );

  // Show comments
  Widget showComments(Userpost userpost) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var c in userpost.comments.take(2))
          Text(c, style: const TextStyle(color: Colors.black)),
        if (userpost.comments.length > 2)
          Text(
            "View all ${userpost.numcomments.length} comments",
            style: const TextStyle(color: Colors.grey),
          ),
      ],
    ),
  );

  // Caption with username
  Widget caption(Userpost userpost) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
    child: RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "${userpost.username} ",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          TextSpan(
            text: userpost.postcontent,
            style: const TextStyle(color: Colors.black),
          ),
        ],
      ),
    ),
  );

  // Time ago
  Widget timeAgo(Userpost userpost) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
    child: Text(
      userpost.time,
      style: const TextStyle(color: Colors.grey, fontSize: 12),
    ),
  );

  // Post image
  Widget postImage(Userpost userpost) => Container(
    height: 400,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage(userpost.postimg),
        fit: BoxFit.cover,
      ),
    ),
  );

  // Post header
  Widget postHeader(Userpost userpost) => ListTile(
    leading: CircleAvatar(
      radius: 20,
      backgroundImage: AssetImage(userpost.userimg),
    ),
    title: Text(userpost.username, style: nameTxtStyle),
    trailing: const Icon(Icons.more_vert),
    onTap: () {
      gotoPage(context, ProfileView(userPost: userpost));
    },
  );

  // Show Instagram-style post
  Widget showPost(Userpost userpost) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      postHeader(userpost),
      postImage(userpost),
      buttons(userpost),
      likes(userpost),
      caption(userpost),
      showComments(userpost),
      timeAgo(userpost),
      const SizedBox(height: 12),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.userdata.userList.length,
      itemBuilder: (context, index) {
        final userpost = widget.userdata.userList[index];
        return showPost(userpost);
      },
    );
  }
}
