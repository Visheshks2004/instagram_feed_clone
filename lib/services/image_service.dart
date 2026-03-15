import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../utils/constants.dart';

class ImageService {
  
  static Future<void> precacheImages(List<String> imageUrls, BuildContext context) async {
    for (final url in imageUrls) {
      await precacheImage(
        CachedNetworkImageProvider(
          url,
          
        ), 
        context
      );
    }
  }
  
  
  static ImageProvider getImageProvider(String imageUrl) {
    
    return CachedNetworkImageProvider(imageUrl);
  }
  

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
  

  static Future<void> clearImageCache(String imageUrl) async {
    try {
      final image = CachedNetworkImageProvider(imageUrl);
      await image.evict();
    } catch (e) {
      debugPrint('Error clearing image cache: $imageUrl - $e');
    }
  }
  
  
  static Future<void> clearAllCache() async {
    try {
      await CachedNetworkImage.evictFromCache(AppConstants.placeholderImage);
    } catch (e) {
      debugPrint('Error clearing all cache: $e');
    }
  }
  
  
  static String getOptimizedImageUrl(String baseUrl, {int width = 800}) {
    
    if (baseUrl.contains('unsplash.com')) {
      
      if (baseUrl.contains('?')) {
        return '$baseUrl&w=$width&fit=crop';
      } else {
        return '$baseUrl?w=$width&fit=crop';
      }
    }
    return baseUrl;
  }

  
  static bool isValidImageUrl(String url) {
    try {
      final uri = Uri.parse(url);
      return uri.isAbsolute && 
             (uri.scheme == 'http' || uri.scheme == 'https');
    } catch (e) {
      return false;
    }
  }

  
  static String getFallbackImageUrl(String originalUrl) {
    
    return 'https://via.placeholder.com/400x400?text=Image+Not+Found';
  }
}


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