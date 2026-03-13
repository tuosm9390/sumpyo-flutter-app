import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../../core/theme/sumpyo_colors.dart';

class SumpyoAppBar extends StatelessWidget {
  const SumpyoAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final baseColor = isDark ? const Color(0xFF2C2C2C) : SumpyoColors.warmWhite;

    return SliverAppBar(
      pinned: true,
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.transparent,
      toolbarHeight: 100,
      flexibleSpace: Stack(
        children: [
          ShaderMask(
            shaderCallback: (rect) {
              return LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black, Colors.black.withValues(alpha: 0)],
                stops: const [0.5, 1.0], // 상단 50% 지점까지 완전 불투명 블러 적용
              ).createShader(rect);
            },
            blendMode: BlendMode.dstIn,
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        baseColor.withValues(alpha: 0.95),
                        baseColor.withValues(alpha: 0.4),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 60, // 상단 경계를 더 넓게 보호
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  baseColor,
                  baseColor.withValues(alpha: 0),
                ],
              ),
            ),
          ),
        ],
      ),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/sumpyo_ai_icon.png',
            height: 24,
          ),
          const SizedBox(width: 8),
          Text(
            'SUMPYO',
            style: TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 14,
              fontWeight: FontWeight.w800,
              letterSpacing: 2.5,
              color: isDark ? Colors.white : SumpyoColors.softCharcoal,
            ),
          ),
        ],
      ),
      centerTitle: true,
    );
  }
}
