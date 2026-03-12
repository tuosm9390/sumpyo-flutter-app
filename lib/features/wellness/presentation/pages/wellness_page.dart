import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/sumpyo_colors.dart';
import '../../../../core/utils/string_utils.dart';
import '../../../home/presentation/widgets/sumpyo_app_bar.dart';
import '../../../../shared/widgets/sumpyo_card.dart';
import '../../../../shared/widgets/floating_motion.dart';
import '../providers/wellness_provider.dart';
import '../../domain/entities/wellness_mission.dart';

class WellnessPage extends ConsumerWidget {
  const WellnessPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final missions = ref.watch(wellnessNotifierProvider);
    
    final WellnessMission uncompletedMission = missions.isEmpty 
        ? WellnessMission(id: '0', title: '미션이 없습니다', description: '', category: '', date: DateTime.now())
        : missions.firstWhere(
            (m) => !m.isCompleted,
            orElse: () => missions.first,
          );

    return Scaffold(
      backgroundColor: SumpyoColors.warmWhite,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          const SumpyoAppBar(),
          SliverToBoxAdapter(
            child: _MissionHero(mission: uncompletedMission),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 32),
            sliver: SliverToBoxAdapter(
              child: _WeeklyProgress(missions: missions),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final mission = missions[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _MissionItem(mission: mission),
                  );
                },
                childCount: missions.length,
              ),
            ),
          ),
          const SliverPadding(padding: EdgeInsets.only(bottom: 40)),
        ],
      ),
    );
  }
}

class _MissionHero extends StatelessWidget {
  final WellnessMission mission;
  const _MissionHero({required this.mission});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 340,
      decoration: BoxDecoration(
        color: SumpyoColors.sageGreen.withValues(alpha: 0.15),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(48),
          bottomRight: Radius.circular(48),
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: FloatingMotion(
              offset: 12,
              duration: const Duration(seconds: 4),
              child: SumpyoCard(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      StringUtils.keepAll('오늘의 마음 쉼표'),
                      style: TextStyle(
                        color: SumpyoColors.softCharcoal.withValues(alpha: 0.6),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      StringUtils.keepAll(mission.title),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.gowunBatang(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: SumpyoColors.softCharcoal,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      StringUtils.keepAll(mission.description),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 15,
                        color: SumpyoColors.softCharcoal,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WeeklyProgress extends StatelessWidget {
  final List<WellnessMission> missions;
  const _WeeklyProgress({required this.missions});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final last7Days = List.generate(7, (index) {
      final date = now.subtract(Duration(days: 6 - index));
      return DateTime(date.year, date.month, date.day);
    });

    return Column(
      children: [
        Text(
          StringUtils.keepAll('최근 7일간의 여정'),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: SumpyoColors.softCharcoal,
            fontFamily: 'Pretendard',
          ),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: last7Days.map((date) {
            final isToday = date.year == now.year && date.month == now.month && date.day == now.day;
            final hasCompleted = missions.any((m) {
              final mDate = DateTime(m.date.year, m.date.month, m.date.day);
              return m.isCompleted && mDate.isAtSameMomentAs(date);
            });

            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: hasCompleted 
                          ? SumpyoColors.sageGreen 
                          : SumpyoColors.paperBorder.withValues(alpha: 0.5),
                      border: isToday 
                          ? Border.all(color: SumpyoColors.sageGreen, width: 2)
                          : null,
                      boxShadow: hasCompleted ? [
                        BoxShadow(
                          color: SumpyoColors.sageGreen.withValues(alpha: 0.3),
                          blurRadius: 4,
                          spreadRadius: 1,
                        )
                      ] : null,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    isToday ? '오늘' : '${date.day}',
                    style: TextStyle(
                      fontSize: 11,
                      color: isToday ? SumpyoColors.sageGreen : SumpyoColors.softCharcoal.withValues(alpha: 0.4),
                      fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _MissionItem extends ConsumerWidget {
  final WellnessMission mission;
  const _MissionItem({required this.mission});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SumpyoCard(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      onTap: () => ref.read(wellnessNotifierProvider.notifier).toggleMission(mission.id),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  StringUtils.keepAll(mission.title),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: mission.isCompleted 
                        ? SumpyoColors.softCharcoal.withValues(alpha: 0.4) 
                        : SumpyoColors.softCharcoal,
                    decoration: mission.isCompleted ? TextDecoration.lineThrough : null,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  StringUtils.keepAll(mission.description),
                  style: TextStyle(
                    fontSize: 13,
                    color: SumpyoColors.softCharcoal.withValues(alpha: 0.5),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Animate(
            target: mission.isCompleted ? 1 : 0,
            effects: [
              ScaleEffect(
                begin: const Offset(1, 1), 
                end: const Offset(1.15, 1.15), 
                curve: Curves.elasticOut, 
                duration: 500.ms
              ),
              FadeEffect(begin: 0.6, end: 1.0, duration: 300.ms),
            ],
            child: Icon(
              mission.isCompleted ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded,
              color: mission.isCompleted ? SumpyoColors.sageGreen : SumpyoColors.paperBorder,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
