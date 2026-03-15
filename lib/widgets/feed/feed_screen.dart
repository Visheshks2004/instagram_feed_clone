import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/feed_provider.dart';
import '../shared/shimmer_effect.dart';
import 'top_bar.dart';
import 'stories_tray.dart';
import 'post_card.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FeedProvider>().loadInitialData();
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 500) {
      context.read<FeedProvider>().loadMorePosts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Consumer<FeedProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return const _ShimmerFeed();
            }

            if (provider.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 48, color: Colors.grey),
                    const SizedBox(height: 16),
                    Text('Error: ${provider.errorMessage}'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        provider.refreshFeed();
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: () => provider.loadInitialData(),
              child: CustomScrollView(
                controller: _scrollController,
                slivers: [
                  // Top Bar - Now above stories
                  SliverToBoxAdapter(
                    child: const TopBar(),
                  ),
                  
                  // Stories Tray
                  SliverToBoxAdapter(
                    child: StoriesTray(stories: provider.stories),
                  ),
                  
                  // Posts
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        if (index >= provider.posts.length) {
                          if (provider.isLoadingMore) {
                            return const Padding(
                              padding: EdgeInsets.all(16),
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        }
                        
                        return PostCard(post: provider.posts[index]);
                      },
                      childCount: provider.posts.length + (provider.isLoadingMore ? 1 : 0),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ShimmerFeed extends StatelessWidget {
  const _ShimmerFeed();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        
        const SliverToBoxAdapter(
          child: TopBar(),
        ),
        
        
        SliverToBoxAdapter(
          child: Container(
            height: 105,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, storyIndex) {
                return Container(
                  width: 68,
                  margin: const EdgeInsets.only(right: 6),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ShimmerEffect(
                        child: Container(
                          width: 64,
                          height: 64,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      ShimmerEffect(
                        child: Container(
                          width: 40,
                          height: 14,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        
        
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => const ShimmerPostCard(),
            childCount: 3,
          ),
        ),
      ],
    );
  }
}