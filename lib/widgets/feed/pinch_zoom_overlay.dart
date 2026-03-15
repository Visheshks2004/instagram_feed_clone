import 'package:flutter/material.dart';

class PinchZoomOverlay extends StatefulWidget {
  final Widget child;
  final String imageUrl;

  const PinchZoomOverlay({
    super.key,
    required this.child,
    required this.imageUrl,
  });

  @override
  _PinchZoomOverlayState createState() => _PinchZoomOverlayState();
}

class _PinchZoomOverlayState extends State<PinchZoomOverlay>
    with SingleTickerProviderStateMixin {
  double _scale = 1.0;
  double _previousScale = 1.0;
  Offset _offset = Offset.zero;
  Offset _previousOffset = Offset.zero;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutBack,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleScaleStart(ScaleStartDetails details) {
    _previousScale = _scale;
    _previousOffset = _offset;
  }

  void _handleScaleUpdate(ScaleUpdateDetails details) {
    setState(() {
      _scale = (_previousScale * details.scale).clamp(1.0, 3.0);
      
      if (_scale > 1.0) {
        _offset = _previousOffset + details.focalPoint - details.focalPoint;
        
        
        if (details.pointerCount == 2) {
          _offset += details.focalPointDelta;
        }
        
      
        final maxOffset = 100.0 * (_scale - 1);
        _offset = Offset(
          _offset.dx.clamp(-maxOffset, maxOffset),
          _offset.dy.clamp(-maxOffset, maxOffset),
        );
      }
    });
  }

  void _handleScaleEnd(ScaleEndDetails details) {
    if (_scale > 1.0) {
      _animationController.forward(from: 0.0);
      _animation.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            _scale = 1.0;
            _offset = Offset.zero;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onScaleStart: _handleScaleStart,
      onScaleUpdate: _handleScaleUpdate,
      onScaleEnd: _handleScaleEnd,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scale,
            child: Transform.translate(
              offset: _offset,
              child: widget.child,
            ),
          );
        },
      ),
    );
  }
}