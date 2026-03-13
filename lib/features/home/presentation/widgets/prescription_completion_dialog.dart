import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/sumpyo_colors.dart';
import '../../../../core/utils/string_utils.dart';
import '../../domain/entities/prescription.dart';

class PrescriptionCompletionDialog extends StatelessWidget {
  final Prescription prescription;

  const PrescriptionCompletionDialog({
    super.key,
    required this.prescription,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF2C2C2C) : Colors.white,
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 30,
              offset: const Offset(0, 15),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: SumpyoColors.sageGreen.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle_rounded,
                color: SumpyoColors.sageGreen,
                size: 48,
              ),
            ).animate().scale(duration: 400.ms, curve: Curves.easeOutBack),
            const SizedBox(height: 24),
            Text(
              StringUtils.keepAll('처방전 조제 완료'),
              style: theme.textTheme.displaySmall?.copyWith(fontSize: 22),
            ).animate().fadeIn(delay: 200.ms),
            const SizedBox(height: 12),
            Text(
              StringUtils.keepAll('당신만을 위한 따뜻한 위로가 준비되었습니다.'),
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
              textAlign: TextAlign.center,
            ).animate().fadeIn(delay: 400.ms),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color:
                    isDark ? const Color(0xFF383838) : const Color(0xFFF8FBF8),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: SumpyoColors.sageGreen.withValues(alpha: 0.1),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    StringUtils.keepAll('오늘의 처방'),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: SumpyoColors.sageGreen,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    StringUtils.keepAll(prescription.title),
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
                .animate()
                .slideY(begin: 0.1, end: 0, delay: 600.ms)
                .fadeIn(delay: 600.ms),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: SumpyoColors.sageGreen,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  StringUtils.keepAll('처방전 확인하기'),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ).animate().fadeIn(delay: 800.ms),
          ],
        ),
      ),
    ).animate().scale(duration: 300.ms, curve: Curves.easeOutBack);
  }
}
