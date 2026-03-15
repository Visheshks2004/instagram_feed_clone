import 'dart:async';
import 'package:flutter/material.dart';
import '../models/post.dart';
import '../models/story.dart';
import '../repositories/post_repository.dart';

class FeedProvider extends ChangeNotifier {
  final PostRepository _repository = PostRepository();
  
  List<Post> _posts = [];
  List<Story> _stories = [];
  bool _isLoading = false;
  bool _isLoadingMore = false;
  bool _hasError = false;
  String? _errorMessage;
  int _currentPage = 0;
  bool _hasReachedMax = false;
  
  List<Post> get posts => _posts;
  List<Story> get stories => _stories;
  bool get isLoading => _isLoading;
  bool get isLoadingMore => _isLoadingMore;
  bool get hasError => _hasError;
  String? get errorMessage => _errorMessage;

  Future<void> loadInitialData() async {
    _isLoading = true;
    _hasError = false;
    notifyListeners();
    
    try {
      // Load stories and first page of posts in parallel
      final results = await Future.wait([
        _repository.getStories(),
        _repository.fetchPosts(page: 0),
      ]);
      
      _stories = results[0] as List<Story>;
      _posts = results[1] as List<Post>;
      _currentPage = 0;
      _hasError = false;
    } catch (e) {
      _hasError = true;
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadMorePosts() async {
    if (_isLoadingMore || _hasReachedMax) return;
    
    _isLoadingMore = true;
    notifyListeners();
    
    try {
      final nextPage = _currentPage + 1;
      final newPosts = await _repository.fetchPosts(page: nextPage);
      
      if (newPosts.isEmpty) {
        _hasReachedMax = true;
      } else {
        _posts.addAll(newPosts);
        _currentPage = nextPage;
      }
    } catch (e) {
      _hasError = true;
      _errorMessage = e.toString();
    } finally {
      _isLoadingMore = false;
      notifyListeners();
    }
  }

  void toggleLike(String postId) {
    final index = _posts.indexWhere((post) => post.id == postId);
    if (index != -1) {
      final post = _posts[index];
      _posts[index] = post.copyWith(
        isLiked: !post.isLiked,
        likesCount: post.isLiked ? post.likesCount - 1 : post.likesCount + 1,
      );
      notifyListeners();
    }
  }

  void toggleSave(String postId) {
    final index = _posts.indexWhere((post) => post.id == postId);
    if (index != -1) {
      final post = _posts[index];
      _posts[index] = post.copyWith(isSaved: !post.isSaved);
      notifyListeners();
    }
  }

  void refreshFeed() {
    loadInitialData();
  }
}