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

//list of posts
class _PostlistState extends State<Postlist> {
  var nameTxtStyle = const TextStyle(fontSize: 16, fontWeight: FontWeight.bold);

  gotoPage(BuildContext context, dynamic page) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
  }

  //buttons for each post
  Widget buttons(Userpost userpost) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      TextButton.icon(
        style: TextButton.styleFrom(
          foregroundColor: (userpost.isliked) ? Colors.blue : Colors.grey,
        ),

        onPressed: () {
          setState(() {});
        },
        icon: const Icon(Icons.thumb_up),
        label: const Text('Like'),
      ),
      TextButton.icon(
        style: TextButton.styleFrom(foregroundColor: Colors.grey),
        onPressed: () {},
        icon: const Icon(Icons.comment),
        label: const Text('Comment'),
      ),
      TextButton.icon(
        style: TextButton.styleFrom(foregroundColor: Colors.grey),
        onPressed: () {},
        icon: const Icon(Icons.share),
        label: const Text('Share'),
      ),
    ],
  );

  //post count for each post
  Widget postCount(Userpost userPost) => Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Text('${userPost.numcomments} Comments'),
      const Text(''),
      const SizedBox(width: 20),
      Text('${userPost.numshare} Share'),
    ],
  );

  //image for each post
  Widget postImage(Userpost userpost) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Container(
      height: 350,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(userpost.postimg),
          fit: BoxFit.fill,
        ),
      ),
    ),
  );

  //header for each post
  Widget postHeader(Userpost userpost) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: CircleAvatar(
          radius: 25,
          backgroundImage: AssetImage(userpost.userimg),
        ),
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(userpost.username, style: nameTxtStyle),
          Row(children: [Text('${userpost.time} . ')]),
        ],
      ),
    ],
  );

  // show each post
  Widget showPost(Userpost userpost) => Column(
    children: [
      postHeader(userpost),
      Container(
        margin: const EdgeInsets.all(8),
        child: Row(children: [Text(userpost.postcontent, style: nameTxtStyle)]),
      ),
      postImage(userpost),
      postCount(userpost),
      const Divider(),
      buttons(userpost),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: widget.userdata.userList.map((userpost) {
          return InkWell(
            onTap: () {
              gotoPage(context, ProfileView(userPost: userpost));
            },
            child: showPost(userpost),
          );
        }).toList(),
      ),
    );
  }
}
