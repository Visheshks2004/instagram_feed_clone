import 'package:instagram_feed_clone/models/user.dart';

class Post {
  final String id;
  final User user;
  final String caption;
  final DateTime timestamp;
  final List<String> imageUrls;
  final int likesCount;
  final bool isLiked;
  final bool isSaved;

  Post({
    required this.id,
    required this.user,
    required this.caption,
    required this.timestamp,
    required this.imageUrls,
    this.likesCount = 0,
    this.isLiked = false,
    this.isSaved = false,
  });

  Post copyWith({
    String? id,
    User? user,
    String? caption,
    DateTime? timestamp,
    List<String>? imageUrls,
    int? likesCount,
    bool? isLiked,
    bool? isSaved,
  }) {
    return Post(
      id: id ?? this.id,
      user: user ?? this.user,
      caption: caption ?? this.caption,
      timestamp: timestamp ?? this.timestamp,
      imageUrls: imageUrls ?? this.imageUrls,
      likesCount: likesCount ?? this.likesCount,
      isLiked: isLiked ?? this.isLiked,
      isSaved: isSaved ?? this.isSaved,
    );
  }
}