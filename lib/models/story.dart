import 'package:instagram_feed_clone/models/user.dart';

class Story {
  final String id;
  final User user;
  final bool hasUnseenStory;
  final bool isLive;

  Story({
    required this.id,
    required this.user,
    this.hasUnseenStory = true,
    this.isLive = false,
  });
}