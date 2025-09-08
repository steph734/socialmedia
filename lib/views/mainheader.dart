import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:socialmedia_clone/views/featuredstory.view.dart';
import '../model/userdata.dart';
import '../views/editprofile.view.dart';
import '../views/followinglist.view.dart';
import '../views/followerslist.view.dart';
import '../views/reels.view.dart'; // new reels page

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

class _MainheaderState extends State<Mainheader>
    with SingleTickerProviderStateMixin {
  late Userdata userdata;
  late TabController _tabController;

  // 🔹 Sample Featured Stories (Highlights)
  final List<Map<String, dynamic>> featuredStories = [
    {
      "title": "Travel",
      "images": ["assets/images/story1.jpg", "assets/images/story2.jpg"],
    },
    {
      "title": "Food",
      "images": ["assets/images/story3.jpg"],
    },
    {
      "title": "Gym",
      "images": ["assets/images/story4.jpg"],
    },
    {
      "title": "Pets",
      "images": ["assets/images/story5.jpg"],
    },
    {
      "title": "Work",
      "images": ["assets/images/story6.jpg"],
    },
  ];

  @override
  void initState() {
    super.initState();
    userdata = widget.userdata;
    _tabController = TabController(
      length: 3, // Posts, Reels, Tagged
      vsync: this,
    );
  }

  Widget buildStat(String count, String label, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Text(
            count,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ],
      ),
    );
  }

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
            const Text(
              "Scan to Add",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            QrImageView(
              data: userdata.myUserAccount.name,
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

  // 🔹 Function to add new featured story
  void _addFeaturedStory(BuildContext context) {
    String newTitle = "";
    String newImg = "assets/images/story_default.jpg"; // fallback

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add Featured Story"),
          content: TextField(
            decoration: const InputDecoration(
              labelText: "Story Title",
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              newTitle = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (newTitle.isNotEmpty) {
                  setState(() {
                    featuredStories.add({
                      "title": newTitle,
                      "images": [newImg], // ✅ wrap in list
                    });
                  });
                }
                Navigator.pop(context);
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// 🔹 Profile picture + Stats
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
                  buildStat(
                    userdata.myUserAccount.numFollowers,
                    "Followers",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              FollowersListView(followers: userdata.friendList),
                        ),
                      );
                    },
                  ),
                  buildStat(
                    userdata.myUserAccount.numFollowing,
                    "Following",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              FollowingListView(following: userdata.friendList),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        /// 🔹 Name
        Text(
          userdata.myUserAccount.name,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),

        const SizedBox(height: 4),

        /// 🔹 Bio / Email
        Text(
          userdata.myUserAccount.email,
          style: const TextStyle(fontSize: 14, color: Colors.black87),
        ),

        const SizedBox(height: 12),

        /// 🔹 Buttons Row
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

        const SizedBox(height: 16),

        /// 🔹 Featured Stories (Instagram Highlights)
        SizedBox(
          height: 95,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: featuredStories.length + 1, // +1 for "New" story
            itemBuilder: (context, index) {
              if (index == 0) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () => _addFeaturedStory(context),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.grey[300],
                          child: const Icon(Icons.add, color: Colors.black),
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text("New", style: TextStyle(fontSize: 12)),
                    ],
                  ),
                );
              }
              final story = featuredStories[index - 1];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => FeaturedStoryView(
                              title: story["title"],
                              images: List<String>.from(story["images"]),
                            ),
                          ),
                        );
                      },
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage(story["images"][0]),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(story["title"], style: const TextStyle(fontSize: 12)),
                  ],
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 10),
        const Divider(thickness: 0.5, color: Colors.grey),

        /// 🔹 Tabs (Posts, Reels, Tagged)
        TabBar(
          controller: _tabController,
          indicatorColor: Colors.black,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          tabs: const [
            Tab(icon: Icon(Icons.grid_on)), // Posts
            Tab(icon: Icon(Icons.video_library)), // Reels
            Tab(icon: Icon(Icons.person_pin)), // Tagged
          ],
        ),

        /// 🔹 Tab Views
        SizedBox(
          height: 400,
          child: TabBarView(
            controller: _tabController,
            children: [
              /// Posts grid
              GridView.builder(
                padding: const EdgeInsets.all(2),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                ),
                itemCount: userdata.userList.length > 6
                    ? 6
                    : userdata.userList.length,
                itemBuilder: (context, index) {
                  final post = userdata.userList[index];
                  return GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => Dialog(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(post.postimg),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(post.postcontent),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    child: Image.asset(post.postimg, fit: BoxFit.cover),
                  );
                },
              ),

              /// Reels screen
              ReelsView(),

              /// Tagged placeholder
              const Center(child: Text("Tagged posts go here")),
            ],
          ),
        ),
      ],
    );
  }
}
