import 'dart:async';
import 'dart:math';
import '../models/post.dart';
import '../models/story.dart';
import '../models/user.dart';

class PostRepository {
  static const int _pageSize = 10;
  static const Duration _simulatedDelay = Duration(milliseconds: 1500);
  
  final List<String> _sampleImageUrls = [
    'https://images.unsplash.com/photo-1682687220742-aba13b6e50ba',
    'https://images.unsplash.com/photo-1682687221038-404cb8830901',
    'https://images.unsplash.com/photo-1682687220063-4742bd7fd538',
    'https://images.unsplash.com/photo-1682687220199-d0124f48f95b',
    'https://images.unsplash.com/photo-1682695795557-17447f921f80',
    'https://images.unsplash.com/photo-1682695797221-8164ff1fafc9',
  ];

  final List<User> _mockUsers = [
    User(id: '1', username: 'johndoe', profileImageUrl: 'https://randomuser.me/api/portraits/men/1.jpg'),
    User(id: '2', username: 'janesmith', profileImageUrl: 'https://randomuser.me/api/portraits/women/1.jpg'),
    User(id: '3', username: 'bobwilson', profileImageUrl: 'https://randomuser.me/api/portraits/men/2.jpg'),
    User(id: '4', username: 'alicebrown', profileImageUrl: 'https://randomuser.me/api/portraits/women/2.jpg'),
    User(id: '5', username: 'charlie_d', profileImageUrl: 'https://randomuser.me/api/portraits/men/3.jpg'),
  ];

  Future<List<Story>> getStories() async {
    await Future.delayed(_simulatedDelay);
    
    return _mockUsers.map((user) => Story(
      id: 'story_${user.id}',
      user: user,
      hasUnseenStory: Random().nextBool(),
      isLive: Random().nextBool() && Random().nextBool(),
    )).toList();
  }

  Future<List<Post>> fetchPosts({required int page, int limit = 10}) async {
    await Future.delayed(_simulatedDelay);
    
    // Simulate error for testing
    if (page > 3 && Random().nextBool()) {
      throw Exception('Failed to load posts');
    }
    
    return List.generate(limit, (index) {
      final userIndex = (page * limit + index) % _mockUsers.length;
      final user = _mockUsers[userIndex];
      
      // Generate random number of images (1-3 for carousel demo)
      final numImages = Random().nextInt(3) + 1;
      final imageUrls = List.generate(
        numImages, 
        (i) => _sampleImageUrls[(page * limit + index + i) % _sampleImageUrls.length]
      );
      
      return Post(
        id: 'post_${page}_$index',
        user: user,
        caption: 'This is a sample caption for post ${page * limit + index}. #flutter #instagram',
        timestamp: DateTime.now().subtract(Duration(hours: Random().nextInt(24))),
        imageUrls: imageUrls,
        likesCount: Random().nextInt(1000),
        isLiked: false,
        isSaved: false,
      );
    });
  }

  Stream<List<Post>> getPostsStream() async* {
    int page = 0;
    while (true) {
      yield await fetchPosts(page: page);
      page++;
      await Future.delayed(const Duration(seconds: 2));
    }
  }
}