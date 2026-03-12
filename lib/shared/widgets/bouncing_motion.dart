import 'package:flutter/material.dart';

class BouncingMotion extends StatefulWidget {
  final Widget child;
  final double scaleDown;
  final Duration duration;

  const BouncingMotion({
    super.key,
    required this.child,
    this.scaleDown = 0.9,
    this.duration = const Duration(milliseconds: 600),
  });

  @override
  State<BouncingMotion> createState() => _BouncingMotionState();
}

class _BouncingMotionState extends State<BouncingMotion> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 1.0, end: widget.scaleDown).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticIn),
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
        return Transform.scale(
          scale: _animation.value,
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
