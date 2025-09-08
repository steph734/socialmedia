import 'friend.dart';
import 'usercomment.dart';
import 'userpost.dart';
import 'account.dart';

class Userdata {
  List<Userpost> userList = [
    Userpost(
      userimg: "assets/images/user1.jpg",
      username: "John Doe",
      time: "2 hrs ago",
      postcontent: "Had a great day at the beach!",
      postimg: "assets/images/post1.jpg",
      numcomments: "45",
      numshare: "10",
      numlikes: 0,
      isFavorited: false,
      isliked: false,
    ),

    Userpost(
      userimg: "assets/images/user2.jpg",
      username: "Jane Smith",
      time: "5 hrs ago",
      postcontent: "Loving the new cafe in town.",
      postimg: "assets/images/post2.jpg",
      numcomments: "30",
      numshare: "5",
      numlikes: 0,
      isFavorited: true,
      isliked: false,
    ),

    Userpost(
      userimg: "assets/images/user3.jpg",
      username: "Mike Johnson",
      time: "1 day ago",
      postcontent: "Just finished a marathon!",
      postimg: "assets/images/post3.jpg",
      numcomments: "60",
      numlikes: 0,
      numshare: "15",
      isFavorited: false,
      isliked: false,
    ),
  ];

  // Friend List
  List<Friend> friendList = [
    Friend(img: "assets/images/user1.jpg", name: "John Doe"),
    Friend(img: "assets/images/user2.jpg", name: "Jane Smith"),
    Friend(img: "assets/images/user3.jpg", name: "Mike Johnson"),
    Friend(img: "assets/images/user4.jpg", name: "Emily Davis"),
    Friend(img: "assets/images/user5.jpg", name: "Chris Brown"),
    Friend(img: "assets/images/user6.jpg", name: "Sarah Wilson"),
  ];

  // Account Info
  List<Usercomment> commentList = [
    Usercomment(
      commenterImg: "assets/images/user4.jpg",
      commenterName: "Emily Davis",
      commentTime: "1 hr ago",
      commentContent: "Looks fun!",
      commentPost: "Had a great day at the beach!",
    ),
    Usercomment(
      commenterImg: "assets/images/user5.jpg",
      commenterName: "Chris Brown",
      commentTime: "3 hrs ago",
      commentContent: "Great photo!",
      commentPost: "Loving the new cafe in town!",
    ),
    Usercomment(
      commenterImg: "assets/images/user6.jpg",
      commenterName: "Sarah Wilson",
      commentTime: "6 hrs ago",
      commentContent: "Wish I was there!",
      commentPost: "Just finished a marathon!",
    ),
  ];

  Account myUserAccount = Account(
    name: "Maricel Joy Alajar",
    email: "mariceljoyalajar@gmail.com",
    img: "assets/images/mygirl.png",
    numFollowers: "1.5K",
    numLikes: "350",
    numFollowing: "500",
    numFriends: "300",
    numPosts: '300',
  );
}
