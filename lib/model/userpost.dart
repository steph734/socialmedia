class Userpost {
  final String userimg;
  final String username;
  final String time;
  final String postcontent;
  final String postimg;
  String numcomments;
  final String numshare;
  int numlikes;
  bool isFavorited;
  bool isliked;

  List<String> comments;

  Userpost({
    required this.userimg,
    required this.username,
    required this.time,
    required this.postcontent,
    required this.postimg,
    required this.numcomments,
    required this.numshare,
    required this.numlikes,
    required this.isFavorited,
    required this.isliked,
    List<String>? comments,
  }) : comments = comments ?? [];
}
