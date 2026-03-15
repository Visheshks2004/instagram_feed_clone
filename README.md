# Instagram Feed Flutter Clone

## 👨‍💻 Project Information
- **Developer:** vishesh kumar
- **Email:** visheshks2004@gmail.com
- **Date:** 15 March 2026
- **Flutter Version:** 3.35.3

## ✨ Features Implemented
- ✅ Top Bar with Instagram logo and icons
- ✅ Stories Tray with gradient rings and LIVE badges
- ✅ Post Cards with images, captions, and actions
- ✅ Image Carousel with dot indicators
- ✅ Pinch-to-Zoom gesture on images
- ✅ Infinite Scroll (loads more when near bottom)
- ✅ Like and Save toggle buttons
- ✅ Snackbar for unimplemented features
- ✅ Shimmer loading effect (1.5s delay)
- ✅ Error handling for failed image loads
- ✅ Pull to Refresh

## 🏗️ Architecture
- **State Management:** Provider + ChangeNotifier
- **Data Layer:** Repository pattern with mock data
- **Image Handling:** cached_network_image
- **UI Components:** Custom widgets with separation of concerns

## 🎯 Assignment Requirements Met

| Requirement | Implementation |
|-------------|----------------|
| Pixel-Perfect UI | Exact spacing, typography, and icons |
| Stories Tray | Gradient rings, LIVE badges |
| Image Carousel | Multiple images with dot indicators |
| Pinch-to-Zoom | Custom gesture with smooth animation |
| Like/Save Toggle | Local state with visual feedback |
| Snackbar | For Comments, Share buttons |
| Mock Data | PostRepository with Future/Stream |
| Loading State | Shimmer effects (1.5s delay) |
| Image Caching | cached_network_image |
| Infinite Scroll | Pagination with 2-post threshold |
| Clean Architecture | Separate folders for models/providers/widgets |

## 🚀 How to Run

### Prerequisites
- Flutter SDK (version 3.0.0 or higher)
- Android Studio / VS Code
- Git

### Steps
```bash
# Clone this repository
git clone https://github.com/Visheshks2004/instagram_feed_clone.git

# Navigate to project
cd instagram_feed_clone

🛠️ Built With
Flutter - UI framework

Provider - State management

cached_network_image - Image caching

📄 License
This project is for demonstration purposes only.

🙏 Acknowledgments
Flutter team for the amazing framework

Unsplash for sample images

Instagram for design inspiration

# Get dependencies
flutter pub get

# Run the app
flutter run
