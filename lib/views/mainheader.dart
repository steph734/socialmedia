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
            onChanged: (value) => newTitle = value,
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
                      "images": [newImg],
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

  BoxDecoration igStoryDecoration() {
    return const BoxDecoration(
      shape: BoxShape.circle,
      gradient: SweepGradient(
        colors: [
          Color(0xFFfeda75),
          Color(0xFFfa7e1e),
          Color(0xFFd62976),
          Color(0xFF962fbf),
          Color(0xFF4f5bd5),
          Color(0xFFfeda75),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Profile picture + Stats
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(3),
              decoration: igStoryDecoration(),
              child: CircleAvatar(
                backgroundImage: AssetImage(userdata.myUserAccount.img),
                radius: 45,
              ),
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

        /// Name + Bio
        Text(
          userdata.myUserAccount.name,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          userdata.myUserAccount.email,
          style: const TextStyle(fontSize: 14, color: Colors.black87),
        ),

        const SizedBox(height: 12),

        /// Buttons
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
                    setState(() => userdata = updatedUserdata);
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

        /// Featured Stories (Highlights)
        SizedBox(
          height: 95,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: featuredStories.length + 1,
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
                        // Build all FeaturedStoryView objects
                        final allStories = List.generate(
                          featuredStories.length,
                          (i) => FeaturedStoryView(
                            title: featuredStories[i]["title"],
                            images: List<String>.from(
                              featuredStories[i]["images"],
                            ),
                            storyIndex: i,
                            allStories: [],
                          ),
                        );

                        // Link them together
                        for (int i = 0; i < allStories.length; i++) {
                          allStories[i] = FeaturedStoryView(
                            title: allStories[i].title,
                            images: allStories[i].images,
                            storyIndex: i,
                            allStories: allStories,
                          );
                        }

                        // Open tapped story
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => allStories[index - 1],
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: igStoryDecoration(),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage(story["images"][0]),
                        ),
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

        /// Tabs
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

        /// Tab Views
        SizedBox(
          height: 400,
          child: TabBarView(
            controller: _tabController,
            children: [
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
              ReelsView(),
              const Center(child: Text("Tagged posts go here")),
            ],
          ),
        ),
      ],
    );
  }
}
