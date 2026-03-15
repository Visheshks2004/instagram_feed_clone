import 'package:flutter/material.dart';

class AppConstants {
  
  static const String baseUrl = 'https://api.example.com';
  
  
  static const String placeholderImage = 'https://via.placeholder.com/400';
  static const String errorImage = 'https://via.placeholder.com/400/ff0000/ffffff?text=Error';
  
  
  static const int postsPerPage = 10;
  static const int preloadDistance = 2; // Load more when 2 posts away from bottom
  
  
  static const Duration shimmerDuration = Duration(milliseconds: 1500);
  static const Duration snackBarDuration = Duration(seconds: 2);
  static const Duration pinchZoomDuration = Duration(milliseconds: 300);
  
  
  static const Duration networkDelay = Duration(milliseconds: 1500);
  

  static const Color primaryBlack = Color(0xFF262626);
  static const Color secondaryGrey = Color(0xFF8E8E8E);
  static const Color lightGrey = Color(0xFFFAFAFA);
  static const Color borderGrey = Color(0xFFDBDBDB);
  static const Color storyGradientStart = Color(0xFFF58529);
  static const Color storyGradientEnd = Color(0xFFDD2A7B);
  
  
  static const TextStyle usernameStyle = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 14,
    color: primaryBlack,
  );
  
  static const TextStyle captionStyle = TextStyle(
    fontSize: 14,
    color: primaryBlack,
  );
  
  static const TextStyle timestampStyle = TextStyle(
    fontSize: 10,
    color: secondaryGrey,
  );
  
  static const TextStyle likesCountStyle = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 14,
    color: primaryBlack,
  );
  
  
  static const double defaultPadding = 12.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 16.0;
  
  
  static const double iconSizeSmall = 20.0;
  static const double iconSizeMedium = 24.0;
  static const double iconSizeLarge = 28.0;
  
  
  static const double storyAvatarSize = 56.0;
  static const double postAvatarSize = 32.0;
  
  
  static const double storyBorderRadius = 16.0;
  static const double cardBorderRadius = 0.0; // Instagram has no border radius
}

class AppStrings {
  static const String appTitle = 'Instagram';
  static const String logo = 'Instagram';
  
  
  static const String commentsComingSoon = 'Comments feature coming soon!';
  static const String shareComingSoon = 'Share feature coming soon!';
  static const String messagesComingSoon = 'Messages feature coming soon!';
  static const String notificationsComingSoon = 'Notifications feature coming soon!';
  
  
  static const String errorLoadingPosts = 'Failed to load posts';
  static const String errorLoadingStories = 'Failed to load stories';
  static const String errorNetworkImage = 'Failed to load image';
  static const String retry = 'Retry';
  
  
  static const String hourAgo = 'h';
  static const String minutesAgo = 'm';
  static const String daysAgo = 'd';
  static const String justNow = 'Just now';
  
  
  static const String live = 'LIVE';
  static const String yourStory = 'Your Story';
}