import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../data/models/prescription_model.dart';
import '../../../../core/theme/sumpyo_colors.dart';
import '../../../../core/utils/string_utils.dart';

class EmotionChartWidget extends StatelessWidget {
  final List<PrescriptionModel> prescriptions;

  const EmotionChartWidget({super.key, required this.prescriptions});

  @override
  Widget build(BuildContext context) {
    if (prescriptions.isEmpty) {
      return const SizedBox.shrink();
    }

    int fCount = 0;
    int tCount = 0;
    int wCount = 0;

    for (var p in prescriptions) {
      if (p.style == 'F') {
        fCount++;
      } else if (p.style == 'T') {
        tCount++;
      } else if (p.style == 'W') {
        wCount++;
      }
    }

    final total = prescriptions.length;
    final fPct = (fCount / total) * 100;
    final tPct = (tCount / total) * 100;
    final wPct = (wCount / total) * 100;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: SumpyoColors.warmWhite,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: SumpyoColors.paperBorder),
        boxShadow: [
          BoxShadow(
            color: SumpyoColors.softCharcoal.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            StringUtils.keepAll('나의 마음 처방 통계'),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: SumpyoColors.softCharcoal,
                ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 200,
            child: PieChart(
              PieChartData(
                sectionsSpace: 4,
                centerSpaceRadius: 40,
                sections: [
                  if (fCount > 0)
                    PieChartSectionData(
                      color: SumpyoColors.sageGreen.withValues(alpha: 0.8),
                      value: fCount.toDouble(),
                      title: '${fPct.toStringAsFixed(0)}%',
                      radius: 50,
                      titleStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  if (tCount > 0)
                    PieChartSectionData(
                      color: SumpyoColors.muteBlue.withValues(alpha: 0.8),
                      value: tCount.toDouble(),
                      title: '${tPct.toStringAsFixed(0)}%',
                      radius: 50,
                      titleStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  if (wCount > 0)
                    PieChartSectionData(
                      color: SumpyoColors.errorRed.withValues(alpha: 0.6),
                      value: wCount.toDouble(),
                      title: '${wPct.toStringAsFixed(0)}%',
                      radius: 50,
                      titleStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 16,
            runSpacing: 8,
            children: [
              _buildLegendItem(context, StringUtils.keepAll('공감형 (F)'),
                  SumpyoColors.sageGreen.withValues(alpha: 0.8)),
              _buildLegendItem(context, StringUtils.keepAll('이성형 (T)'),
                  SumpyoColors.muteBlue.withValues(alpha: 0.8)),
              _buildLegendItem(context, StringUtils.keepAll('온기형 (W)'),
                  SumpyoColors.errorRed.withValues(alpha: 0.6)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(BuildContext context, String text, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }
}
