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

  void _showNewArrivalDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        backgroundColor: SumpyoColors.warmWhite,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: SumpyoColors.sageGreen.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.auto_awesome,
                  color: SumpyoColors.sageGreen,
                  size: 40,
                ),
              ).animate().scale(delay: 200.ms, curve: Curves.easeOutBack),
              const SizedBox(height: 24),
              Text(
                StringUtils.keepAll('새로운 마음 쉼표'),
                style: GoogleFonts.gowunBatang(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: SumpyoColors.softCharcoal,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                StringUtils.keepAll('오늘의 추천 미션이 도착했습니다.\n차분한 마음으로 시작해볼까요?'),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: SumpyoColors.softCharcoal.withValues(alpha: 0.7),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    ref.read(wellnessNotifierProvider.notifier).markAsNotified();
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: SumpyoColors.sageGreen,
                    foregroundColor: SumpyoColors.warmWhite,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    StringUtils.keepAll('확인'),
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wellnessState = ref.watch(wellnessNotifierProvider);
    final missions = wellnessState.missions;

    ref.listen(wellnessNotifierProvider.select((s) => s.hasNewArrival), (prev, next) {
      if (next) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _showNewArrivalDialog(context, ref);
        });
      }
    });

    final WellnessMission uncompletedMission = missions.isEmpty
        ? WellnessMission(
            id: '0',
            title: '미션이 없습니다',
            description: '',
            category: '',
            date: DateTime.now())
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
              child: _WeeklyProgress(
                completedHistory: wellnessState.completedHistoryDates,
              ),
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

class _WeeklyProgress extends ConsumerWidget {
  final Set<String> completedHistory;
  const _WeeklyProgress({required this.completedHistory});

  String _formatToKey(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(wellnessNotifierProvider.notifier);
    final logicalToday = notifier.getLogicalToday();
    
    final last7Days = List.generate(7, (index) {
      final date = logicalToday.subtract(Duration(days: 6 - index));
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
            final dateKey = _formatToKey(date);
            final isToday = dateKey == _formatToKey(logicalToday);
            final hasCompleted = completedHistory.contains(dateKey);

            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 6),
              child: Column(
                children: [
                  Container(
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: hasCompleted
                          ? SumpyoColors.sageGreen
                          : SumpyoColors.paperBorder.withValues(alpha: 0.5),
                      border: isToday
                          ? Border.all(color: SumpyoColors.sageGreen, width: 2)
                          : null,
                      boxShadow: hasCompleted
                          ? [
                              BoxShadow(
                                color: SumpyoColors.sageGreen.withValues(alpha: 0.3),
                                blurRadius: 4,
                                spreadRadius: 1,
                              )
                            ]
                          : null,
                    ),
                    child: hasCompleted 
                      ? const Icon(Icons.check, size: 12, color: Colors.white)
                      : null,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    isToday ? '오늘' : "${date.month}/${date.day}",
                    style: TextStyle(
                      fontSize: 10,
                      color: isToday
                          ? SumpyoColors.sageGreen
                          : SumpyoColors.softCharcoal.withValues(alpha: 0.4),
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
    final logicalToday = ref.read(wellnessNotifierProvider.notifier).getLogicalToday();
    final isToday = mission.date.year == logicalToday.year && 
                    mission.date.month == logicalToday.month && 
                    mission.date.day == logicalToday.day;

    return SumpyoCard(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      onTap: isToday ? () =>
          ref.read(wellnessNotifierProvider.notifier).toggleMission(mission.id) : null,
      child: Opacity(
        opacity: isToday ? 1.0 : 0.5,
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
                      decoration:
                          mission.isCompleted ? TextDecoration.lineThrough : null,
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
                    duration: 500.ms),
                FadeEffect(begin: 0.6, end: 1.0, duration: 300.ms),
              ],
              child: Icon(
                mission.isCompleted
                    ? Icons.check_circle_rounded
                    : Icons.radio_button_unchecked_rounded,
                color: mission.isCompleted
                    ? SumpyoColors.sageGreen
                    : SumpyoColors.paperBorder,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
