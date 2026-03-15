📱 Instagram Feed Flutter Clone

A pixel-perfect Instagram Home Feed clone built with Flutter, demonstrating advanced UI/UX implementation, clean architecture, and complex gesture handling.

📋 Assignment Requirements Met

Requirement	Implementation

✅ Pixel-Perfect UI	Exact spacing, typography, and icons matching Instagram

✅ Stories Tray	Gradient rings for unseen stories, LIVE badges

✅ Image Carousel	Multiple images with smooth scrolling and dot indicators

✅ Pinch-to-Zoom	Custom gesture overlay with smooth animation

✅ Like/Save Toggle	Local state management with visual feedback

✅ Snackbar Messages	For Comments, Share, and other unimplemented buttons

✅ Mock Data Layer	PostRepository with Future/Stream and 1.5s delay

✅ Shimmer Loading	Beautiful loading effects instead of spinners

✅ Image Caching	Using cached_network_image for memory optimization

✅ Infinite Scroll	Pagination with 2-post threshold

✅ Clean Architecture	Separate folders for models/providers/widgets

🏗️ Architecture

lib/
├── models/          # Data classes (Post, Story, User)

├── repositories/    # Mock data with latency simulation

├── providers/       # State management with ChangeNotifier

├── services/        # Image caching and utility services

├── utils/          # Constants and helper functions

└── widgets/         # Reusable UI components

    ├── feed/        # Feed-specific widgets
    
    └── shared/      # Shared widgets (shimmer, error, etc.)

🎯 State Management Choice: Provider
I chose Provider with ChangeNotifier for state management because:

Simple: Easy to understand and implement

Performance: Only rebuilds widgets that listen to changes

Scalability: Can easily add more features without complexity

Built-in: Works seamlessly with Flutter's widget tree

Testability: Easy to mock and unit test

How it works in this app:
FeedProvider extends ChangeNotifier and manages all feed data

UI widgets use Consumer<FeedProvider> to listen to specific state changes

notifyListeners() triggers UI updates when state changes

Methods like toggleLike() update state and automatically notify listeners

🚀 How to Run the Project
Prerequisites
Flutter SDK (version 3.0.0 or higher)

Android Studio / VS Code

Git

Android Emulator or Physical Device

Step-by-Step Instructions

# 1. Clone the repository
git clone https://github.com/Visheshks2004/instagram_feed_clone

# 2. Navigate to project folder
cd instagram_feed_clone

# 3. Get dependencies
flutter pub get

# 4. Run the app
flutter run
Build APK (Android)

flutter build apk --release
Build iOS (Mac only)

flutter build ios --release

✨ Features Demo

Shimmer Loading State
1.5-second simulated network delay

Beautiful shimmer effects instead of traditional spinners

Matches Instagram's modern loading pattern

Infinite Scrolling
Automatically loads more posts when user is 2 posts away from bottom

Smooth, jank-free scrolling performance

Loading indicator appears at bottom while fetching

Pinch-to-Zoom
Zoom images from 1x to 3x with smooth scaling

Pan support when zoomed in

Automatic animation back to original position when released

Interactive Elements
Like button toggles with color change animation

Save bookmark toggles between outline and filled

Snackbar notifications for unimplemented features

🛠️ Technical Implementation
Pinch-to-Zoom
The pinch-to-zoom feature uses a custom GestureDetector with scale transformations:

dart
GestureDetector(
  onScaleStart: _handleScaleStart,
  onScaleUpdate: _handleScaleUpdate,
  onScaleEnd: _handleScaleEnd,
  child: Transform.scale(
    scale: _scale,
    child: Transform.translate(
      offset: _offset,
      child: widget.child,
    ),
  ),
)
Infinite Scroll
Infinite scroll is implemented using a ScrollController with threshold detection:

dart
void _onScroll() {
  // Check if user is within 500 pixels of bottom
  if (_scrollController.position.pixels >=
      _scrollController.position.maxScrollExtent - 500) {
    // Load more posts
    context.read<FeedProvider>().loadMorePosts();
  }
}
Image Caching
Images are cached using cached_network_image for optimal performance:

dart
CachedNetworkImage(
  imageUrl: post.imageUrls[index],
  placeholder: (context, url) => ShimmerEffect(
    child: Container(color: Colors.grey[300]),
  ),
  errorWidget: (context, url, error) => const Icon(
    Icons.error_outline,
    color: Colors.grey,
  ),
  fit: BoxFit.cover,
)
📦 Dependencies
yaml
dependencies:
  flutter:
    sdk: flutter
  
  # State Management
  provider: ^6.0.5
  
  # Image Caching and Loading
  cached_network_image: ^3.3.0
  
  # UI Utilities
  cupertino_icons: ^1.0.2

📹 Demo Video
Click below to watch the demo video :-
https://www.loom.com/share/9e9eaa2410c6409e8f530b343adee0bc


The video demonstrates:

Shimmer loading state (0:00 - 0:15)

Smooth infinite scrolling (0:15 - 0:30)

Pinch-to-zoom interaction (0:30 - 0:50)

Like/Save toggle animations (0:50 - 1:10)

🧪 Edge Cases Handled
Network image load failures (shows error icon)

Empty states with user-friendly messages

Pagination end detection (stops loading)

Pull-to-refresh functionality

Error recovery with retry option

⚡ Performance Optimizations
cached_network_image for memory-efficient image loading

ListView.builder for lazy loading of posts

Provider's selective rebuilds (only updates changed widgets)

const constructors where possible

Image precaching for smoother carousel experience

📄 License
This project is for demonstration purposes only. Instagram and all related trademarks are property of Meta Platforms, Inc.

👨‍💻 Author
Vishesh Kumar

GitHub: https://github.com/Visheshks2004

Email: visheshks2004@gmail.com


🙏 Acknowledgments
Flutter Team - For the amazing framework

Unsplash - For sample images

Instagram - For design inspiration

GitHub Community - For open source packages
