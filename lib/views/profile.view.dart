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

  // text styles
  final nametxtStyle = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
  final boldtxtStyle = const TextStyle(fontWeight: FontWeight.bold);
  final boldtxtStyle1 = const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );

  // buttons for each comment
  Widget commentBtn(Usercomment usercomment) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    child: Row(
      children: [
        Text(usercomment.commentTime),
        const SizedBox(width: 15),
        const Text('Like'),
        const SizedBox(width: 15),
        const Text('Reply'),
      ],
    ),
  );

  // comment description
  Widget commentDesc(Usercomment usercomment) => Padding(
    padding: const EdgeInsets.all(10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(usercomment.commenterName, style: boldtxtStyle),
        const SizedBox(height: 5),
        Text(usercomment.commentContent),
      ],
    ),
  );

  // comment container
  Widget commentSpace(Usercomment usercomment) => Container(
    decoration: const BoxDecoration(
      color: Color.fromARGB(35, 158, 158, 158),
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
    child: commentDesc(usercomment),
  );

  // commenter profile pic
  Widget commenterPic(Usercomment usercomment) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: CircleAvatar(
      backgroundImage: AssetImage(usercomment.commenterImg),
      radius: 20,
    ),
  );

  // layout for each comment
  Widget usercommenterline(Usercomment usercomment) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      commenterPic(usercomment),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [commentSpace(usercomment), commentBtn(usercomment)],
      ),
    ],
  );

  Widget userpostdetails(Usercomment usercomment) => Padding(
    padding: const EdgeInsets.only(top: 15),
    child: usercommenterline(usercomment),
  );

  // post stats & commenters section
  Widget commenters(Userpost userpost) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Divider(color: Colors.grey),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            const SizedBox(width: 15),
            Text(userpost.numshare, style: boldtxtStyle),
          ],
        ),
      ),
    ],
  );

  // buttons for post
  Widget buttons(Userpost userpost) => Column(
    children: [
      const Divider(color: Colors.grey),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              style: TextButton.styleFrom(
                foregroundColor: (userpost.isliked) ? Colors.blue : Colors.grey,
              ),
              onPressed: () {},
              icon: const Icon(Icons.thumb_up, size: 20),
              label: const Text('Like'),
            ),
            TextButton.icon(
              style: TextButton.styleFrom(foregroundColor: Colors.grey),
              onPressed: () {
                setState(() {
                  _showCommentBox = !_showCommentBox;
                });
              },
              icon: const Icon(Icons.comment, size: 20),
              label: const Text('Comment'),
            ),
            TextButton.icon(
              style: TextButton.styleFrom(foregroundColor: Colors.grey),
              onPressed: () {},
              icon: const Icon(Icons.share, size: 20),
              label: const Text('Share'),
            ),
          ],
        ),
      ),
      const Divider(color: Colors.grey),
    ],
  );

  // user info line
  Widget userline(Userpost userpost) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: CircleAvatar(
          backgroundImage: AssetImage(userpost.userimg),
          radius: 25,
        ),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(userpost.username, style: nametxtStyle),
          const SizedBox(height: 5),
          Row(
            children: [
              Text(userpost.time),
              const SizedBox(width: 5),
              const Icon(Icons.group, size: 15, color: Colors.grey),
            ],
          ),
        ],
      ),
    ],
  );

  // post content + image
  Widget postimage(Userpost userpost) => Padding(
    padding: const EdgeInsets.all(10.0),
    child: Column(
      children: [
        Row(children: [Text(userpost.postcontent)]),
        const SizedBox(height: 15),
        Container(
          height: 350,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(userpost.postimg),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    ),
  );

  // comment input box
  Widget commentInputBox() => _showCommentBox
      ? Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _commentController,
                  decoration: const InputDecoration(
                    hintText: "Write a comment...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10,
                    ),
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
                          commenterName: "You",
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          userline(widget.userPost),
          postimage(widget.userPost),
          buttons(widget.userPost),
          commentInputBox(),
          commenters(widget.userPost),
          Column(
            children: userdata.commentList
                .map((userComment) => userpostdetails(userComment))
                .toList(),
          ),
        ],
      ),
    );
  }
}
