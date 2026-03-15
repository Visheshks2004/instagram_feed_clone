import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../models/story.dart';
import '../../utils/constants.dart';

class StoriesTray extends StatelessWidget {
  final List<Story> stories;

  const StoriesTray({Key? key, required this.stories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 105, // Increased height to prevent overflow
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.defaultPadding,
        vertical: 8, // Reduced vertical padding
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppConstants.borderGrey.withOpacity(0.3),
            width: 0.5,
          ),
        ),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: stories.length + 1, // +1 for "Your Story"
        itemBuilder: (context, index) {
          if (index == 0) {
            return const _YourStoryItem();
          }
          return _StoryItem(story: stories[index - 1]);
        },
      ),
    );
  }
}

class _StoryItem extends StatelessWidget {
  final Story story;

  const _StoryItem({Key? key, required this.story}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 68, // Slightly reduced width
      margin: const EdgeInsets.only(right: 6), // Reduced margin
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Story avatar with gradient ring
          Stack(
            clipBehavior: Clip.none, // Allow live indicator to overflow
            children: [
              Container(
                width: 64,
                height: 64,
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: story.hasUnseenStory
                      ? const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppConstants.storyGradientStart,
                            AppConstants.storyGradientEnd,
                          ],
                        )
                      : null,
                  border: !story.hasUnseenStory
                      ? Border.all(
                          color: AppConstants.borderGrey,
                          width: 1,
                        )
                      : null,
                ),
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.grey[200],
                    backgroundImage: CachedNetworkImageProvider(
                      story.user.profileImageUrl,
                    ),
                    onBackgroundImageError: (_, __) {
                      // Handle image error silently
                    },
                  ),
                ),
              ),
              
              // Live indicator
              if (story.isLive)
                Positioned(
                  bottom: -2,
                  right: 4,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 32,
                    ),
                    child: const Text(
                      'LIVE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
          
          // Username - with fixed height to prevent overflow
          const SizedBox(height: 6),
          Container(
            height: 14, // Fixed height for username
            alignment: Alignment.center,
            child: Text(
              _getDisplayName(story.user.username),
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w400,
                height: 1.2,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  String _getDisplayName(String username) {
    if (username.length > 10) {
      return '${username.substring(0, 8)}...';
    }
    return username;
  }
}

class _YourStoryItem extends StatelessWidget {
  const _YourStoryItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 68,
      margin: const EdgeInsets.only(right: 6),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppConstants.borderGrey,
                width: 1,
              ),
            ),
            child: Container(
              margin: const EdgeInsets.all(2),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppConstants.lightGrey,
              ),
              child: const Center(
                child: Icon(
                  Icons.add,
                  size: 32,
                  color: AppConstants.primaryBlack,
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Container(
            height: 14,
            alignment: Alignment.center,
            child: const Text(
              'Your Story',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w400,
                height: 1.2,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}