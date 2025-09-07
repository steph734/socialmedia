import 'package:flutter/material.dart';
import '../model/userdata.dart';
import '../views/editprofile.view.dart';

class Mainheader extends StatefulWidget {
  final Userdata userdata;

  const Mainheader({super.key, required this.userdata});

  @override
  State<Mainheader> createState() => _MainheaderState();
}

class _MainheaderState extends State<Mainheader> {
  late Userdata userdata;

  @override
  void initState() {
    super.initState();
    userdata = widget.userdata;
  }

  Widget buildStat(String count, String label) => Column(
    children: [
      Text(
        count,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 2),
      Text(label, style: const TextStyle(fontSize: 14, color: Colors.black54)),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Profile pic + stats
        Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(userdata.myUserAccount.img),
              radius: 45,
            ),
            const SizedBox(width: 30),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildStat(userdata.myUserAccount.numPosts, "Posts"),
                  buildStat(userdata.myUserAccount.numFollowers, "Followers"),
                  buildStat(userdata.myUserAccount.numFollowing, "Following"),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        // Name
        Text(
          userdata.myUserAccount.name,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 4),

        // Email
        Text(
          userdata.myUserAccount.email,
          style: const TextStyle(fontSize: 13, color: Colors.black87),
        ),

        const SizedBox(height: 12),

        // ✅ Edit Profile button
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () async {
              final updatedUserdata = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProfileView(userdata: userdata),
                ),
              );

              if (updatedUserdata != null) {
                setState(() {
                  userdata = updatedUserdata;
                });
              }
            },
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.grey),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            child: const Text("Edit Profile"),
          ),
        ),

        const Divider(thickness: 0.5, color: Colors.grey),
      ],
    );
  }
}
