import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/post.dart';
import '../../providers/feed_provider.dart';
import 'post_image_carousel.dart';

class PostCard extends StatelessWidget {
  final Post post;

  const PostCard({Key? key, required this.post}) : super(key: key);

  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Post Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundImage: CachedNetworkImageProvider(
                    post.user.profileImageUrl,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    post.user.username,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
                const Icon(Icons.more_horiz, size: 20),
              ],
            ),
          ),
          
          // Post Images
          PostImageCarousel(imageUrls: post.imageUrls),
          
          // Action Buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    post.isLiked ? Icons.favorite : Icons.favorite_border,
                    color: post.isLiked ? Colors.red : null,
                  ),
                  onPressed: () {
                    context.read<FeedProvider>().toggleLike(post.id);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.mode_comment_outlined),
                  onPressed: () {
                    _showSnackbar(context, 'Comments feature coming soon!');
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.send_outlined),
                  onPressed: () {
                    _showSnackbar(context, 'Share feature coming soon!');
                  },
                ),
                const Spacer(),
                IconButton(
                  icon: Icon(
                    post.isSaved ? Icons.bookmark : Icons.bookmark_border,
                  ),
                  onPressed: () {
                    context.read<FeedProvider>().toggleSave(post.id);
                  },
                ),
              ],
            ),
          ),
          
          // Likes count
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              '${post.likesCount} likes',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
          
          // Caption
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: [
                  TextSpan(
                    text: post.user.username,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  TextSpan(text: ' ${post.caption}'),
                ],
              ),
            ),
          ),
          
          // Timestamp
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Text(
              _getTimeAgo(post.timestamp),
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getTimeAgo(DateTime timestamp) {
    final difference = DateTime.now().difference(timestamp);
    
    if (difference.inHours > 24) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else {
      return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
    }
  }
}