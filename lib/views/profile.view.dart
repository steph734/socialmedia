import 'package:flutter/material.dart';
import '../model/userdata.dart';
import '../model/userpost.dart';
import '../model/usercomment.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key, required this.userPost});
  final Userpost userPost;

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final Userdata userdata = Userdata();
  final TextEditingController _commentController = TextEditingController();
  bool _showCommentBox = false;

  final nametxtStyle = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  // Post header
  Widget postHeader(Userpost post) => ListTile(
    leading: CircleAvatar(backgroundImage: AssetImage(post.userimg)),
    title: Text(post.username, style: nametxtStyle),
    subtitle: Text(post.time, style: const TextStyle(fontSize: 12)),
    trailing: const Icon(Icons.more_vert),
  );

  // Post image (double tap to like)
  Widget postImage(Userpost post) => GestureDetector(
    onDoubleTap: () {
      setState(() {
        // Only the current user can like/unlike
        if (!post.isliked) {
          post.isliked = true;
          post.numlikes =
              (int.parse(post.numlikes as String) + 1).toString() as int;
        }
      });
    },
    child: Image.asset(
      post.postimg,
      width: double.infinity,
      height: 400,
      fit: BoxFit.cover,
    ),
  );

  // Action buttons (heart, comment, share, bookmark)
  Widget actionButtons(Userpost post) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
              icon: Icon(
                post.isliked ? Icons.favorite : Icons.favorite_border,
                color: post.isliked ? Colors.red : Colors.black,
              ),
              onPressed: () {
                setState(() {
                  // Toggle only for the current user
                  if (post.isliked) {
                    post.isliked = false;
                    post.numlikes =
                        (int.parse(post.numlikes as String) - 1).toString()
                            as int;
                  } else {
                    post.isliked = true;
                    post.numlikes =
                        (int.parse(post.numlikes as String) + 1).toString()
                            as int;
                  }
                });
              },
            ),
            IconButton(
              icon: const Icon(Icons.comment_outlined),
              onPressed: () {
                setState(() {
                  _showCommentBox = !_showCommentBox;
                });
              },
            ),
            IconButton(icon: const Icon(Icons.send_outlined), onPressed: () {}),
          ],
        ),
        IconButton(icon: const Icon(Icons.bookmark_border), onPressed: () {}),
      ],
    ),
  );

  // Likes count
  Widget likes(Userpost post) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Text(
      "${post.numlikes} likes",
      style: const TextStyle(fontWeight: FontWeight.bold),
    ),
  );

  // Caption
  Widget caption(Userpost post) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
    child: RichText(
      text: TextSpan(
        style: const TextStyle(color: Colors.black),
        children: [
          TextSpan(
            text: "${post.username} ",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(text: post.postcontent),
        ],
      ),
    ),
  );

  // Comment input
  Widget commentInputBox() => _showCommentBox
      ? Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _commentController,
                  decoration: const InputDecoration(
                    hintText: "Add a comment...",
                    border: InputBorder.none,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send, color: Colors.blue),
                onPressed: () {
                  if (_commentController.text.trim().isNotEmpty) {
                    setState(() {
                      userdata.commentList.add(
                        Usercomment(
                          commenterName: "Maricel Joy Alajar",
                          commenterImg: "assets/images/default_user.png",
                          commentContent: _commentController.text.trim(),
                          commentTime: "Just now",
                          commentPost: '',
                        ),
                      );
                      _commentController.clear();
                      _showCommentBox = false;
                    });
                  }
                },
              ),
            ],
          ),
        )
      : const SizedBox();

  // Render single comment
  Widget commentRow(Usercomment comment) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundImage: AssetImage(comment.commenterImg),
          radius: 15,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  style: const TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                      text: "${comment.commenterName} ",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: comment.commentContent),
                  ],
                ),
              ),
              const SizedBox(height: 2),
              Text(
                comment.commentTime,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Post"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: ListView(
        children: [
          postHeader(widget.userPost),
          postImage(widget.userPost),
          actionButtons(widget.userPost),
          likes(widget.userPost),
          caption(widget.userPost),
          commentInputBox(),
          const Divider(),
          Column(
            children: userdata.commentList
                .map((comment) => commentRow(comment))
                .toList(),
          ),
        ],
      ),
    );
  }
}
