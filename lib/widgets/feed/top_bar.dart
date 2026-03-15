import 'package:flutter/material.dart';
import '../../utils/constants.dart';

class TopBar extends StatelessWidget {
  const TopBar({Key? key}) : super(key: key);

  void _showComingSoonSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: AppConstants.snackBarDuration,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50, // Slightly increased height
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppConstants.borderGrey.withOpacity(0.3),
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo
          const Text(
            'Instagram',
            style: TextStyle(
              fontFamily: 'Billabong',
              fontSize: 28,
              letterSpacing: 0.5,
              fontWeight: FontWeight.w400,
            ),
          ),
          
          // Actions
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Like/Notification button
              GestureDetector(
                onTap: () => _showComingSoonSnackbar(
                  context, 
                  AppStrings.notificationsComingSoon
                ),
                child: const Icon(
                  Icons.favorite_border,
                  size: 24,
                ),
              ),
              const SizedBox(width: 20), // Increased spacing
              
              // Messages button
              GestureDetector(
                onTap: () => _showComingSoonSnackbar(
                  context, 
                  AppStrings.messagesComingSoon
                ),
                child: Stack(
                  clipBehavior: Clip.none, // Allow indicator to overflow
                  children: [
                    const Icon(
                      Icons.chat_bubble_outline,
                      size: 24,
                    ),
                    // Unread indicator
                    Positioned(
                      right: -2,
                      top: -2,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}