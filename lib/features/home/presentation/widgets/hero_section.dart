import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/sumpyo_colors.dart';
import '../../../../core/utils/greeting_utils.dart';
import '../../../../core/network/sun_time_service.dart';

class HeroSection extends ConsumerWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    // 일출/일몰 데이터 구독
    final sunTimeAsync = ref.watch(sunTimeNotifierProvider);
    final sunData = sunTimeAsync.valueOrNull;

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        GreetingUtils.getGreeting(
                          sunrise: sunData?.sunrise,
                          sunset: sunData?.sunset,
                        ),
                        style: GoogleFonts.gowunBatang(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          height: 1.4,
                          color:
                              isDark ? Colors.white : SumpyoColors.softCharcoal,
                        ),
                      )
                          .animate()
                          .fadeIn(duration: 800.ms)
                          .slideY(begin: 0.1, end: 0),
                      const SizedBox(height: 12),
                      Text(
                        GreetingUtils.getSubGreeting(
                          sunrise: sunData?.sunrise,
                          sunset: sunData?.sunset,
                        ),
                        style: const TextStyle(
                          fontFamily: 'Pretendard',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: SumpyoColors.muteBlue,
                        ),
                      ).animate().fadeIn(delay: 400.ms, duration: 800.ms),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Image.asset(
                  'assets/sumpyo_ai_icon.png',
                  width: 64,
                  height: 64,
                )
                    .animate(
                        onPlay: (controller) =>
                            controller.repeat(reverse: true))
                    .moveY(
                        begin: 0,
                        end: -12,
                        duration: 1500.ms,
                        curve: Curves.easeInOutSine)
                    .fadeIn(duration: 1000.ms),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
