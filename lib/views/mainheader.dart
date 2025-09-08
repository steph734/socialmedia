import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../model/userdata.dart';
import '../views/editprofile.view.dart';

class Mainheader extends StatefulWidget {
  final Userdata userdata;

  const Mainheader({
    super.key,
    required this.userdata,
    required String username,
  });

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
      Text(label, style: const TextStyle(fontSize: 14, color: Colors.black87)),
    ],
  );

  void _showQrCode(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Scan to Add",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            QrImageView(
              data: userdata
                  .myUserAccount
                  .name, // 👈 you can also use userId/username
              version: QrVersions.auto,
              size: 200,
            ),
            const SizedBox(height: 16),
            Text(
              "@${userdata.myUserAccount.name}",
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const SizedBox(height: 8),
            const Text("Let your friends scan this QR code to follow you."),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Profile picture + Stats
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
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),

        const SizedBox(height: 4),

        // Bio / Email
        Text(
          userdata.myUserAccount.email,
          style: const TextStyle(fontSize: 14, color: Colors.black87),
        ),

        const SizedBox(height: 12),

        // Buttons Row
        Row(
          children: [
            Expanded(
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
            const SizedBox(width: 8),
            Expanded(
              child: OutlinedButton(
                onPressed: () => _showQrCode(context),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.grey),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: const Text("Share Profile"),
              ),
            ),
          ],
        ),

        const SizedBox(height: 10),

        const Divider(thickness: 0.5, color: Colors.grey),
      ],
    );
  }
}
