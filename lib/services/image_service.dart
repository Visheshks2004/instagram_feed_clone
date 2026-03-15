import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../utils/constants.dart';

class ImageService {
  // Precache images for better performance
  static Future<void> precacheImages(List<String> imageUrls, BuildContext context) async {
    for (final url in imageUrls) {
      await precacheImage(
        CachedNetworkImageProvider(
          url,
          // Remove errorListener from here as it's not needed for precaching
        ), 
        context
      );
    }
  }
  
  // Get cached image provider with error handling
  static ImageProvider getImageProvider(String imageUrl) {
    // CachedNetworkImageProvider doesn't have errorListener parameter
    // Instead, we'll return the provider and handle errors in the widget
    return CachedNetworkImageProvider(imageUrl);
  }
  
  // Alternative method with error callback using ImageStream
  static void loadImageWithCallback(String imageUrl, {
    required Function() onSuccess,
    required Function(dynamic error) onError,
  }) {
    final provider = CachedNetworkImageProvider(imageUrl);
    final stream = provider.resolve(const ImageConfiguration());
    
    stream.addListener(
      ImageStreamListener(
        (image, synchronousCall) {
          onSuccess();
        },
        onError: (dynamic error, StackTrace? stackTrace) {
          onError(error);
          debugPrint('Error loading image: $imageUrl - $error');
        },
      ),
    );
  }
  
  // Build image widget with loading and error states
  static Widget buildNetworkImage({
    required String imageUrl,
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    BorderRadius? borderRadius,
  }) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: fit,
        placeholder: (context, url) => Container(
          color: Colors.grey[300],
          child: const Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
            ),
          ),
        ),
        errorWidget: (context, url, error) {
          // Log the error for debugging
          debugPrint('Error loading image: $url - $error');
          
          return Container(
            color: Colors.grey[300],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  color: Colors.grey[600],
                  size: 32,
                ),
                const SizedBox(height: 4),
                Text(
                  AppStrings.errorNetworkImage,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
  
  // Get image size (useful for aspect ratio calculations)
  static Future<Size> getImageSize(String imageUrl) async {
    final completer = Completer<Size>();
    
    try {
      final image = CachedNetworkImageProvider(imageUrl);
      final stream = image.resolve(const ImageConfiguration());
      
      stream.addListener(
        ImageStreamListener(
          (info, _) {
            completer.complete(Size(
              info.image.width.toDouble(),
              info.image.height.toDouble(),
            ));
          },
          onError: (dynamic error, StackTrace? stackTrace) {
            completer.completeError(error);
            debugPrint('Error getting image size: $imageUrl - $error');
          },
        ),
      );
    } catch (e) {
      completer.completeError(e);
    }
    
    return completer.future;
  }
  
  // Clear cache for specific image
  static Future<void> clearImageCache(String imageUrl) async {
    try {
      final image = CachedNetworkImageProvider(imageUrl);
      await image.evict();
    } catch (e) {
      debugPrint('Error clearing image cache: $imageUrl - $e');
    }
  }
  
  // Clear all cached images
  static Future<void> clearAllCache() async {
    try {
      await CachedNetworkImage.evictFromCache(AppConstants.placeholderImage);
    } catch (e) {
      debugPrint('Error clearing all cache: $e');
    }
  }
  
  // Get appropriate image size based on device pixel ratio
  static String getOptimizedImageUrl(String baseUrl, {int width = 800}) {
    // If using an API that supports image resizing
    if (baseUrl.contains('unsplash.com')) {
      // Check if URL already has query parameters
      if (baseUrl.contains('?')) {
        return '$baseUrl&w=$width&fit=crop';
      } else {
        return '$baseUrl?w=$width&fit=crop';
      }
    }
    return baseUrl;
  }

  // Helper method to validate image URL
  static bool isValidImageUrl(String url) {
    try {
      final uri = Uri.parse(url);
      return uri.isAbsolute && 
             (uri.scheme == 'http' || uri.scheme == 'https');
    } catch (e) {
      return false;
    }
  }

  // Get fallback image URL if main URL fails
  static String getFallbackImageUrl(String originalUrl) {
    // You can implement logic to return a fallback image
    // For now, return a placeholder
    return 'https://via.placeholder.com/400x400?text=Image+Not+Found';
  }
}

// Extension for easier error handling
extension CachedNetworkImageExtension on CachedNetworkImage {
  static Widget withErrorHandling({
    required String imageUrl,
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    Widget? placeholder,
    Widget? errorWidget,
  }) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      placeholder: (context, url) => placeholder ?? Container(
        color: Colors.grey[300],
        child: const Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
      ),
      errorWidget: (context, url, error) {
        debugPrint('CachedNetworkImage error: $url - $error');
        return errorWidget ?? Container(
          color: Colors.grey[300],
          child: const Center(
            child: Icon(
              Icons.broken_image,
              color: Colors.grey,
              size: 40,
            ),
          ),
        );
      },
    );
  }
}