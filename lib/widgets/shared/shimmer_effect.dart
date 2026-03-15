import 'dart:math';

import 'package:flutter/material.dart';

class ShimmerEffect extends StatefulWidget {
  final Widget child;
  
  const ShimmerEffect({Key? key, required this.child}) : super(key: key);

  @override
  _ShimmerEffectState createState() => _ShimmerEffectState();
}

class _ShimmerEffectState extends State<ShimmerEffect> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
    
    _animation = Tween<double>(begin: -1.5, end: 1.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Colors.grey[300]!,
                Colors.grey[100]!,
                Colors.grey[300]!,
              ],
              stops: [
                max(0.0, _animation.value - 0.5),
                _animation.value,
                min(1.0, _animation.value + 0.5),
              ],
            ).createShader(bounds);
          },
          blendMode: BlendMode.srcATop,
          child: widget.child,
        );
      },
    );
  }
}

class ShimmerPostCard extends StatelessWidget {
  const ShimmerPostCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header shimmer
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                ShimmerEffect(
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ShimmerEffect(
                  child: Container(
                    width: 100,
                    height: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          // Image shimmer
          ShimmerEffect(
            child: Container(
              height: 400,
              color: Colors.white,
            ),
          ),
          // Actions shimmer
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                ShimmerEffect(
                  child: Container(
                    width: 24,
                    height: 24,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 16),
                ShimmerEffect(
                  child: Container(
                    width: 24,
                    height: 24,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 16),
                ShimmerEffect(
                  child: Container(
                    width: 24,
                    height: 24,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}