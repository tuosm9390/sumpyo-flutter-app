import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'bouncing_motion.dart';
import '../../core/theme/sumpyo_colors.dart';

class SumpyoLoadingIndicator extends StatelessWidget {
  final double size;
  
  const SumpyoLoadingIndicator({
    super.key,
    this.size = 60,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BouncingMotion(
            scaleDown: 0.8,
            duration: const Duration(milliseconds: 400),
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  Icons.favorite,
                  color: Theme.of(context).colorScheme.primary,
                  size: size * 0.5,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "마음을 달래는 약을 짓는 중...",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: SumpyoColors.softCharcoal.withValues(alpha: 0.6),
            ),
          ).animate(onPlay: (controller) => controller.repeat())
           .fade(duration: 1.seconds)
           .then()
           .fade(begin: 1, end: 0, duration: 1.seconds),
        ],
      ),
    );
  }
}

