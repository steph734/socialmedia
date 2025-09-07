import 'package:flutter/material.dart';
import '../model/userdata.dart';

// ignore: must_be_immutable
class Infoheader extends StatelessWidget {
  Infoheader({super.key, required this.userdata});
  final Userdata userdata;

  var followTxtStyle = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [Text('Followers'), Text('Following'), Text('Posts')],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(userdata.myUserAccount.numFollowers, style: followTxtStyle),
            Text(userdata.myUserAccount.numFollowing, style: followTxtStyle),
            Text(userdata.myUserAccount.numPosts, style: followTxtStyle),
          ],
        ),
        const SizedBox(height: 1),
        const Divider(color: Colors.grey),
      ],
    );
  }
}
